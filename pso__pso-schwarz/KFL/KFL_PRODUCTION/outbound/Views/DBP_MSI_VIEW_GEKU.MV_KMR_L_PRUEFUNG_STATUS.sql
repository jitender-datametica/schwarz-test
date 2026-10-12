CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_pruefung_status (pruefung_status_id, amx_system_id,
pruefung_status_bez) AS SELECT pruefung_status_id,
 amx_system_id,
 pruefung_status_bez
FROM kfl_production_dbp_view.v_kmr_l_pruefung_status AS V01;