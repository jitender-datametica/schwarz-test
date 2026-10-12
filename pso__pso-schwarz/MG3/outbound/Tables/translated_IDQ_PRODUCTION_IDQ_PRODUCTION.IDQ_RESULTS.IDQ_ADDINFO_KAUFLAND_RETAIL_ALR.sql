CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_kaufland_retail_alr (
id INTEGER NOT NULL,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
is_relevant INTEGER,
systemid STRING(6),
matnr STRING(18),
lifnr STRING(10),
ekgrp STRING(3),
content_hash_code STRING(32),
idq_date DATETIME,
idq_user STRING(100),
zsm_itemnr STRING(18),
PRIMARY KEY (id) NOT ENFORCED
);