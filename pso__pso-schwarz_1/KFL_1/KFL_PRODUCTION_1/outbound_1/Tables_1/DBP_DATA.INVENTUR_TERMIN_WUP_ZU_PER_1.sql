CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_termin_wup_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_plan_zaehlung DATE NOT NULL,
inventur_abnahme_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);