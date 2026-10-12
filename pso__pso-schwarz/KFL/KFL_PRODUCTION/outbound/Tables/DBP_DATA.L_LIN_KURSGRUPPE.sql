CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lin_kursgruppe (
lin_kursgruppe_id STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);