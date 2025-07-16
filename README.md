# Airbnb Data Pipeline Project (Snowflake + dbt + Orchestration)

## 🔧 Project Objective

This project builds a complete modern data pipeline for Airbnb data using industry tools:

* **Snowflake**: Cloud data warehouse
* **dbt**: Data transformation, testing, documentation
* **Airflow or Dagster**: Orchestration
* **Preset (Superset)**: Data visualization

The pipeline covers listings, hosts, and reviews data across raw, cleansed, and analytical layers.

---

## 🏐 Snowflake Setup

1. **Create Roles and Users**:

   * Create a `TRANSFORM` role
   * Create a user named `dbt` and assign it to the role

2. **Warehouse**:

   * Create `COMPUTE_WH` as the compute engine
   * Grant usage and operate permissions to the `TRANSFORM` role

3. **Database and Schema**:

   * Create a database `AIRBNB`
   * Create schema `RAW` to hold raw data

4. **Grants**:

   * Grant necessary access on the database, schemas, and tables to the `TRANSFORM` role

---

## ☁️ Data Import to Snowflake

1. Load CSVs from S3 into Snowflake:

   * `raw_listings`: Property listings
   * `raw_reviews`: User reviews
   * `raw_hosts`: Host details

2. These tables form the **Bronze (Raw)** layer.

---

## 🚀 Python, Virtualenv & dbt Setup

1. Install Python 3.10+ and create a virtual environment:

   ```bash
   virtualenv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. Install dbt:

   ```bash
   pip install dbt-snowflake==1.9.0
   ```

3. Initialize a dbt project:

   ```bash
   dbt init dbtlearn
   ```

4. Set up your Snowflake profile in `~/.dbt/profiles.yml`

---

## 📈 dbt Models

### 1. Staging Models (SRC)

* Thin layers to clean column names and formats
* Examples: `src_hosts`, `src_reviews`, `src_listings`

### 2. Cleansed Dimension Models (DIM)

* Clean, deduplicate, and enrich the data
* Example transformations:

  * Replace nulls in host names with "Anonymous"
  * Convert price to numeric
  * Ensure `minimum_nights` is at least 1

### 3. Fact Tables and Marts

* `fct_reviews`: Fact table for reviews, supports incremental loads
* `dim_listings_w_hosts`: Join listings with host info for analytics

---

## 📊 Snapshots

* Use snapshots to track changes over time (SCDs)
* Useful for fields like `minimum_nights`, host status, etc.
* Stored in the `DEV` schema

---

## ✅ Testing

### Generic Tests:

* `not_null`, `unique`, `relationships`, `accepted_values`

### Custom Tests:

* Ensure `minimum_nights >= 1`
* Ensure no review is before the listing creation date

Tests are defined in `schema.yml` or custom SQL in `tests/` folder.

---

## 📃 Seeds

* CSV files placed in `seeds/`
* Example: `seed_full_moon_dates.csv`
* Loaded using `dbt seed`
* Used to enhance analysis by joining with review dates

---

## 📖 Documentation

* Generated with `dbt docs generate && dbt docs serve`
* Documents:

  * Models and their purpose
  * Column descriptions
  * Test coverage
  * Lineage graphs

---

## ⏳ Incremental Models

* Used for large tables like `fct_reviews`
* Only process new records since the last run
* Supports custom date ranges using variables:

  ```bash
  dbt run --select fct_reviews --vars '{start_date: "YYYY-MM-DD", end_date: "YYYY-MM-DD"}'
  ```

---

## 🚜 Orchestration (Airflow or Dagster)

* Schedule tasks to:

  * Run `dbt run`, `dbt test`, and `dbt docs`
  * Load API or external data
  * Trigger snapshots

* Tools like **Airflow**, **Dagster**, or **dbt Cloud** automate the pipeline

---

## 📊 Exposures and Preset Dashboard

1. Create `REPORTER` role and assign it to `PRESET` user
2. Grant `SELECT` access to final models in `AIRBNB.DEV`
3. Define `exposures` in dbt to track which dashboards depend on which models

---

## 💼 Summary

This project implements a full-stack data pipeline with:

* Snowflake as the warehouse
* dbt for modeling, testing, and snapshots
* Orchestration using Airflow or Dagster
* Visualization via Superset/Preset

It follows best practices with modular models, testing, security, and documentation for modern data engineering.

## Preset Dashboard 
![dbt](<assets/DASHBOARD.png>)
---

## Dbt Lineage
![dbt](<assets/lineageGraph.PNG>)
---

## Dagster
![dbt](<assets/dagster.PNG>)
---

## 🔗 Connect with Me  
<p align="center">
<a href="www.linkedin.com/in/mohamed-omara-a93b972b5">
<img src="https://img.shields.io/badge/LinkedIn-MohamedOmara-0077B5?style=for-the-badge&logo=linkedin&logoColor=white">
</a>
</p>
