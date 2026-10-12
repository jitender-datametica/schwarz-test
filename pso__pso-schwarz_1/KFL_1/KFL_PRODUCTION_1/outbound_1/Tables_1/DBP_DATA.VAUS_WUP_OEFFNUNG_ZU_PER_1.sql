CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vaus_wup_oeffnung_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
wup_oeffnungs_typ_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
zeit_von BIGNUMERIC(38,0) NOT NULL,
zeit_bis BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);