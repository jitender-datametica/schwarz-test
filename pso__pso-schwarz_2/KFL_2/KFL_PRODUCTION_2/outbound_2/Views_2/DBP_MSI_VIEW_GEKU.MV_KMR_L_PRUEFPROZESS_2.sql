CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_pruefprozess_2 (gepr_prozess_id, amx_system_id,
gepr_prozess_imp_referenz, gepr_prozess_bez) AS SELECT gepr_prozess_id,
 amx_system_id,
 gepr_prozess_imp_referenz,
 gepr_prozess_bez
FROM kfl_production_dbp_view.v_kmr_l_pruefprozess_2 AS V01;