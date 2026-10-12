CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.shr_datenfreigabe (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
nat_int_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
freigabe_uhrzeit BIGNUMERIC(38,0) NOT NULL,
shr_freigabe_fg BIGNUMERIC(38,0) NOT NULL,
dat_freigabe_kennzahlen DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);