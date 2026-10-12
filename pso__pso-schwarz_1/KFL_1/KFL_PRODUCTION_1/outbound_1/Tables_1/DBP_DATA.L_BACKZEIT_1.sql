CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_backzeit_1 (
ofen_typ_id STRING(2) COLLATE 'und:ci' NOT NULL,
back_programm_id BIGNUMERIC(38,0) NOT NULL,
gp_backen_bez STRING(20) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
back_dauer BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);