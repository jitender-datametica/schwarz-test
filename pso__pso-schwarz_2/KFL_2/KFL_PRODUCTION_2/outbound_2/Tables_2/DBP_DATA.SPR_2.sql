CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.spr_2 (
spr_id BIGNUMERIC(38,0) NOT NULL,
spr_name STRING(40) COLLATE 'und:ci',
spr_iso STRING(2) COLLATE 'und:ci',
dwh_spr BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);