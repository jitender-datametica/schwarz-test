CREATE OR REPLACE TABLE ldl_data_production_etl.scm_extraction_integration_control (
source STRING(20),
interface STRING(100),
extraction_timestamp DATETIME,
load_timestamp DATETIME,
filename STRING(2000),
doc_version STRING(20)
);