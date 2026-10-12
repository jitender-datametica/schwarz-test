CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wupcal_bedienkonzept_zu (
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
bedienkonzept_id BIGNUMERIC(38,0) NOT NULL,
anz_kunde BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);