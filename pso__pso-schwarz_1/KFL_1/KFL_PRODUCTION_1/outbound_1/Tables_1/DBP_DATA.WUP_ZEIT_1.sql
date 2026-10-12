CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_zeit_1 (
dat DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
umsatz_brutto NUMERIC(12,2),
bonanzahl BIGNUMERIC(38,0),
zeit_stunde BIGNUMERIC(38,0),
zeit_minute BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);