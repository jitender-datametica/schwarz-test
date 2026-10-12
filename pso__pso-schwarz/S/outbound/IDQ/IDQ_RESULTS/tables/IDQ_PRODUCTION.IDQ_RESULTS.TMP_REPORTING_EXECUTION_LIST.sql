CREATE OR REPLACE TABLE idq_production_idq_results.tmp_reporting_execution_list (
scope_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
source_system_type_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
test_object_type_id BIGNUMERIC(38,0),
execution_date DATETIME,
execution_day_id BIGNUMERIC(38,0)
);