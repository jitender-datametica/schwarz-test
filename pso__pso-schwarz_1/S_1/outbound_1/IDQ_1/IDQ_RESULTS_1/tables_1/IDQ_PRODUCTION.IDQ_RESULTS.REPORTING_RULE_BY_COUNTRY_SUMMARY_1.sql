CREATE OR REPLACE TABLE idq_production_idq_results.reporting_rule_by_country_summary_1 (
id BIGNUMERIC(38,0) NOT NULL,
calculation_time DATETIME,
source_system_type_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
test_object_type_id BIGNUMERIC(38,0),
test_result_amount BIGNUMERIC(38,0),
included_amount BIGNUMERIC(38,0),
excluded_amount BIGNUMERIC(38,0),
is_current BIGNUMERIC(38,0),
calculation_day_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);