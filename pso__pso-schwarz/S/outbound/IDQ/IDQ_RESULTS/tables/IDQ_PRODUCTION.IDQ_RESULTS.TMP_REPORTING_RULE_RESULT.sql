CREATE OR REPLACE TABLE idq_production_idq_results.tmp_reporting_rule_result (
scope_id BIGNUMERIC(38,0),
test_object_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
in_report_included BIGNUMERIC(38,0),
additional_info_de STRING(1000),
additional_info_en STRING(1000)
);