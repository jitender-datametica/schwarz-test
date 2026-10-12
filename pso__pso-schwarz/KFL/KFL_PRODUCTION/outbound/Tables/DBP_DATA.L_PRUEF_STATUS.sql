CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_pruef_status (
pruef_status_id BIGNUMERIC(38,0) NOT NULL,
pruef_status_bez STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);