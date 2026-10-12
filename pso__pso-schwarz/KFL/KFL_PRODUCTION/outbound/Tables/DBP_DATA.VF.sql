CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vf (
vf_id BIGNUMERIC(38,0) NOT NULL,
vf_name STRING(40) COLLATE 'und:ci',
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);