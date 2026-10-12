CREATE OR REPLACE TABLE idq_production_idq_results.ref_scope_1 (
id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
test_object_type_id BIGNUMERIC(38,0),
contact_email STRING(500),
PRIMARY KEY (id) NOT ENFORCED
);