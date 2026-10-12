CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.ma_abwesenh_berechnung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
abwesenheit_id STRING(4) COLLATE 'und:ci' NOT NULL,
krank_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);