CREATE OR REPLACE TABLE idq_production_ldl_apt_results.t_dq_apt_execution_list_1 (
execution_date DATETIME,
execution_day_id INTEGER,
country_id STRING(250),
country_code STRING(250),
rule_id INTEGER,
source_system_id INTEGER,
source_system_type_id INTEGER,
branch_id INTEGER,
is_current INTEGER
);