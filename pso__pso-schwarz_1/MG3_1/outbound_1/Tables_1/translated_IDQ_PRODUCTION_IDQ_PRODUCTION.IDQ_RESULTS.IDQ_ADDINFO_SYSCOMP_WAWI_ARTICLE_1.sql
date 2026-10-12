CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_syscomp_wawi_article_1 (
id INTEGER NOT NULL,
test_object_id INTEGER,
country_id INTEGER,
branch_id INTEGER,
source_system_id INTEGER,
source_system_primary_key STRING(100),
is_relevant INTEGER,
artikelnr STRING(18),
artgrupnr INTEGER,
bez_lang STRING(100),
gueltig_ab STRING(40),
wgrupnr INTEGER,
eingel_datum STRING(40),
ausgel_datum STRING(40),
marke STRING(35),
content_hash_code STRING(32)
);