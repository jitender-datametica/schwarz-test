CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_geku_zustaendigkeit_1 (
kundenfaktor_id INTEGER,
geku_dwh_artikel_id INTEGER,
kmr_quelle_id INTEGER,
zustaendigkeit STRING(10) COLLATE 'und:ci'
);