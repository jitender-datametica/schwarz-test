CREATE OR REPLACE TABLE idq_production_ldl_apt_results.t_dq_apt_execution_list (
execution_date DATETIME,
execution_day_id BIGNUMERIC(38,0),
country_id STRING(250),
country_code STRING(250),
rule_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
source_system_type_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
is_current BIGNUMERIC(38,0)
);