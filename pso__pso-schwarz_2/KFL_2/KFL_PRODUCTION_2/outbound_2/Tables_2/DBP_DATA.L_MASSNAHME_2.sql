CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_massnahme_2 (
massnahme_id STRING(20) COLLATE 'und:ci' NOT NULL,
massnahmenart_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
massnahme_akt_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);