CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_kategorie_spr_zu (
kategorie_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kategorie_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);