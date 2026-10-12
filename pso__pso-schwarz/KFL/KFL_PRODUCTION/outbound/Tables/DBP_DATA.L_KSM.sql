CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ksm (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ksm_id STRING(4) COLLATE 'und:ci' DEFAULT '-1' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);