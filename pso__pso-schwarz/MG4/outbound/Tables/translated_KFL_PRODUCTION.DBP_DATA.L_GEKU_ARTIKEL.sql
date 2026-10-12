CREATE OR REPLACE TABLE kfl_production_dbp_data.l_geku_artikel (
geku_artikel_uid INTEGER NOT NULL,
geku_artikel_id STRING(60) COLLATE 'und:ci' NOT NULL,
geku_grund_uid INTEGER NOT NULL,
land_iso STRING(2) COLLATE 'und:ci' NOT NULL,
geku_dwh_artikel_id INTEGER,
aktiv_fg INTEGER DEFAULT 1 NOT NULL,
alt_fg INTEGER DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);