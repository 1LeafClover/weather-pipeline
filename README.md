# 🌦️ Weather Data Pipeline (ELT with dbt + Airflow + PostgreSQL)

**A production-ready ELT pipeline** that extracts weather data from [WeatherAPI.com](https://www.weatherapi.com/), transforms it using **dbt** (with a PostgreSQL-backed medallion architecture), and orchestrates workflows with **Airflow**. Includes monitoring (**Grafana**) and alerting (**Slack**) for end-to-end reliability.

---

## 📌 Key Features
| Component          | Details                                                                 |
|--------------------|-------------------------------------------------------------------------|
| **API Ingestion**  | - Daily incremental pulls with `Python` + `requests`.<br>- Fault tolerance (retries + exponential backoff). |
| **dbt Transform**  | - **Silver Layer**: Cleaned, validated, and normalized data.<br>- **Gold Layer**: Aggregates (daily stats, trends) and anomaly detection. |
| **Orchestration**  | - Airflow (Dockerized) with task retries, SLAs, and dependency management. |
| **Observability**  | - **Grafana**: Real-time dashboards for pipeline health + data quality.<br>- **Slack Alerts**: Immediate notifications for failures or anomalies. |
| **Data Quality**   | - Built-in dbt tests (e.g., `not_null`, `accepted_values`).<br>- Custom checks (e.g., `temperature BETWEEN -50 AND 60`). |

---

## 🏗️ Architecture
```mermaid
flowchart TB
  subgraph Extraction
    A[WeatherAPI] -->|Python| B[(PostgreSQL\nBronze)]
  end
  subgraph Transformation
    B -->|dbt| C[(PostgreSQL\nSilver)]
    C -->|dbt| D[(PostgreSQL\nGold)]
  end
  subgraph Orchestration
    G[Airflow] -->|Triggers| A
    G -->|Monitors| C
  end
  subgraph Observability
    D --> E[Grafana\nDashboard]
    D --> F[Slack\nAlerts]
  end
