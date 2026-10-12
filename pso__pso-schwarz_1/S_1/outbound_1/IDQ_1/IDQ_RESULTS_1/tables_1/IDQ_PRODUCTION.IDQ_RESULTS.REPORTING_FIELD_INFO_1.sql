CREATE OR REPLACE TABLE idq_production_idq_results.reporting_field_info_1 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
additional_info_de STRING(1000),
additional_info_en STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);