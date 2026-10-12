CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_lagereinheit_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagereinheit_id NUMERIC(20,0) NOT NULL,
datzeit_von DATETIME NOT NULL,
datzeit_bis DATETIME,
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
lagernummer_id STRING(4) COLLATE 'und:ci',
lagertyp_id STRING(3) COLLATE 'und:ci',
dat_letzte_bewegung DATE,
spurnummer BIGNUMERIC(38,0),
lager_einheiten_typ STRING(3) COLLATE 'und:ci',
system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
lagerplatz_id STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);