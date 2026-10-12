CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_wirtschaftseinheit_messung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
we_intreno STRING(20) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
bemessung_art_id STRING(4) COLLATE 'und:ci',
groesse NUMERIC(18,4) DEFAULT 0 NOT NULL,
groesse_einheit STRING(3) COLLATE 'und:ci' DEFAULT '   ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);