eBay Perfume Sales Analysis (SQL + Power BI)
 Project Overview

This project analyzes eBay perfume sales data to understand sales performance, inventory efficiency, and demand patterns across brands, categories, and locations.
The analysis focuses on identifying top-performing brands, inventory risks, and actionable business insights using SQL and Power BI.

 Dataset Description

The dataset consists of two raw tables sourced from Kaggle:

ebay_mens_perfume

ebay_womens_perfume

Each table contains the following columns:

brand

brand_type

title

price

sold

available

item_location

last_updated

 Data Cleaning & Preparation

To enable accurate and consistent analysis, both datasets were cleaned and consolidated into a single table named perfume_clean.

Key cleaning steps:

Trimmed extra spaces from text fields

Converted numeric columns (price, sold, available) to proper data types

Handled missing values using NULL logic

Standardized inconsistent brand type values (EDP, EDT, EDC, etc.)

Added a gender column to distinguish men’s and women’s products

Combined both datasets using UNION ALL

This cleaned table was used as the primary source for all analysis and dashboards.

 Analysis Approach (SQL)

SQL was used to answer key business questions such as:

Which brands generate the highest sales volume and revenue?

Which products show low sales but high inventory risk?

How efficiently are brands converting inventory (sell-through %)?

Which locations and categories should be prioritized?

Advanced SQL concepts applied:

Aggregations

CASE statements

Subqueries

Window functions

Inventory risk logic

 Power BI Dashboard

The cleaned data was connected to Power BI to build an interactive dashboard with:

Dashboard Sections:

Top KPIs: Total Revenue, Units Sold, Active Listings, Sell-Through %

Demand Analysis: Top brands by units sold

Inventory Risk: High stock & low sales detection

Efficiency: Sell-through % by brand

Prioritization: Preferred locations and categories

Interactivity: Slicers for Gender, Brand Type, Location

The dashboard allows stakeholders to dynamically explore data and identify action areas.

 Key Insights

Sales demand is concentrated among a few top brands

Some brands show high inventory levels with relatively low sales, indicating overstock risk

Revenue is heavily driven by specific locations, while missing location data highlights data quality gaps

Sell-through rates are relatively consistent across top brands, suggesting similar inventory efficiency

 Tools & Technologies

SQL (MySQL) – Data cleaning, transformation, and analysis

Power BI – Dashboard design and storytelling

Excel / CSV – Source data format

GitHub – Project documentation and version control

 Repository Structure
├── sql/
│   ├── raw_tables.sql
│   ├── data_cleaning.sql
│   ├── analysis_queries.sql
├── powerbi/
│   ├── dashboard_screenshots/
│   └── perfume_dashboard.pbix
├── README.md

 Learning Outcome

This project strengthened my understanding of:

End-to-end data analysis workflow

Writing clean and structured SQL

Translating data into business-focused insights

Designing dashboards for decision-making











