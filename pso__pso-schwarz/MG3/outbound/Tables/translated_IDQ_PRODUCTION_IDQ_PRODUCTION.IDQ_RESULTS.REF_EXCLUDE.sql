CREATE OR REPLACE TABLE idq_production_idq_results.ref_exclude (
id INTEGER NOT NULL,
rule_id INTEGER NOT NULL,
branch_id INTEGER NOT NULL,
source_system_primary_key STRING(1000),
source_system_id INTEGER NOT NULL,
country_id INTEGER NOT NULL,
test_object_type_id INTEGER NOT NULL,
inserted_by STRING(200),
exclude_reason STRING(1000),
exclude_flag INTEGER,
inserted_at DATETIME,
undone_at DATETIME,
test_object_id INTEGER,
PRIMARY KEY (id) NOT ENFORCED
);