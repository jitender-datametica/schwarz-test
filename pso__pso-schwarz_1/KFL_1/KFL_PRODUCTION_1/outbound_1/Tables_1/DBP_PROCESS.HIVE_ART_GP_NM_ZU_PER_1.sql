CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.hive_art_gp_nm_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL,
dat_bis DATE NOT NULL,
vz_wup_id BIGNUMERIC(38,0) NOT NULL,
bq_findung_id BIGNUMERIC(38,0) NOT NULL,
bezugsweg_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);