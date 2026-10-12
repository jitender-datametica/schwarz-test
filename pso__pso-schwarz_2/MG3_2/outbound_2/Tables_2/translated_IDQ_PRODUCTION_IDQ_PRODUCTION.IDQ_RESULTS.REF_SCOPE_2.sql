CREATE OR REPLACE TABLE idq_production_idq_results.ref_scope_2 (
id INTEGER NOT NULL,
source_system_type_id INTEGER,
source_system_id INTEGER,
country_id INTEGER,
branch_id INTEGER,
test_object_type_id INTEGER,
contact_email STRING(500),
PRIMARY KEY (id) NOT ENFORCED
);