CREATE OR REPLACE TABLE idq_production_idq_results.ref_field_2 (
id INTEGER NOT NULL,
source_system_type_id INTEGER,
source_table STRING(1000),
technical_name STRING(1000),
name_de STRING(1000),
name_en STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);