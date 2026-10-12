CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rech_erfassung_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
erfassung_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);