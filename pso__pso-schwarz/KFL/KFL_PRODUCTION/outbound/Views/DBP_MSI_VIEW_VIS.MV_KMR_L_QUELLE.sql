CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_l_quelle (kmr_quelle_id, kmr_quelle_bez) AS SELECT
 kmr_quelle_id,
 kmr_quelle_bez
FROM kfl_production_dbp_view.v_kmr_l_quelle;