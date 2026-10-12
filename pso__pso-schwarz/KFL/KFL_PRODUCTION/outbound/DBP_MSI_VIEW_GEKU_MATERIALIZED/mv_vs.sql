CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_vs (
mandant_id INTEGER,
vs_id INTEGER,
ma_anrede STRING(40) COLLATE 'und:ci',
ma_name STRING(160) COLLATE 'und:ci',
ma_vorname STRING(40) COLLATE 'und:ci',
vsvt_bez STRING(160)
);