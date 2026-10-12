-- 2024-07-29, dknop, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_werbewoche_kl_1 (kjwo_ww
, akt_kj, mandant_id) AS SELECT DISTINCT v_werbewoche_kl.kjwo_ww,
 v_woche.akt_wo AS akt_kj,
 v_werbewoche_kl.mandant_id
FROM kfl_production_dbp_view.v_werbewoche_kl_1
 INNER JOIN kfl_production_dbp_view.v_woche_1 ON v_werbewoche_kl.kjwo_ww = v_woche.kjwo;