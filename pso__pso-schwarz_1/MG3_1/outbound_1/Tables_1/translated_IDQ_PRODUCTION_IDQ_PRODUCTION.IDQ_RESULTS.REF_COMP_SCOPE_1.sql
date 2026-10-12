CREATE OR REPLACE TABLE idq_production_idq_results.ref_comp_scope_1 (
id INTEGER NOT NULL,
source_system_type_id INTEGER,
source_system_id INTEGER,
country_id INTEGER,
branch_id INTEGER,
test_object_type_id INTEGER,
description_de STRING(1000),
description_en STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);