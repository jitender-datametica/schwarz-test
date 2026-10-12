CREATE OR REPLACE TABLE idq_production_idq_monitoring.check_results_1 (
table_schema STRING(50),
table_name STRING(50),
country_code STRING(3),
r_count BIGNUMERIC(38,0),
min_insert TIMESTAMP,
max_insert TIMESTAMP,
min_update TIMESTAMP,
max_update TIMESTAMP
);