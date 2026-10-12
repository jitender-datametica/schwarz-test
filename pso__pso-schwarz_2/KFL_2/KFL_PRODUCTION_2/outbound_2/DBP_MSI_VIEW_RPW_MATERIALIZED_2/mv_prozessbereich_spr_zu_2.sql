CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_prozessbereich_spr_zu_2 (
system_id INTEGER,
mandant_id INTEGER,
prozessbereich_id STRING(10) COLLATE 'und:ci',
spr_id INTEGER,
prozessbereich_bez STRING(60) COLLATE 'und:ci'
);