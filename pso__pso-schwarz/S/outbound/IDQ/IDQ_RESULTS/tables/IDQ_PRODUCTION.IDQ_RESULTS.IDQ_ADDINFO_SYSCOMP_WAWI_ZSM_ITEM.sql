CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_syscomp_wawi_zsm_item (
id BIGNUMERIC(38,0) NOT NULL,
leading_primary_key STRING(1000),
dependent_primary_key STRING(1000),
leading_system_id BIGNUMERIC(38,0),
dependent_system_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
int_artikelnr STRING(20),
artikelnr STRING(18),
deutschtext STRING(40),
wb STRING(14),
artgrupnr INTEGER,
itemfamily_id INTEGER,
content_hash_code STRING(1000)
);