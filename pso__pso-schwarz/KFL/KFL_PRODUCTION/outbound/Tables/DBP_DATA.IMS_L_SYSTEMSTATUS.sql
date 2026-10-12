CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_l_systemstatus (
mandant_id BIGNUMERIC(38,0) NOT NULL,
systemstatus_id STRING(5) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);