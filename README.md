# AdventureWorks Sales Analysis

## 🚀 Overview

This project demonstrates the use of SQL to analyze sales data from the AdventureWorks2019 database and Google Analytics datasets. By leveraging advanced SQL techniques, the project uncovers key business insights, including sales trends, customer acquisition patterns, inventory management metrics, and the effectiveness of promotions. The analysis helps inform data-driven decision-making to optimize business performance.

---

## 🔄 Project Details

- **Platform**: Google BigQuery
- **Schema Reference**: [Google Analytics Schema](https://support.google.com/analytics/answer/3437719?hl=en)
- **SQL Format Elements**: [BigQuery Standard SQL](https://cloud.google.com/bigquery/docs/reference/standard-sql/format-elements)
- **My BigQuery Project Link**: [AdventureWorks Sales Analysis Project](https://console.cloud.google.com/bigquery?sq=96321305112:ec7c7ec038c546edb6ca3b88c2944115)

---

## 🔎 Key Objectives

1. Analyze monthly and yearly sales trends.
2. Identify high-performing subcategories and regions.
3. Evaluate the financial impact of discounts and promotions.
4. Track customer acquisition and retention over time.
5. Optimize inventory by comparing stock levels to sales.
6. Visualize product category hierarchies and sales contributions.

---

## 🔧 SQL Skills Demonstrated

- **Window Functions**: For calculations such as growth rates, ranks, and time-based metrics (e.g., `LAG`, `ROW_NUMBER`, `DENSE_RANK`).
- **Common Table Expressions (CTEs)**: Simplify complex queries and improve readability.
- **Date and Time Functions**: Analyze trends over time using functions like `EXTRACT` and `FORMAT_DATE`.
- **Conditional Aggregation**: Create calculated metrics like conversion rates using `CASE` statements.
- **Joins**: Combine multiple tables to derive meaningful insights.
- **Recursive Queries**: Build hierarchies, such as product category relationships.

---

## 🔢 Queries Included

### 1. Monthly Sales Summary by Product Subcategory
Summarizes total sales, order quantities, and distinct order counts by product subcategory for each month.

### 2. Yearly Sales Growth by Subcategory
Identifies the subcategories with the highest growth rates, providing insights for strategic decision-making.

### 3. Top Territories by Order Volume
Ranks territories based on order volumes, highlighting regions with the highest performance.

### 4. Total Discount Costs by Subcategory
Calculates the financial impact of discounts for various subcategories.

### 5. Tracking New Customers by Month
Tracks new customer acquisition trends to aid retention and marketing strategies.

### 6. Stock Levels and Monthly Changes
Analyzes monthly stock changes to ensure efficient inventory management.

### 7. Stock-to-Sales Ratio
Calculates the stock-to-sales ratio for each product to evaluate inventory efficiency.

### 8. Conversion Metrics from Google Analytics
Analyzes product view, add-to-cart, and purchase rates to understand customer behavior.

### 9. Product Category Hierarchy and Sales Contributions
Uses recursive queries to visualize product category relationships and calculates total sales per subcategory.

---

## 📊 Dataset

The project uses the following datasets:
- **AdventureWorks2019**: A fictional sales and manufacturing database provided by Microsoft, containing detailed sales, product, and customer data.
- **Google Analytics Public Data**: Sample data from Google's BigQuery public datasets, offering insights into eCommerce user behavior.

---

## 🕵️ Insights Gained

- Subcategories with the highest sales contributions.
- Regions driving the most sales.
- Effectiveness of promotions and discounts.
- Inventory efficiency and potential overstocking/understocking issues.
- Key trends in customer acquisition and retention.

---

## 📈 Conclusion

By analyzing trends, evaluating performance, and identifying key drivers of business success, this project serves as a blueprint for data-driven decision-making in sales and marketing.

---
## 📜 License

This project is for educational purposes only.

---

## 👩‍💻 Author

**Sapphie Nguyen**

---
