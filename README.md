# 🏗️ End-to-End SQL Data Warehouse & Analytics Project

An end-to-end SQL project that builds a **Medallion-architecture (Bronze → Silver → Gold)** data warehouse from raw CRM and ERP data, then layers on analytics for customer, product, and sales insights.

It covers the full journey from raw source data to business-ready insights, combining **Data Engineering (ETL, data modeling)** with **Data Analysis (SQL-based reporting)** in a single, practical workflow.

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Data Architecture](#-data-architecture)
- [Project Structure](#-project-structure)
- [Tech Stack](#-tech-stack)
- [Project Requirements](#-project-requirements)
  - [Building the Data Warehouse](#1-building-the-data-warehouse-data-engineering)
  - [BI: Analytics & Reporting](#2-bi-analytics--reporting-data-analysis)
- [How to Run](#-how-to-run)
- [Repository Diagrams](#-repository-diagrams)
- [About the Author](#-about-the-author)

---

## 🚀 Overview

This repository demonstrates a complete data warehousing and analytics workflow:

1. **Ingest** raw CRM and ERP data (as CSV files) into a **Bronze** layer, preserving the data exactly as received.
2. **Cleanse, standardize, and transform** the data into a **Silver** layer.
3. **Model** the data into a business-ready **Star Schema** in the **Gold** layer.
4. **Analyze** the Gold layer with SQL to generate customer, product, and sales insights.

---

## 🏛️ Data Architecture

The warehouse follows the **Medallion Architecture**:

![Medallion Data Architecture](Data%20Architecture%20(draw.io).jpg)



| Layer | Purpose | Object Type | Transformations |
|---|---|---|---|
| **Bronze** | Raw data landing zone, traceability | Tables | None — direct load from source |
| **Silver** | Clean, standardized data | Tables | Data cleansing, deduplication, standardization, enrichment |
| **Gold** | Business-ready, consumption layer | Views | Data integration, aggregation, business logic (Star Schema) |


---

## 📂 Project Structure

```
End-to-End-SQL-Data-Warehouse-And-Analytics-Project/
│
├── scripts/                                    # SQL scripts for the data warehouse (ETL)
│   ├── bronze/                                 # DDL + load scripts for the Bronze layer
│   ├── silver/                                 # DDL + transformation scripts for the Silver layer
│   └── gold/                                   # View scripts for the Gold layer (Star Schema)
│
├── analytics_script/                           # SQL scripts for analysis & reporting
│   └── sql_queries.sql                         # All exploration, EDA, and advanced analytics queries in one file
│
├── Data Architecture (draw.io).jpg             # Medallion architecture
├── Data Flow Diagram (draw.io).jpg             # End-to-end data flow across layers
├── Integration Model (draw.io).jpg             # CRM + ERP source integration model
├── Data Model (Star Schema) (draw.io).jpg      # Gold layer dimensional model

│
└── README.md                                   # Project documentation (this file)
```

---

## 🛠️ Tech Stack

- **Database:** Microsoft SQL Server
- **IDE:** SQL Server Management Studio (SSMS)
- **Modeling:** Draw.io — for architecture, data flow, integration and star schema diagrams
- **Version Control:** Git & GitHub

---

## 📋 Project Requirements

### 1. Building the Data Warehouse (Data Engineering)

**Objective:** Develop a modern data warehouse using SQL to consolidate CRM and ERP sales data, enabling analytical reporting and informed decision-making.

**Specifications:**
- **Data Sources:** Import data from two source systems (CRM and ERP), provided as CSV files.
- **Data Quality:** Cleanse and resolve data quality issues (nulls, duplicates, inconsistent formats) prior to analysis.
- **Integration:** Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope:** Focus on the latest dataset only — historization of data is not required.

### 2. BI: Analytics & Reporting (Data Analysis)

**Objective:** Develop SQL-based analytics to deliver detailed insights into:
- 👤 **Customer Behavior** — segmentation, activity, and demographics
- 📦 **Product Performance** — top/worst performing products, category trends
- 💰 **Sales Trends** — revenue over time, cumulative growth, part-to-whole analysis

These insights empower stakeholders with key business metrics, enabling strategic decision-making.

---

## ▶️ How to Run

1. **Set up the database:** Run the initialization script in `scripts/` to create the warehouse database and schemas (`bronze`, `silver`, `gold`).
2. **Load the Bronze layer:** Execute the DDL and load scripts in `scripts/bronze/` to ingest raw CRM/ERP CSVs.
3. **Build the Silver layer:** Execute the DDL and transformation scripts in `scripts/silver/` to clean and standardize the data.
4. **Build the Gold layer:** Execute the view scripts in `scripts/gold/` to create the Star Schema (dimension and fact views).
5. **Run the analytics:** Execute `analytics_script/sql_queries.sql` to generate exploratory and advanced business insights.

---

## 🖼️ Repository Diagrams

**Data Flow Diagram** — how data moves from source → Bronze → Silver → Gold
![Data Flow Diagram](Data%20Flow%20Diagram%20(draw.io).jpg)


**Integration Model** — how CRM and ERP source tables relate and integrate
![Integration Model](Integration%20Model%20(draw.io).jpg)


**Data Model (Star Schema)** — final dimensional model used for analytics
![Data Model (Star Schema)](Data%20Model%20(Star%20Schema)%20(draw.io).jpg)

---

# 📊 Business Insights & Recommendations


### Key Insights

* **Bikes drive the business:** 96.5% of revenue comes from bikes, with Road and Mountain Bikes contributing 83%+ of total sales.
* **Customer retention is low:** 63% of customers made only one purchase, while the top 20% generate 66% of revenue.
* **US & Australia lead:** Both markets contribute ~31% of total revenue, while Canada is the smallest at ~7%.
* **Core customers are 30–49:** This age group generates around 66% of total revenue.
* **Accessories have the highest margin:** 62.8% vs. 39.2% for Bikes and 40.2% for Clothing.
* **Sales grew strongly in 2013:** The January 2014 drop likely reflects incomplete data and should be validated.

### Recommendations

* **Increase accessory sales** through bike bundles and checkout upsells.
* **Improve retention** with loyalty programs, follow-ups, and maintenance reminders.
* **Protect top customers** with VIP rewards and personalized offers.
* **Prioritize Road & Mountain Bikes** for inventory and marketing.
* **Grow the Canadian market** through targeted pricing and marketing campaigns.
* **Validate incomplete/early data** before making decisions based on 2010–2011 and January 2014 results.


---

## 👨‍💻 About the Author

**Surajkumar Bevnale**
Data Analyst | SQL • Excel • Power BI • Python
B.Tech, Engineering Physics, IIT Ropar (2023–2027)

- 📫 Reach me at: surajk.b168@gmail.com
- 🔗 LinekdIn: [Surajkumar B](https://www.linkedin.com/in/skb168/)
---

