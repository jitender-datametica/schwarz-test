CREATE OR REPLACE TABLE idq_production_idq_results.ref_relevance_definition_1 (
id INTEGER NOT NULL,
name STRING(1000),
branch_id INTEGER,
source_system_type_id INTEGER,
test_object_type_id INTEGER,
name_de STRING(1000),
name_en STRING(1000),
description_de STRING(4000),
description_en STRING(4000),
PRIMARY KEY (id) NOT ENFORCED
);