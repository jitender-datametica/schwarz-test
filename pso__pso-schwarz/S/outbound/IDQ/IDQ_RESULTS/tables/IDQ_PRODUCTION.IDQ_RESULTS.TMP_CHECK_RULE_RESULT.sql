CREATE OR REPLACE TABLE idq_production_idq_results.tmp_check_rule_result (
scope_id BIGNUMERIC(38,0),
test_object_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
field_content STRING(1000),
is_error_detected BIGNUMERIC(38,0),
additional_info STRING(1000),
additional_info_en STRING(1000)
);