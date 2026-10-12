CREATE OR REPLACE TABLE dbp_msi_view_reb.ts_rohertrag_kommentar_ww_zu (
mandant_id INTEGER NOT NULL,
kjwo_ww INTEGER NOT NULL,
kommentar STRING(80) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
);