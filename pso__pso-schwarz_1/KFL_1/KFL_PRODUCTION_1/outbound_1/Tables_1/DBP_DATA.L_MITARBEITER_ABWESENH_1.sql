CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_mitarbeiter_abwesenh_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
abwesenheit_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);