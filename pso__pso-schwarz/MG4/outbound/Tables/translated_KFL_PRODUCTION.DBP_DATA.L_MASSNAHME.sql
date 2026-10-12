CREATE OR REPLACE TABLE kfl_production_dbp_data.l_massnahme (
massnahme_id STRING(20) COLLATE 'und:ci' NOT NULL,
massnahmenart_id INTEGER DEFAULT - 1 NOT NULL,
massnahme_akt_fg INTEGER DEFAULT 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);