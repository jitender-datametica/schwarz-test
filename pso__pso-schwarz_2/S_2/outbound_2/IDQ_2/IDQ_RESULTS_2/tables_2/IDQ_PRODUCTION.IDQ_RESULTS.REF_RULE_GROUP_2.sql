CREATE OR REPLACE TABLE idq_production_idq_results.ref_rule_group_2 (
id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0),
short_name STRING(200),
name_de STRING(1000),
name_es STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);