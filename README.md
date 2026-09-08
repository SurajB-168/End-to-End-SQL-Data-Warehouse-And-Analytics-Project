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

**Analysis Period:** December 2010 – January 2014
**Countries:** US, Australia, UK, Germany, France, Canada
**Products:** 295
**Customers:** 18,484
**Total Sales:** ~$29.4M

## Key Metrics

| Metric              |   Value |
| ------------------- | ------: |
| Total Sales         | $29.36M |
| Total Orders        |  27,659 |
| Total Items Sold    |  60,423 |
| Average Order Value |  $1,061 |
| Total Customers     |  18,484 |
| Countries Served    |       6 |
| Total Products      |     295 |

---

## 🔍 Key Business Insights

### 1. Bikes bring in most of the money

Bikes make up only about **25% of order lines**, but they generate **96.5% of total sales ($28.3M)**.

Accessories are bought more often, making up around **60% of order lines**, but they generate only **2.4% of sales** because they are lower-priced products.

**In simple terms:** Bikes are the main source of revenue, while accessories are mainly small, frequent purchases.

---

### 2. Road and Mountain Bikes are the main products

**Road Bikes ($14.5M)** and **Mountain Bikes ($10.0M)** together generate more than **83% of total revenue**.

The **Mountain-200** product line is especially strong, with each of its six variants generating around **$1.25M–$1.37M** in sales.

**In simple terms:** The company should continue focusing on Road and Mountain Bikes because they are the biggest revenue drivers.

---

### 3. A small group of customers generates most of the sales

The top **20% of customers (3,696 customers)** generate about **66% of total revenue**.

This means the business depends heavily on its best customers.

**In simple terms:** Keeping high-value customers happy is very important because losing them could have a big impact on sales.

---

### 4. Most customers buy only once

Around **63% of customers (11,619 people)** have placed only one order.

On average, each customer places just **1.5 orders**.

**In simple terms:** Many customers buy once and do not come back. This shows a clear opportunity to improve customer retention and repeat purchases.

---

### 5. Sales increased strongly through 2013

Monthly sales increased from around **$540K in November 2012** to a peak of about **$1.87M in December 2013**.

Sales then appear to fall sharply in January 2014 to around **$46K**.

However, the data only goes up to **January 28, 2014**, so January may be an incomplete month.

**In simple terms:** We should check the data before assuming that sales actually dropped in 2014.

---

### 6. Accessories have the highest profit margin

Accessories have a **62.8% profit margin**, which is much higher than:

* Bikes: **39.2%**
* Clothing: **40.2%**

Bikes still generate the most total profit because they have much higher sales.

**In simple terms:** Bikes make the most profit in total, but accessories make the most profit from every dollar of sales.

---

### 7. US and Australia are the biggest markets

The **US ($9.16M)** and **Australia ($9.06M)** are the two largest markets.

Each contributes around **31% of total sales**.

Canada is the smallest market, generating around **$1.98M**, or about **7% of total sales**.

**In simple terms:** The US and Australia are strong markets, while Canada has more room for growth.

---

### 8. Customers aged 30–49 generate most of the revenue

Customers aged **30–39 and 40–49** together generate around **66% of total sales ($19.5M)**.

Customers under 20 and over 70 contribute very little.

**In simple terms:** Customers between 30 and 49 are the company's most important age group.

---

### 9. Gender and marital status do not make much difference

Sales are almost evenly split between:

* Female: **$14.8M**
* Male: **$14.5M**

Sales are also fairly balanced between:

* Married: **$15.2M**
* Single: **$14.2M**

**In simple terms:** Gender and marital status do not appear to be strong factors in sales.

---

### 10. Shipping takes exactly 7 days for every order

Every order in the data was shipped exactly **7 days after it was placed**.

There is no variation.

**In simple terms:** This could mean the company has a fixed 7-day shipping policy, but it could also be a limitation or issue in the data. This should be checked with real operational data.

---

# ✅ Recommendations

### 1. Sell more accessories with bikes

Offer customers accessories such as **helmets, bottles, and tires** when they buy a bike.

For example, offer a bike + helmet + bottle as a bundle.

This can increase the **average order value** and overall profit.

---

### 2. Improve customer retention

Since **63% of customers buy only once**, the company should encourage them to come back.

Possible actions:

* Send follow-up emails after purchases
* Offer discounts for the next purchase
* Send bike maintenance reminders
* Create a loyalty/rewards program
* Recommend relevant accessories

---

### 3. Give special benefits to top customers

The top 20% of customers generate **66% of revenue**.

Create a **VIP or rewards program** for these customers.

This could include:

* Exclusive discounts
* Early access to new products
* Special offers
* Loyalty points

---

### 4. Continue focusing on Road and Mountain Bikes

Road and Mountain Bikes are the strongest product groups.

The company should continue investing in:

* Road-150
* Road-200
* Mountain-200
* Similar high-performing products

These products should receive strong inventory, marketing, and product development support.

---

### 5. Try to grow the Canadian market

Canada generates only around **7% of total sales**, making it the smallest market.

The company should investigate:

* Pricing
* Marketing
* Product availability
* Customer preferences
* Local promotions

Then test targeted marketing campaigns in Canada.

---

### 6. Use Accessories to increase profit

Accessories have the **highest profit margin (62.8%)**.

Instead of giving large discounts on bikes, the company can use bike purchases to encourage customers to buy accessories.

For example:

**Bike purchase → Recommended helmet → Bottle → Tires**

This can increase overall profit.

---

### 7. Check the 2014 and early-year data

The sharp drop in January 2014 may simply be because the data is incomplete.

The company should also check the relatively low sales in **2010 and 2011**.

Before making business decisions, confirm whether these numbers represent:

* Actual low sales
* A new business launch
* Missing data
* An incomplete data extract

---

### 8. Focus marketing on customers aged 30–49

Customers aged **30–49 generate most of the revenue**, so this group should remain a major target for marketing campaigns.

At the same time, the company can test smaller campaigns aimed at **younger customers** to build a future customer base.


---

## 👨‍💻 About the Author

**Surajkumar Bevnale**
Data Analyst | SQL • Excel • Power BI • Python
B.Tech, Engineering Physics, IIT Ropar (2023–2027)

- 📫 Reach me at: surajk.b168@gmail.com
- 🔗 LinekdIn: [Surajkumar B](https://www.linkedin.com/in/skb168/)
---

