CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tag_stunde (
dat DATE NOT NULL,
stunde BIGNUMERIC(38,0) NOT NULL,
stunde_minuten STRING(5) COLLATE 'und:ci' NOT NULL,
dat_zeit DATETIME NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);