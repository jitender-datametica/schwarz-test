CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_l_geku_artikel_2 (
geku_artikel_uid INTEGER,
geku_artikel_id STRING(60) COLLATE 'und:ci',
geku_grund_uid INTEGER,
land_iso STRING(2) COLLATE 'und:ci',
geku_dwh_artikel_id INTEGER,
kmr_quelle_id INTEGER,
aktiv_fg INTEGER
);