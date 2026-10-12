CREATE OR REPLACE TABLE idq_production_idq_results.reporting_dq_by_country_current_2 (
scope_id BIGNUMERIC(38,0),
test_object_type_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
source_system_type_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
calculation_time DATETIME,
calculation_day_id BIGNUMERIC(38,0),
test_result_amount BIGNUMERIC(38,0),
included_amount BIGNUMERIC(38,0),
excluded_amount BIGNUMERIC(38,0)
);