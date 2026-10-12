CREATE OR REPLACE TABLE idq_production_kfl_ret.check_results (
table_name STRING(50),
country_code STRING(3),
r_count BIGNUMERIC(38,0),
min_insert TIMESTAMP,
max_insert TIMESTAMP,
min_update TIMESTAMP,
max_update TIMESTAMP
);