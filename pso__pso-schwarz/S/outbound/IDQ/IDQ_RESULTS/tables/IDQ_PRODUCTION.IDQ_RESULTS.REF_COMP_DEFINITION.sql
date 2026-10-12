CREATE OR REPLACE TABLE idq_production_idq_results.ref_comp_definition (
id BIGNUMERIC(38,0) NOT NULL,
leading_source_system_type_id BIGNUMERIC(38,0),
dependent_source_system_type_id BIGNUMERIC(38,0),
leading_test_object_type_id BIGNUMERIC(38,0),
dependent_test_object_type_id BIGNUMERIC(38,0),
name STRING(200),
name_de STRING(200),
name_en STRING(200),
PRIMARY KEY (id) NOT ENFORCED
);