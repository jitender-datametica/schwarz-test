CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_syscomp_wawi_zsm_item_1 (
id INTEGER NOT NULL,
leading_primary_key STRING(1000),
dependent_primary_key STRING(1000),
leading_system_id INTEGER,
dependent_system_id INTEGER,
branch_id INTEGER,
country_id INTEGER,
int_artikelnr STRING(20),
artikelnr STRING(18),
deutschtext STRING(40),
wb STRING(14),
artgrupnr INTEGER,
itemfamily_id INTEGER,
content_hash_code STRING(1000)
);