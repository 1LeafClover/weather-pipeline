# Weather Data Pipeline (ELT with dbt + Airflow + PostgreSQL)

**A production-ready ELT pipeline** that extracts weather data from APIs, transforms it using dbt (PostgreSQL-backed medallion architecture), and orchestrates with Airflow. Includes monitoring (Grafana) and alerting (Slack).

## 📌 Key Features
- **API Ingestion**: 
  - Daily incremental pulls from [weatherapi.com](https://www.weatherapi.com/) (Python + requests).
  - Fault tolerance with retries and exponential backoff.
- **dbt Transformation** (PostgreSQL):
  - **Silver Layer**: Validated, deduplicated, and type-checked data.
  - **Gold Layer**: Aggregates (daily stats, trends) and alert-ready anomalies.
- **Orchestration**: 
  - Airflow (Dockerized) with task retries and SLA monitoring.
- **Observability**:
  - **Grafana**: Pipeline health + data quality dashboards.
  - **Slack Alerts**: Failed runs or anomalous weather conditions.
- **Data Quality**: 
  - dbt tests + custom checks (e.g., "temperature within realistic bounds").

## 🏗️ Architecture
```mermaid
flowchart TB
  A[Weather API] -->|Python| B[(PostgreSQL Raw)]
  B -->|dbt| C[(PostgreSQL Silver)]
  C -->|dbt| D[(PostgreSQL Gold)]
  D --> E[Grafana Dashboard]
  D --> F[Slack Alerts]
  G[Airflow] -->|Triggers| A
  G -->|Monitors| C