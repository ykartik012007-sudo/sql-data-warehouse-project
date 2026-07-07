# 📊 Data Warehousing Project

## 📖 Overview

This repository contains my first **Data Warehousing** project built using **Microsoft SQL Server**.

The project follows the **Medallion Architecture (Bronze, Silver, Gold)** to transform raw data from multiple source systems into clean, business-ready data for reporting and analytics.

This project was completed by following the guidance of **Baraa Khatib Salkini**. I built the project as a hands-on learning experience to understand how modern data warehouses are designed and implemented.

---

# 🎯 Project Objective

Develop a modern data warehouse for sales data that supports analytical reporting and business decision-making.

---

# 📌 Project Requirements

- Import data from two source systems (**CRM** and **ERP**) provided as CSV files.
- Load raw data into SQL Server using **BULK INSERT**.
- Clean and standardize data for better quality.
- Integrate data from multiple sources into a single analytical model.
- Focus on the latest available data (historical tracking is not included).
- Document the data model and project structure for easier understanding.

---

# 🏗️ Architecture

This project follows the **Medallion Architecture**.

```
CRM CSV
          \
           ---> Bronze ---> Silver ---> Gold ---> Reporting & Analytics
          /
ERP CSV
```

### 🥉 Bronze Layer
- Stores raw data from the source systems.
- No transformations are applied.
- Data is loaded using **BULK INSERT**.
- Uses the **Truncate and Load** loading strategy.

### 🥈 Silver Layer
- Cleans and transforms raw data.
- Removes unnecessary spaces.
- Handles duplicate records.
- Standardizes values.
- Corrects data types.
- Performs data normalization.
- Applies data quality checks.

### 🥇 Gold Layer
- Creates business-ready views.
- Combines CRM and ERP data.
- Builds **Fact** and **Dimension** models.
- Supports reporting and business analysis.

---

# 🛠️ Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- SQL
- CSV Files
- BULK INSERT
- Draw.io
- Notion

---

# 📚 Concepts Practiced

- Data Warehousing
- ETL Pipeline
- Medallion Architecture
- Data Cleansing
- Data Normalization
- Data Enrichment
- Data Quality Validation
- Fact & Dimension Modeling
- SQL Stored Procedures
- BULK INSERT
- Truncate and Load Strategy
- Naming Conventions (snake_case)

---

# 🎓 What I Learned

Through this project I gained practical experience in:

- Designing a layered data warehouse
- Building ETL pipelines using SQL Server
- Loading data from multiple source systems
- Cleaning and transforming datasets
- Creating business-ready data models
- Organizing SQL projects professionally
- Writing SQL for real-world data engineering workflows

This project helped me understand how SQL is used in practical data engineering instead of only solving standalone SQL problems.

---

# 🙋 About Me

Hi! I'm **Kartik Yadav**, a BCA student and an aspiring **Data Engineer** from India.

I enjoy building data projects, learning SQL, and exploring modern data engineering concepts. My goal is to continue improving my skills through hands-on projects and eventually work as a Data Engineer.

Feel free to explore this repository, and if you have any suggestions or feedback, I'd be happy to learn from them.

---

# 🙏 Acknowledgement

A special thanks to **Baraa Khatib Salkini** for creating and sharing this excellent data warehousing project. This repository is my implementation completed while following his guidance as part of my learning journey.

---

## ⭐ If you found this repository helpful, feel free to leave a star.
