CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wupcal_ereignis_zu_2 (
dat DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
ereignistyp_id BIGNUMERIC(38,0) NOT NULL,
ereignis_id BIGNUMERIC(38,0) NOT NULL,
offen BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);