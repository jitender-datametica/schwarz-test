CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_personalbereich_zu_per_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
buchungskreis_id BIGNUMERIC(38,0) NOT NULL,
mitarbeiter_id STRING(20) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);