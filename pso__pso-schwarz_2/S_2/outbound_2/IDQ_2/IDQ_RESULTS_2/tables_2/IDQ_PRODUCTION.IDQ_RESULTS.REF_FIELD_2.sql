CREATE OR REPLACE TABLE idq_production_idq_results.ref_field_2 (
id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0),
source_table STRING(1000),
technical_name STRING(1000),
name_de STRING(1000),
name_en STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);