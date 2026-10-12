CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_sortiment_preisklasse_uwg_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kl_uwg_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
preislage_1 NUMERIC(9,2),
preislage_2 NUMERIC(9,2),
preislage_3 NUMERIC(9,2),
preislage_4 NUMERIC(9,2),
preislage_5 NUMERIC(9,2),
preislage_6 NUMERIC(9,2),
preislage_7 NUMERIC(9,2),
preislage_8 NUMERIC(9,2),
preislage_9 NUMERIC(9,2),
preislage_10 NUMERIC(9,2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);