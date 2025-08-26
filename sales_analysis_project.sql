-- ### Monthly Sales Summary by Product Subcategory
-- This query calculates the total sales, order quantity, and distinct order count per product subcategory for each month.
WITH raw_data AS (
  SELECT
    sale_det.SalesOrderID,
    sale_det.OrderQty,
    sub.Name AS sub_category_name,
    sale_det.ModifiedDate,
    sale_det.LineTotal
  FROM `adventureworks2019.Production.Product` prod
  JOIN `adventureworks2019.Production.ProductSubcategory` sub
    ON  SAFE_CAST(prod.ProductSubcategoryID AS INT) = sub.ProductSubcategoryID
  JOIN `adventureworks2019.Sales.SalesOrderDetail` sale_det
    ON prod.ProductID = sale_det.ProductID)
SELECT
  FORMAT_DATE('%b %Y', ModifiedDate) AS period,
  sub_category_name AS name,
  SUM(OrderQty) AS qty_item,
  SUM(LineTotal) AS total_sales,
  COUNT(DISTINCT(SalesOrderID)) AS order_cnt
FROM raw_data
GROUP BY period, sub_category_name
ORDER BY period DESC, sub_category_name;

-- **Observation:**
-- Monthly performance metrics help identify subcategories that contribute most to sales. Businesses can use this to optimize inventory.

-- ### Yearly Sales Growth Analysis by Subcategory
WITH raw_data AS (
  SELECT
    sale_det.SalesOrderID,
    sale_det.OrderQty,
    sub.Name AS sub_category_name,
    sale_det.ModifiedDate,
    EXTRACT(YEAR FROM sale_det.ModifiedDate) AS year,
    sale_det.LineTotal
  FROM `adventureworks2019.Production.Product` prod
  JOIN `adventureworks2019.Production.ProductSubcategory` sub
    ON  SAFE_CAST(prod.ProductSubcategoryID AS INT) = sub.ProductSubcategoryID
  JOIN `adventureworks2019.Sales.SalesOrderDetail` sale_det
    ON prod.ProductID = sale_det.ProductID)
SELECT
  *,
  ROUND(((qty_item - prev_qty) / prev_qty), 2) AS qty_diff
FROM (
      SELECT 
        sub_category_name AS name,
        SUM(OrderQty) AS qty_item,
        LAG(SUM(OrderQty)) OVER(PARTITION BY sub_category_name ORDER BY year) AS prev_qty
      FROM raw_data
      GROUP BY sub_category_name, year)
WHERE prev_qty IS NOT NULL
ORDER BY qty_diff DESC
LIMIT 3;

-- **Observation:**
-- This analysis identifies the subcategories with the highest growth rates, supporting strategic marketing campaigns.

-- ### Top Territories by Order Volume
WITH raw_data AS (
  SELECT 
    EXTRACT(YEAR FROM sale_det.ModifiedDate) AS year,
    TerritoryID,
    SUM(OrderQty) AS order_cnt
  FROM `adventureworks2019.Sales.SalesOrderDetail` sale_det
  LEFT JOIN `adventureworks2019.Sales.SalesOrderHeader` sale_head
    USING(SalesOrderID)
  LEFT JOIN `adventureworks2019.Sales.SalesTerritory` sale_terri
    USING(TerritoryID)
  GROUP BY year, TerritoryID),
ranking AS (
  SELECT
    *,
    DENSE_RANK() OVER(PARTITION BY year ORDER BY order_cnt DESC) AS rnk
  FROM raw_data)
SELECT *
FROM ranking
WHERE rnk BETWEEN 1 AND 3
ORDER BY year;

-- **Observation:**
-- This query highlights the territories with the highest sales, helping prioritize regional sales strategies.

-- ### Total Discount Costs by Subcategory
WITH raw_data AS (
  SELECT
    EXTRACT(YEAR FROM sales_det.ModifiedDate) AS year,
    sub.Name AS name,
    SalesOrderID,
    sales_det.SpecialOfferID,
    Type,
    OrderQty,
    UnitPrice,
    DiscountPct,
    (DiscountPct * UnitPrice * OrderQty) AS discount_cost
  FROM `adventureworks2019.Sales.SalesOrderDetail` sales_det
  INNER JOIN `adventureworks2019.Sales.SpecialOffer` spc_offer
    ON sales_det.SpecialOfferID = spc_offer.SpecialOfferID
    AND type = 'Seasonal Discount'
  JOIN `adventureworks2019.Production.Product` prod
    ON prod.ProductID = sales_det.ProductID
  JOIN `adventureworks2019.Production.ProductSubcategory` sub
    ON SAFE_CAST(prod.ProductSubcategoryID AS INT) = sub.ProductSubcategoryID)
SELECT
  year,
  name,
  SUM(discount_cost) AS total_cost
FROM raw_data
GROUP BY year, name
ORDER BY year;

-- **Observation:**
-- This query measures the financial impact of discounts on various product subcategories to refine discount strategies.

-- ### Tracking New Customers by Month
WITH raw_data AS (
  SELECT
    EXTRACT(MONTH FROM ModifiedDate) AS mth,
    ModifiedDate,
    CustomerID,
    SalesOrderID
  FROM `adventureworks2019.Sales.SalesOrderHeader` 
  WHERE EXTRACT(YEAR FROM ModifiedDate) = 2014 
    AND Status = 5),
row_nb AS (
  SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY ModifiedDate) AS rn
  FROM raw_data),
new_customers AS (
  SELECT
    mth,
    CustomerID
  FROM row_nb
  WHERE rn = 1
  ORDER BY mth),
joining AS (
SELECT
  r.mth,
  r.CustomerID,
  c.mth AS mth_join,
  CONCAT('M - ', r.mth - c.mth) AS mth_diff
FROM raw_data r
LEFT JOIN new_customers c
  ON r.CustomerID = c.CustomerID)
SELECT
  mth_join,
  mth_diff,
  COUNT(DISTINCT(CustomerID)) AS customer_cnt
FROM joining
GROUP BY mth_join, mth_diff
ORDER BY mth_join, mth_diff;

-- **Observation:**
-- Helps track customer acquisition trends over months, enabling retention strategies.

