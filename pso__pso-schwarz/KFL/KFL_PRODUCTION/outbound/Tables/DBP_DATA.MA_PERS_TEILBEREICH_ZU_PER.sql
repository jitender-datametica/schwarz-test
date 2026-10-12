CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_pers_teilbereich_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
pers_teilbereich_id STRING(4) COLLATE 'und:ci' NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
buchungskreis_id BIGNUMERIC(38,0) NOT NULL,
pers_bereich_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);