CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_kreistyp_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kreistyp_id STRING(1) COLLATE 'und:ci' NOT NULL,
vz_prio_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);