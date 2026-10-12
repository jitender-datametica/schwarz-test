CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_problemgruppe_spr_zu (
system_id INTEGER,
mandant_id INTEGER,
problemgruppe_id INTEGER,
spr_id INTEGER,
problemgruppe_bez STRING(40) COLLATE 'und:ci'
);