CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_frage_status_2 (frage_status_id, amx_system_id,
frage_status_bez) AS SELECT frage_status_id,
 amx_system_id,
 frage_status_bez
FROM kfl_production_dbp_view.v_kmr_l_frage_status_2;