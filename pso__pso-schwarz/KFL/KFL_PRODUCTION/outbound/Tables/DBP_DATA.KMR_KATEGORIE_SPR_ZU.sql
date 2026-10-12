CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_kategorie_spr_zu (
kmr_kategorie_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kmr_kategorie_bez STRING(80) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);