CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ssm_wup_prozess_werbeverteilung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
ssm_prozess_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
wert BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);