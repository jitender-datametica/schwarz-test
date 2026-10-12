CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.zeit_2 (
zeit_stunde BIGNUMERIC(38,0) NOT NULL,
zeit_minute BIGNUMERIC(38,0) NOT NULL,
zeit_von STRING(5) COLLATE 'und:ci' NOT NULL,
zeit_bis_15min STRING(5) COLLATE 'und:ci' NOT NULL,
zeit_bis_30min STRING(5) COLLATE 'und:ci' NOT NULL,
zeit_bis_1_h STRING(5) COLLATE 'und:ci' NOT NULL,
aktuell_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);