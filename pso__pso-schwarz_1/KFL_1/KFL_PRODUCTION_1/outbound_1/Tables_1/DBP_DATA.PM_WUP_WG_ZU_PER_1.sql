CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pm_wup_wg_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
wg_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
pm_id BIGNUMERIC(38,0),
dat_bis DATE,
spr_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);