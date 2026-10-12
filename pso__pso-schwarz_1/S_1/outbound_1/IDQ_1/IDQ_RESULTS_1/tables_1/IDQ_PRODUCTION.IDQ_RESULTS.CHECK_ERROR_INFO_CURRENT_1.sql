CREATE OR REPLACE TABLE idq_production_idq_results.check_error_info_current_1 (
scope_id BIGNUMERIC(38,0),
test_object_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
invalid_content STRING(1000),
additional_info_de STRING(1000),
additional_info_en STRING(1000)
);