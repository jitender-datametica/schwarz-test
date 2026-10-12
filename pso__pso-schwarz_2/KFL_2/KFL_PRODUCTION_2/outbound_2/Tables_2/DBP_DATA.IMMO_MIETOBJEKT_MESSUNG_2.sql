CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_mietobjekt_messung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mo_intreno STRING(20) COLLATE 'und:ci' NOT NULL,
bemessung_art_id STRING(4) COLLATE 'und:ci' NOT NULL,
dat_bis DATE NOT NULL,
dat_von DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
groesse NUMERIC(18,4) DEFAULT 0 NOT NULL,
groesse_einheit STRING(3) COLLATE 'und:ci' DEFAULT '   ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);