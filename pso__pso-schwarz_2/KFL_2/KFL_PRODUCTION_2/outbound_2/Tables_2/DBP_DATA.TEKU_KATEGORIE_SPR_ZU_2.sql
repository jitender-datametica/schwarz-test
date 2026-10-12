CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_kategorie_spr_zu_2 (
teku_kategorie_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
teku_kategorie_bez STRING(150) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);