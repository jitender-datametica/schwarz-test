CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lis_rekl_status_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lis_rekl_status_id STRING(10) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lis_rekl_status_bez STRING(60) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);