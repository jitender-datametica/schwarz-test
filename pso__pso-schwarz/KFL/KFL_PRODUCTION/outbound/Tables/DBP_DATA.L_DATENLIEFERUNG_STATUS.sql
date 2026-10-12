CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_datenlieferung_status (
datenlieferung_status_id BIGNUMERIC(38,0) NOT NULL,
datenlieferung_bez STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);