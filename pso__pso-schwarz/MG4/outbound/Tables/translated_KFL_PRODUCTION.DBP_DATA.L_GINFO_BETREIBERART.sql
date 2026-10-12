CREATE OR REPLACE TABLE kfl_production_dbp_data.l_ginfo_betreiberart (
betreiberart_id INTEGER NOT NULL,
betreiberart_bez STRING(80) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);