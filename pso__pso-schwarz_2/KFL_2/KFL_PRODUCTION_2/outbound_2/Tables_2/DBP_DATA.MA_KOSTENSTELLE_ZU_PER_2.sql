CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_kostenstelle_zu_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);