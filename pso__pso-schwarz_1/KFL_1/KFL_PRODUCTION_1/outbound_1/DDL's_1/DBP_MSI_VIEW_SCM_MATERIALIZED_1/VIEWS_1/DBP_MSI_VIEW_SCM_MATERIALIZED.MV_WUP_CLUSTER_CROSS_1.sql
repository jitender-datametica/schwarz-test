CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wup_cluster_cross_1 (mandant_id, wup_id, nb_id,
wup_cluster_id, wup_cluster_cross_fg) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V02.wup_cluster_id,
  CASE
  WHEN V03.wup_cluster_id IS NULL
  THEN 0
  ELSE 1
  END AS wup_cluster_cross_fg
FROM kfl_production_dbp_view.v_wup_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_ts_scm_l_wup_cluster_1 AS V02 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_wup_cluster_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wup_id =
     V03.wup_id AND V01.nb_id = V03.nb_id AND V02.wup_cluster_id = V03.wup_cluster_id;