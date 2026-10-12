CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_sw_thema (
sw_thema_id BIGNUMERIC(38,0) NOT NULL,
sw_thema_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);