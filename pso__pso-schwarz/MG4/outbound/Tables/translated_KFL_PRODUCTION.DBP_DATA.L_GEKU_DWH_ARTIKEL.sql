CREATE OR REPLACE TABLE kfl_production_dbp_data.l_geku_dwh_artikel (
geku_dwh_artikel_id INTEGER NOT NULL,
geku_grund_uid INTEGER NOT NULL,
geku_artikel_uid INTEGER,
geku_artikel_id STRING(60) COLLATE 'und:ci' NOT NULL,
wmd_fg INTEGER DEFAULT 0 NOT NULL,
aktiv_fg INTEGER DEFAULT 1 NOT NULL,
alt_fg INTEGER DEFAULT 0 NOT NULL,
geku_artikel_id_alt STRING(255) COLLATE 'und:ci',
fipo_pruefpunkt_id INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);