CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_gp_fehlerart_spr_zu (
system_id INTEGER,
mandant_id INTEGER,
gp_fehlerart_id STRING(1) COLLATE 'und:ci',
spr_id INTEGER,
gp_fehlerart_bez STRING(40) COLLATE 'und:ci'
);