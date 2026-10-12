CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lief_einteilung (
mandant_id BIGNUMERIC(38,0) NOT NULL,
best_beleg_id INTEGER NOT NULL,
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
einteil_id BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
charge_id STRING(10) COLLATE 'und:ci' NOT NULL,
dat_lief_wunsch DATE NOT NULL,
zeit_lief_wunsch BIGNUMERIC(38,0) NOT NULL,
datzeit_lief_wunsch DATETIME NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
datzeit_lief_wunsch_az DATETIME NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);