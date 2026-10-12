CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_korrekturart_spr_zu_2 (
system_id INTEGER,
mandant_id INTEGER,
korrekturart_id STRING(1) COLLATE 'und:ci',
spr_id INTEGER,
korrekturart_bez STRING(40) COLLATE 'und:ci'
);