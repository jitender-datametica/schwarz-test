CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_beleg_typ (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
beleg_typ_id STRING(6) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);