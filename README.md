🔧 1. Project Objective
The goal of this project is to build a complete modern data pipeline for Airbnb data, using industry tools like:

Snowflake (cloud data warehouse)

dbt (transformations, testing, documentation)

Airflow or Dagster (workflow orchestration)

Preset (Superset) (data visualization)

and optionally PostgreSQL for local experimentation.

The data includes listings, hosts, and reviews, and we clean, transform, test, and analyze them following best practices like the Medallion Architecture (Bronze → Silver → Gold).

🏗️ 2. Snowflake Setup
Before working with data, we need to set up Snowflake:

Create a user and assign it a role with permission to read/write data and run queries.

Create a warehouse (the compute engine in Snowflake) and give it access to the role.

Create a database called AIRBNB with a RAW schema to store the raw data.

This step ensures we have:

A user to log in and run transformations (e.g., named dbt)

Permissions properly set up

A place to store and organize the data

☁️ 3. Upload Raw Data to Snowflake
After Snowflake is ready, we load the raw Airbnb CSV files into the RAW schema from an Amazon S3 bucket.

We create three raw tables:

raw_listings — Contains property listings

raw_reviews — User reviews and sentiment

raw_hosts — Host details

These tables represent the Bronze layer (raw ingestion) in the data lakehouse or warehouse.

🐍 4. Python & dbt Setup
We use Python virtual environments to isolate our dependencies, and install dbt-snowflake, a tool that lets us:

Transform data

Build models

Run tests

Generate documentation

Once dbt is installed:

We initialize a dbt project (e.g., dbtlearn)

Configure a profiles.yml file to connect dbt to Snowflake using the previously created credentials

🏗️ 5. dbt Models: Transformation Layers
We organize our models in 3 levels, reflecting the Medallion Architecture:

A. Staging (SRC) Models:
These are thin models that load data from raw tables as-is but rename columns or fix simple formats.
Examples: src_hosts, src_listings, src_reviews

B. Cleansed Dimensions (DIM):
These models apply data cleaning, transformation, and normalization.
Examples:

dim_hosts_cleansed replaces missing names with "Anonymous"

dim_listings_cleansed converts prices and filters bad rows

C. Facts (FCT) & Marts:
fct_reviews is a fact table that stores review data, possibly as incremental loads.

dim_listings_w_hosts is a mart (business-friendly table) joining listings with hosts, ready for analytics.

📸 6. Snapshots
Snapshots are used to track slowly changing data (e.g., if a listing updates its minimum nights or host info changes).

A snapshot compares the current row in a source table with the previous version

It stores the history of changes

Useful for audit, time-travel, and reporting on historical trends

✅ 7. Tests
We add tests to ensure data quality:

Generic tests:

not_null

unique

relationships between tables (e.g., host_id in listings exists in host table)

Custom tests:

Checking if minimum_nights is positive

Making sure reviews don't occur before a listing is created

These tests help you catch bad data and enforce integrity.

🧪 8. Seeds
Seeds are CSV files manually added to the repo. In this project, we use:

A CSV of full moon dates to analyze sentiment on full moon nights

We load these into Snowflake and join with the reviews table to create a new mart table showing whether a review happened during a full moon.

📚 9. Documentation
dbt lets us document everything:

What each model does

What each column means

Lineage: how models depend on each other

Tests and their status

We generate this with dbt docs generate and view it locally or host it.

🔁 10. Incremental Models
Some models, like fct_reviews, are incremental:

They only load new data since the last run

This speeds up dbt and avoids reprocessing old records

We can define conditions like: load data where review_date > max date in the table.

We can also pass custom date ranges using dbt vars.

🕹️ 11. Orchestration: Airflow or Dagster
We use Airflow or Dagster to schedule and automate the pipeline.

Typical tasks:

Run dbt run

Run dbt test

Load API data to PostgreSQL or Snowflake

Trigger snapshots or dashboards

Airflow lets us use Python and operators like BashOperator, PythonOperator, DbtRunOperator, and more.

📈 12. Exposures & Dashboarding
We use exposures in dbt to define which models power dashboards.

This is useful for:

Showing dependencies

Alerting if upstream data breaks the dashboard

Documenting which stakeholder uses which model

We connect tools like Preset/Superset to Snowflake and create dashboards on top of models like:

dim_listings_w_hosts

mart_fullmoon_reviews


🎓 Summary
This project is a full-stack example of a production-grade data pipeline that covers:

Data ingestion

Modeling with dbt

Testing & documentation

Incremental processing

Snapshots

Visualization & security

Automation with orchestration

It’s an excellent end-to-end case study of modern data engineering in action.

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
