# 📊 E-Commerce Sales & Profitability Analytics Dashboard

An end-to-end **Data Analytics and Business Intelligence project** built using the Superstore dataset.

This project analyzes e-commerce sales, profitability, customers, products, discounts, regions, categories, and time-based performance using **Excel, MySQL, Python, Pandas, and Power BI**.

The project follows a complete analytics workflow:

**Dataset → Excel → MySQL → Python/Pandas → Power BI → Business Insights**

---

## 🎯 Project Objective

The objective of this project is to transform raw e-commerce transaction data into meaningful business insights and an interactive Power BI dashboard.

The analysis focuses on answering questions such as:

- How are sales and profit changing over time?
- Which categories generate the highest sales and profit?
- Which customers contribute the most sales?
- Which products are top performers?
- Which regions and sub-categories are most profitable?
- How does discount relate to profitability?
- Which areas generate losses?
- How are customers distributed based on their total sales?
- How does regional sales ranking change over time?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **Microsoft Excel** | Data cleaning, validation and initial analysis |
| **MySQL** | SQL-based analysis and business queries |
| **Python** | Exploratory Data Analysis |
| **Pandas** | Data manipulation and aggregation |
| **Matplotlib / Seaborn** | Data visualization |
| **Power BI** | Interactive dashboard and business intelligence |
| **DAX** | KPI measures and calculated columns |
| **GitHub** | Project documentation and version control |

---

## 📂 Dataset

The project uses the **Superstore dataset**, containing e-commerce transaction information such as:

- Order ID
- Order Date
- Customer ID
- Customer Name
- Product ID
- Product Name
- Category
- Sub-Category
- Region
- State
- City
- Segment
- Sales
- Quantity
- Discount
- Profit
- Ship Mode

The dataset contains **9,994 transaction records**.

---

# 🔄 Project Workflow

## 1. Excel – Data Cleaning & Validation

The dataset was first processed in Excel.

### Data Quality Checks

- Checked missing values
- Checked duplicate records
- Validated date fields
- Checked negative sales values
- Checked invalid quantities
- Checked discount ranges
- Retained negative profit records because they represent legitimate business losses

### Additional Columns Created

- **Year**
- **Month**
- **Profit Margin**

### Key KPIs

| KPI | Value |
|---|---:|
| Total Sales | 2,297,200.86 |
| Total Profit | 286,397.02 |
| Total Orders | 5,009 |
| Total Customers | 793 |
| Average Order Value | 458.61 |
| Overall Profit Margin | 12.47% |

---

# 2. MySQL – Business & SQL Analysis

The cleaned dataset was imported into MySQL.

Database:

`superstore_db`

Table:

`superstore`

SQL analysis included:

- `GROUP BY`
- `ORDER BY`
- `WHERE`
- `HAVING`
- `CASE WHEN`
- Common Table Expressions (CTEs)
- Window Functions
- `RANK()`
- `DENSE_RANK()`
- `ROW_NUMBER()`
- `LAG()`
- `LEAD()`
- Running totals
- Month-over-Month analysis
- Year-over-Year analysis
- Top-N analysis

### Example Business Analysis

The SQL analysis was used to identify:

- Top customers
- Top products
- Category performance
- Regional performance
- Monthly sales trends
- Monthly profit trends
- Customer rankings
- Running sales totals
- Month-over-Month sales changes
- Year-over-Year growth

---

# 3. Python – Exploratory Data Analysis

Python and Pandas were used for deeper exploratory analysis.

### Analysis Performed

- Category analysis
- Regional analysis
- Segment analysis
- Customer analysis
- Product analysis
- State-level analysis
- Monthly trends
- Discount vs Profit analysis
- Correlation analysis
- Pivot tables
- Customer segmentation
- Loss-making products
- Order-level analysis
- Average Order Value analysis

### Visualizations Created

- Category Sales
- Category Profit
- Year/Month Sales Trend
- Year/Month Profit Trend
- Top 10 Customers
- Top 10 Products
- Discount vs Profit
- Correlation Heatmap

---

# 4. Power BI – Interactive Dashboard

The final analysis was converted into an interactive two-page Power BI dashboard.

## 📌 Page 1 – Executive Overview

### KPI Cards

- Total Sales
- Total Profit
- Total Orders
- Total Customers
- Average Order Value
- Overall Profit Margin

### Interactive Filters

- Year
- Region
- Category
- Segment

### Visualizations

#### 📈 Sales & Profit Trend
Shows yearly changes in sales and profit.

#### 📊 Sales by Category
Compares total sales across:

- Technology
- Furniture
- Office Supplies

#### 📊 Profit by Category
Compares profitability across product categories.

#### 🗺️ Sales & Profit by City
Interactive city-level map showing sales and profitability.

#### 🌳 Sales Decomposition Analysis
Decomposes total sales through:

**Category → Sub-Category → Region**

#### 🎗️ Regional Sales Ranking Over Time
Shows how regional sales rankings change from 2014 to 2017.

---

# 📌 Page 2 – Customer, Product & Profitability Analysis

### 👥 Top Customers

Treemap showing the top customers based on total sales.

### 📦 Top Products by Sales

Horizontal bar chart showing the top 10 products by sales.

### 🍩 Customer Sales Segmentation

Customers are segmented into:

- Low
- Medium
- High

based on their total sales contribution.

### 🎯 Overall Profit Margin

Gauge showing the overall profit margin:

**12.47%**

### 🔵 Discount vs Profitability

Scatter plot analyzing the relationship between:

- Average Discount
- Average Profit
- Sub-Category
- Sales volume

### 🔥 Profitability Heatmap

A conditional-formatting matrix showing:

**Sub-Category × Region → Total Profit**

This makes profitable and loss-making combinations easy to identify.

### 📈 Monthly Sales & Profit Trend

Shows monthly sales and profit movement from:

**January 2014 → December 2017**

---

# 📊 Key Business Insights

### 1. Technology is the strongest overall category

Technology generates the highest overall sales and profit among the three major categories.

---

### 2. Furniture has comparatively weak profitability

Furniture generates substantial sales but significantly lower profit compared with Technology and Office Supplies.

This indicates that sales volume alone does not guarantee strong profitability.

---

### 3. Regional profitability varies by category

Technology performs strongly across Central, East and South regions.

However, in the West region, Office Supplies generates higher profit than Technology despite Technology having higher sales.

---

### 4. Central Furniture generates a loss

The Central region's Furniture category has negative profit.

This is an important area for further investigation into pricing, discounting, product mix and operating costs.

---

### 5. Sales show strong seasonal patterns

Higher sales are repeatedly observed around September, November and December.

The pattern suggests potential seasonal demand, which could be investigated further for inventory and sales planning.

---

### 6. Profit increased consistently across the years

Overall profit increased from 2014 through 2017.

Sales also increased substantially over the longer period, with 2017 achieving the highest annual sales and profit.

---

### 7. Discounts require careful monitoring

The analysis shows that some discount levels are associated with weaker or negative profitability.

However, this analysis identifies **association rather than causation** and should be combined with product-level and pricing analysis before making business decisions.

---

### 8. Some products and sub-categories generate losses

Negative-profit products and sub-categories were identified during the analysis.

These areas could be investigated further for:

- Discounting strategy
- Pricing
- Product costs
- Product mix
- Customer segment
- Regional performance

---

# 🧮 Key Power BI Measures

The dashboard uses DAX measures including:

- Total Sales
- Total Profit
- Total Orders
- Total Customers
- Average Order Value
- Overall Profit Margin

Example:

```DAX
Total Sales =
SUM(Superstore_Cleaned2[Sales])
