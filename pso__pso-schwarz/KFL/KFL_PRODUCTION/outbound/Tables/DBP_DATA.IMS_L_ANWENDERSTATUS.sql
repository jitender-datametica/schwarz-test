CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_l_anwenderstatus (
mandant_id BIGNUMERIC(38,0) NOT NULL,
anwenderstatus_id STRING(5) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);