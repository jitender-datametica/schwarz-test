CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_ruecklastschrift_2 (
debitor_id INTEGER NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
dat_beleg DATE,
beleg_betrag NUMERIC(18,4),
wrg_id STRING(3),
td_insert TIMESTAMP,
td_update TIMESTAMP
);