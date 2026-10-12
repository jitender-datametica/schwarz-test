CREATE OR REPLACE TABLE idq_production_idq_results.reporting_test_result_current (
scope_id BIGNUMERIC(38,0),
test_object_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
in_report_included BIGNUMERIC(38,0),
first_include DATETIME,
first_include_day_id BIGNUMERIC(38,0),
first_exclude DATETIME,
first_exclude_day_id BIGNUMERIC(38,0)
);