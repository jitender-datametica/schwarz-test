CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_art_umrech_faktor_1 (
in_art_id BIGNUMERIC(38,0) NOT NULL,
altnv_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
umrech_faktor BIGNUMERIC(18,14) NOT NULL,
gew_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);