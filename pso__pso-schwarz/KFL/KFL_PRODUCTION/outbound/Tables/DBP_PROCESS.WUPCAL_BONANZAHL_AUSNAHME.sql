CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.wupcal_bonanzahl_ausnahme (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
kasse_nr BIGNUMERIC(38,0) NOT NULL,
dat_von DATE,
td_update TIMESTAMP,
td_insert TIMESTAMP
);