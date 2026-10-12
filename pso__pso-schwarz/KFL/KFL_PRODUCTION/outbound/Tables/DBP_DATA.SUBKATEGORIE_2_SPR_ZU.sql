CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.subkategorie_2_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
subkategorie_2_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
subkategorie_2_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);