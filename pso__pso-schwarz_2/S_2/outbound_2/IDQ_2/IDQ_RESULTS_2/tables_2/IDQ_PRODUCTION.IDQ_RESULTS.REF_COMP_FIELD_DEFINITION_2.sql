CREATE OR REPLACE TABLE idq_production_idq_results.ref_comp_field_definition_2 (
id BIGNUMERIC(38,0) NOT NULL,
comp_definition_id BIGNUMERIC(38,0),
leading_field_id BIGNUMERIC(38,0),
dependent_field_id BIGNUMERIC(38,0),
criticality_id BIGNUMERIC(38,0),
field_comp_type_id BIGNUMERIC(38,0),
functional_field_name STRING(200),
functional_field_name_de STRING(200),
functional_field_name_en STRING(200),
PRIMARY KEY (id) NOT ENFORCED
);