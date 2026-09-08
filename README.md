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
- [License](#-license)

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

![Medallion Data Architecture](Data_Architecture.jpg)

```
   CRM & ERP (CSV Files)
            │
            ▼
    🥉 BRONZE LAYER
   Raw data, loaded as-is
   (no transformations)
            │
            ▼
    🥈 SILVER LAYER
   Cleansed, standardized,
   and normalized data
            │
            ▼
    🥇 GOLD LAYER
   Business-ready data
   modeled as a Star Schema
            │
            ▼
  📊 Analytics & Reporting
 (Customer, Product, Sales)
```

| Layer | Purpose | Object Type | Transformations |
|---|---|---|---|
| **Bronze** | Raw data landing zone, traceability | Tables | None — direct load from source |
| **Silver** | Clean, standardized data | Tables | Data cleansing, deduplication, standardization, enrichment |
| **Gold** | Business-ready, consumption layer | Views | Data integration, aggregation, business logic (Star Schema) |

See the diagrams included in this repo for the full picture:
- `Data Flow Diagram (draw.io).jpg`
- `Integration Model (draw.io).jpg`
- `Data Model (Star Schema) (draw.io).jpg`

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
├── Data Flow Diagram (draw.io).jpg             # End-to-end data flow across layers
├── Data Model (Star Schema) (draw.io).jpg      # Gold layer dimensional model
├── Integration Model (draw.io).jpg             # CRM + ERP source integration model
│
└── README.md                                   # Project documentation (this file)
```

> **Note:** File names above reflect the standard convention used in this project. Update this section with the exact script names as the repository grows.

---

## 🛠️ Tech Stack

- **Database:** SQL Server / T-SQL (adjust if using another engine)
- **IDE:** SQL Server Management Studio (SSMS) / Azure Data Studio
- **Modeling:** Draw.io — for architecture, integration, and star schema diagrams
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
- **Documentation:** Provide clear documentation of the data model for both business stakeholders and analytics teams.

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

**Integration Model** — how CRM and ERP source tables relate and integrate
![Integration Model](Integration%20Model%20(draw.io).jpg)

**Data Flow Diagram** — how data moves from source → Bronze → Silver → Gold
![Data Flow Diagram](Data%20Flow%20Diagram%20(draw.io).jpg)

**Data Model (Star Schema)** — final dimensional model used for analytics
![Data Model (Star Schema)](Data%20Model%20(Star%20Schema)%20(draw.io).jpg)

---

## 📊 Key Insights & Findings

Numbers below were computed directly from the CRM/ERP source files (`cust_info`, `prd_info`, `sales_details`, `CUST_AZ12`, `LOC_A101`, `PX_CAT_G1V2`) after applying the same cleansing rules used in the Silver/Gold layers (deduplication, code standardization, and sales/price correction).

### 📌 Headline Numbers

| Metric | Value |
|---|---|
| Total Revenue | **$29.36M** across 60,398 line items / 27,659 orders |
| Sales Period | **Dec 2010 – Jan 2014** (37 full months + 2 partial edge months) |
| Avg Revenue per Customer | **$1,588** |
| Repeat Purchase Rate | **37.1%** (6,865 of 18,484 customers ordered 2+ times; 11,619 bought only once) |

### 📈 Monthly Revenue Trend

Revenue accelerates sharply from mid-2013 onward — **Q4 2013 alone (~$5.3M) is nearly as large as all of 2012 (~$5.8M).**

### 🧭 Key Insights

1. **Bikes dominate everything.** Bikes = $28.3M (96.5%) of revenue; Accessories ($700K) and Clothing ($340K) are rounding errors by comparison. Within bikes, **Road Bikes alone ($14.5M) outsell Mountain ($10.0M) and Touring ($3.8M) combined.**

2. **Geography is concentrated but balanced at the top.** The US ($9.16M) and Australia ($9.06M) are nearly tied as the top two markets, followed by the UK ($3.4M), Germany ($2.9M), France ($2.6M), and Canada ($2.0M). **337 customers (~$227K of revenue) have no country on file** — a data-quality gap worth closing.

3. **Customer base skews low-loyalty.** 63% of customers bought exactly once; only 37% became repeat buyers. Given bikes are big-ticket, infrequent purchases, this isn't unusual — but it means **most revenue growth is coming from new customer acquisition, not retention**, which is worth validating against marketing spend.

4. **Top customers cluster very tightly.** The top 10 customers each generated $12.9K–$13.3K — a narrow band, meaning no single "whale" is propping up revenue. It's a broad base of similarly high-value buyers rather than a concentration risk.

5. **Gender/marital status data is thin.** Only 15 customers have unknown gender (clean), but **4,569 customers (~25%) have "n/a" marital status** — worth flagging to whoever owns customer data capture upstream.

---

## 👨‍💻 About the Author

**Surajkumar Bevnale**
Aspiring Data Analyst | SQL • Excel • Power BI • Python
B.Tech, Engineering Physics, IIT Ropar (2023–2027)

- 📫 Reach me at: surajk.b168@gmail.com
- 🔗 GitHub: [@SurajB-168](https://github.com/SurajB-168)

---

## 📜 License

This project is licensed under the MIT License — feel free to use, modify, and share with attribution.
