CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_zahlsperre_spr_zu (
mandant_id INTEGER,
zahlsperre_id STRING(1) COLLATE 'und:ci',
spr_id INTEGER,
zahlsperre_bez STRING(40) COLLATE 'und:ci',
system_id INTEGER
);