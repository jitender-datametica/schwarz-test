CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_plan_tag_co_v2_1 (
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
regression_faktor_var NUMERIC(18,6) NOT NULL,
regression_faktor_fix NUMERIC(18,6) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);