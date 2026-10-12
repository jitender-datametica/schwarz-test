CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_immo_zustaendig_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
zustaendig_id BIGNUMERIC(38,0) NOT NULL,
vorname STRING(40) COLLATE 'und:ci',
nachname STRING(40) COLLATE 'und:ci',
anrede STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);