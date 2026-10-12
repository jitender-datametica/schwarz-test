CREATE OR REPLACE TABLE idq_production_dq_reports.t_dq_datastore_1 (
filename STRING(16777216),
active BIGNUMERIC(38,0),
processor STRING(16777216),
processor_id STRING(16777216),
company STRING(16777216),
country_1 STRING(16777216),
execution_time DATETIME,
interface STRING(16777216),
rule_name STRING(16777216),
rule_description STRING(16777216),
element_count BIGNUMERIC(38,0),
unexpected_count BIGNUMERIC(38,0),
unexpected_percent BIGNUMERIC(38,10),
unexpected_percent_tolerated BIGNUMERIC(38,10),
passed BIGNUMERIC(38,0)
);