CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_wsa_kpi_2 (
mandant_id INTEGER NOT NULL,
region_id STRING(3) COLLATE 'und:ci' NOT NULL,
branche_id INTEGER NOT NULL,
groesse_kategorie STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT '   ' NOT NULL,
umsatz_produktivitaet NUMERIC(18,2) DEFAULT 0 NOT NULL,
kunde_umsatz NUMERIC(18,2) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);