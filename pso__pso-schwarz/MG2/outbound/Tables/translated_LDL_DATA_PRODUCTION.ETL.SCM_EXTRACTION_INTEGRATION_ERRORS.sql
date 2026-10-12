CREATE OR REPLACE TABLE ldl_data_production_etl.scm_extraction_integration_errors (
context_timestamp DATETIME,
technical_message STRING(4000),
user_message STRING(4000),
error_code STRING(10),
dashboard_relevant STRING(1),
interface STRING(100),
filename STRING(255),
data STRING(5000)
);