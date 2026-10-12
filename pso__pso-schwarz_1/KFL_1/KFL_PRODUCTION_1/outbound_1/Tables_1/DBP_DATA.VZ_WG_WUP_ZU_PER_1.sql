CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vz_wg_wup_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
wg_hierarchie_ebene_id BIGNUMERIC(38,0) NOT NULL,
wg_hierarchie_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
vz_wup_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
vz_prio_id BIGNUMERIC(38,0),
kreistyp_id STRING(1) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);