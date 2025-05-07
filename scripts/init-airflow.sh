# Initialize DB
airflow db migrate

# Create admin user from ENV vars
airflow users create \
  --username ${AIRFLOW_ADMIN_USER} \
  --password ${AIRFLOW_ADMIN_PASSWORD} \
  --role Admin \
  --email ${AIRFLOW_ADMIN_EMAIL} || true

# Start server with production settings
exec airflow api-server