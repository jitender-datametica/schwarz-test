CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_eps_druck_anlass (
mandant_id BIGNUMERIC(38,0) NOT NULL,
druck_anlass_id STRING(2) COLLATE 'und:ci' DEFAULT '-1' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);