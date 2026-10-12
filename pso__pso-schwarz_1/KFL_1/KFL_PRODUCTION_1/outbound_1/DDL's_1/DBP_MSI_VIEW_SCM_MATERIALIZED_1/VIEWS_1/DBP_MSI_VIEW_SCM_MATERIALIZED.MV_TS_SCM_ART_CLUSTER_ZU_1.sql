CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ts_scm_art_cluster_zu_1 (mandant_id, art_id,
art_cluster_id, art_cluster_zu_fg) AS SELECT V01.mandant_id,
 V01.art_id,
 COALESCE(V03.art_cluster_id, -99) AS art_cluster_id,
  CASE
  WHEN V03.art_cluster_id IS NULL
  THEN 0
  ELSE 1
  END AS art_cluster_zu_fg
FROM kfl_production_dbp_view.v_art_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_art_cluster_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id =
   V02.art_id
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_l_art_cluster_1 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.art_cluster_id
     = V03.art_cluster_id AND COALESCE(V03.art_cluster_del_fg, 0) = 0;