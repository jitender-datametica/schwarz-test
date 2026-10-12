CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.linbew_maks_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lin_kurs_id STRING(10) COLLATE 'und:ci' NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
maks_id STRING(20) COLLATE 'und:ci' NOT NULL,
learning_historie_fg BIGNUMERIC(38,0) NOT NULL,
dat_ausbildung_von DATE NOT NULL,
dat_ausbildung_bis DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
rate_group BIGNUMERIC(38,0) NOT NULL,
ausbildung_id STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);