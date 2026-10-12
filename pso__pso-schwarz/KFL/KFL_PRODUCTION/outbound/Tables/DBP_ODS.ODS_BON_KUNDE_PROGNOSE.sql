CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_kunde_prognose (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
zeit_stunde BIGNUMERIC(38,0) NOT NULL,
zeit_minute BIGNUMERIC(38,0) NOT NULL,
anz_kunden BIGNUMERIC(38,0),
anz_kunden_prognose NUMERIC(9,6),
anz_kunden_prognose_dyn NUMERIC(9,6),
anz_kassen_offen BIGNUMERIC(38,0),
anz_kassen_prognose BIGNUMERIC(38,0),
anz_kassen_prognose_dyn BIGNUMERIC(38,0),
datzeit_update DATETIME,
td_insert TIMESTAMP,
td_update TIMESTAMP
);