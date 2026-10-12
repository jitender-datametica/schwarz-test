CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_syscomp_wawi_article (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
source_system_primary_key STRING(100),
is_relevant BIGNUMERIC(38,0),
artikelnr STRING(18),
artgrupnr INTEGER,
bez_lang STRING(100),
gueltig_ab STRING(40),
wgrupnr BIGNUMERIC(38,0),
eingel_datum STRING(40),
ausgel_datum STRING(40),
marke STRING(35),
content_hash_code STRING(32)
);