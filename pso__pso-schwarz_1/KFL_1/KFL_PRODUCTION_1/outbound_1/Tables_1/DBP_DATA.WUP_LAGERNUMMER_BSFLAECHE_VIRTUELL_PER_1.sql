CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_lagernummer_bsflaeche_virtuell_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
bsflaeche_id BIGNUMERIC(38,0) NOT NULL,
doppelbelegung_fg BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE,
bsf_virtuell_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);