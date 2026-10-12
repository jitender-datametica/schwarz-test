CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ginfo_betreiberart_1 (
betreiberart_id BIGNUMERIC(38,0) NOT NULL,
betreiberart_bez STRING(80) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);