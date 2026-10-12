CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_zsm_kfl_item (
id INTEGER NOT NULL,
test_object_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
branch_id INTEGER,
is_relevant INTEGER,
zsm_matnr STRING(18),
zsm_mstae STRING(2),
zsm_wekgr STRING(3),
content_hash_code STRING(32),
PRIMARY KEY (id) NOT ENFORCED
);