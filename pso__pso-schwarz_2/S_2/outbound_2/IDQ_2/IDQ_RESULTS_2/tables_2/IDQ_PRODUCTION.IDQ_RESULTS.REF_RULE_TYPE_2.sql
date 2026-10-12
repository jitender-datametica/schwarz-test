CREATE OR REPLACE TABLE idq_production_idq_results.ref_rule_type_2 (
id BIGNUMERIC(38,0) NOT NULL,
rule_type STRING(200),
name_de STRING(1000),
name_en STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);