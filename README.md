# 🚀 Automated Real-Time Global Market Streaming & Data Engineering Pipeline

---

## 📌 Project Overview

This project is an end-to-end data engineering solution designed to ingest, validate, and transform global market data in real-time. It bridges the gap between raw streaming APIs and curated cloud data warehousing, moving data from AWS Kinesis through Amazon S3 and into Snowflake. The system ensures 100% data integrity for over 2,200 markets across 36 countries, enabling high-precision statistical analysis.

---

## 🎯 Objectives
* **Scalable Architecture**: Build a resilient streaming flow using AWS Kinesis to handle high-velocity market tickers without data loss.
* **Serverless Validation**: Implement a "sniffing" layer via AWS Lambda to ensure data quality before ingestion.
* **In-Warehouse Transformation**: Utilize Snowpark (Python) to execute complex data cleaning directly within Snowflake's elastic engine, avoiding the overhead of external ETL tools.
* **Statistical Verification**: Mathematically prove the pipeline's accuracy by calculating global averages across 3.3 million processed records.

---

## 📂 Project Structure (ETL Workflow)

### 1. Data Ingestion & Automation (SQL)
These scripts initialize the cloud-native infrastructure and automate the movement of data from S3 to Snowflake.

* `01_setup_environment.sql`: Initializes the database, schema, and storage integrations for AWS S3.
* `02_create_landing_tables.sql`: Defines the "Raw" landing zone where streaming Kinesis data is initially stored.
* `03_configure_snowpipe.sql`: Configures the Snowpipe object for automated, near-zero latency ingestion.
* `06_monitor_pipeline_health.sql`: Operational queries to track pipe status and ingestion history.

### 2. Transformation & Analytics (SQL & Python)
These files handle the heavy lifting of cleaning disparate global market data into a math-ready format.

* `04_transform_analytics_view.sql`: Core SQL logic for currency normalization and numeric casting (handling K/M/B suffixes).
* `05_create_final_market_view.sql`: Final curated view designed for high-performance statistical modeling.
* `snowflake_market_transformation.py`: A Snowpark (Python) script for advanced in-warehouse data cleaning.

### 3. Validation & Support (Python & Data)
* `lambda_function.py`: An AWS Lambda script that "sniffs" incoming S3 files for quality before ingestion.
* `/Datasets`: Directory containing the 6 original CSV samples (NASDAQ, Tokyo, Indian, etc.) used for pipeline validation.

---
## ⚙️ Technical Implementation

### Core Transformation Logic (Snowpark Python)

Key logic components driving the data normalization:
* **Numeric Casting**: Implementation of regexp_replace and replace functions to scrub currency symbols and commas.
* **Shorthand Normalization**: Logic to convert market shorthand ($K, M, B$) into math-ready float values (e.g., $100K \rightarrow 100,000$).
* **Safe Division**: Use of DIVIDE(..., 10^9) logic to handle Billion-scale valuations while preventing null errors.
* **Schema Enforcement**: Automated casting of "General" string types into $FLOAT$ to support statistical modeling.

---
## 📈 Data Processing & Pipeline Architecture
### Ingestion Layer (AWS)
* **Kinesis Data Firehose**: Captures live API streams and delivers them to a partitioned S3 Data Lake.
* **Partitioned Storage**: Objects are stored in `YYYY/MM/DD/HH` folders, optimizing Snowpipe performance and storage costs.
* **Kinesis Data Streams**: Serves as the high-throughput entry point for raw, real-time market data ingestion.

### Processing Layer (Lambda & Snowpipe)
* **Real-Time Validation**: AWS Lambda triggers on every S3 "Put" event, inspecting headers and sniffing for data types that would break downstream loads.
* **Automated Loading**: Snowflake Snowpipe provides near-zero latency ingestion from S3 into raw landing tables.

### Transformation Layer (Snowflake)
* **Snowpark Execution**: Python code runs directly in the Snowflake warehouse, eliminating the need to move data to an external compute environment.
* **Final Curated Views**: SQL-based views provide a clean, high-performance interface for final statistical reporting.

---
## 🔑 Key Takeaways
* **Handling Schema Drift**: The pipeline successfully managed disparate data formats and header variations across 36 international market sources.
* **Cloud Cost Efficiency**: Implementation of Snowflake Auto-Suspend and Kinesis buffering intervals ensured a professional-grade architecture within a graduate-level budget.
* **Statistical Integrity**: The pipeline verified a global average market price of $2,540,939,966.05, matching expected results across 3.3M+ records with zero precision loss.


---

## 🛠 Tech Stack & Tools
* **AWS (Kinesis, S3, Lambda)**: Streaming ingestion and serverless validation.
* **Snowflake**: Centralized data warehousing.
* **Snowpark (Python)**: Complex data engineering and in-warehouse transformations.
* **Snowpipe**: Automated data ingestion.
* **SQL**: High-performance view creation and structural queries.

---

## 📌 Future Enhancements
* **DBT Integration**: Introduce Data Build Tool (dbt) to modularize and version-control the SQL transformation layer.
* **Orchestration with Airflow**: Replace S3 Event Notifications with Apache Airflow for advanced workflow monitoring and error recovery.
* **ML Forecasting**: Integrate a time-series model (e.g., Prophet or XGBoost) using Snowpark to predict market trends based on the streaming history.
* **Live Monitoring**: Connect the curated Snowflake views to a live dashboard for real-time statistical monitoring.
