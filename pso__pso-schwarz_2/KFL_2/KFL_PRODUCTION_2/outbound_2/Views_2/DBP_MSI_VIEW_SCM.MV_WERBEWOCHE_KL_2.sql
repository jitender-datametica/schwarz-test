CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_werbewoche_kl_2 (kjwo_ww, akt_kj, mandant_id) AS SELECT DISTINCT
 v_werbewoche_kl.kjwo_ww,
 v_woche.akt_wo AS akt_kj,
 v_werbewoche_kl.mandant_id
FROM kfl_production_dbp_view.v_werbewoche_kl_2
 INNER JOIN kfl_production_dbp_view.v_woche_2 ON v_werbewoche_kl.kjwo_ww = v_woche.kjwo;