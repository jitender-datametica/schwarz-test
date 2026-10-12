CREATE OR REPLACE TABLE idq_production_dq_reports.t_datastore_dq (
source STRING(16777216),
source_type STRING(16777216),
system STRING(16777216),
execution_time DATETIME,
table_name STRING(16777216),
columns STRING(16777216),
gx_rule STRING(16777216),
success STRING(16777216),
element_count BIGNUMERIC(38,0),
unexpected_count BIGNUMERIC(38,0),
unexpected_percent STRING(16777216),
unexpected_id STRING(16777216)
);