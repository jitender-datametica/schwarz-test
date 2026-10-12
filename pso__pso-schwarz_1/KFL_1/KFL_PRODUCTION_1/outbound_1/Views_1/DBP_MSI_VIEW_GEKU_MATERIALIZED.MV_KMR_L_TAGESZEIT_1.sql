CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_kmr_l_tageszeit_1 (tageszeit_id, amx_system_id,
tageszeit_bez) AS SELECT tageszeit_id,
 amx_system_id,
 tageszeit_bez
FROM kfl_production_dbp_view.v_kmr_l_tageszeit_1 AS V01;