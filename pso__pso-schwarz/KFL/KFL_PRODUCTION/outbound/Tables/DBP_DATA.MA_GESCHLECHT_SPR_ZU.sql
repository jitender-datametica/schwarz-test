CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_geschlecht_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
geschlecht_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
geschlecht_bez STRING(10) COLLATE 'und:ci',
anrede_bez STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);