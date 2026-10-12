CREATE OR REPLACE TABLE idq_production_idq_results.ref_comp_field_definition (
id INTEGER NOT NULL,
comp_definition_id INTEGER,
leading_field_id INTEGER,
dependent_field_id INTEGER,
criticality_id INTEGER,
field_comp_type_id INTEGER,
functional_field_name STRING(200),
functional_field_name_de STRING(200),
functional_field_name_en STRING(200),
PRIMARY KEY (id) NOT ENFORCED
);