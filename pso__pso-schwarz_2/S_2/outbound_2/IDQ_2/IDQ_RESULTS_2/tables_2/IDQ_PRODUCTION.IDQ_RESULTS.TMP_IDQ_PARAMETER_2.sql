CREATE OR REPLACE TABLE idq_production_idq_results.tmp_idq_parameter_2 (
source_system_type_id BIGNUMERIC(38,0) NOT NULL,
rule_id BIGNUMERIC(38,0) NOT NULL,
country_id BIGNUMERIC(38,0) NOT NULL,
parameter_id BIGNUMERIC(38,0) NOT NULL,
parameter_value STRING(4000),
name_en STRING(1000),
description_en STRING(4000),
updated_by STRING(200),
updated_at DATETIME,
task_id STRING(30),
PRIMARY KEY (source_system_type_id, rule_id, country_id, parameter_id) NOT ENFORCED
);