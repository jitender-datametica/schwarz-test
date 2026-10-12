CREATE OR REPLACE TABLE idq_production_idq_results.ref_comp_definition (
id INTEGER NOT NULL,
leading_source_system_type_id INTEGER,
dependent_source_system_type_id INTEGER,
leading_test_object_type_id INTEGER,
dependent_test_object_type_id INTEGER,
name STRING(200),
name_de STRING(200),
name_en STRING(200),
PRIMARY KEY (id) NOT ENFORCED
);