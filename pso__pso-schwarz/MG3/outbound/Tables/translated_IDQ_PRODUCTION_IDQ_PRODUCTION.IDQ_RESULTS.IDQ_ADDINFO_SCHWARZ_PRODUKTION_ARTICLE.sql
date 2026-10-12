CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_schwarz_produktion_article (
id INTEGER NOT NULL,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
is_relevant INTEGER,
maktx STRING(40),
matkl STRING(9),
mstae STRING(2),
werks STRING(1000),
content_hash_code STRING(32),
mtart STRING(4),
PRIMARY KEY (id) NOT ENFORCED
);