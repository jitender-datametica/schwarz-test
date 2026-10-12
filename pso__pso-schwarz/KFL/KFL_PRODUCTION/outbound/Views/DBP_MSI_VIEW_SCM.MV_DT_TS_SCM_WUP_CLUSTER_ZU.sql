CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_scm.mv_dt_ts_scm_wup_cluster_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 30) AS
SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 COALESCE(V03.wup_cluster_id, - 99) AS wup_cluster_id,
  CASE
  WHEN V03.wup_cluster_id IS NULL
  THEN 0
  ELSE 1
  END AS wup_cluster_zu_fg
FROM kfl_production_dbp_view.v_wup AS V01
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_wup_cluster_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id =
    V02.wup_id AND V01.nb_id = V02.nb_id
 LEFT JOIN kfl_production_dbp_view.v_ts_scm_l_wup_cluster AS V03 ON V02.mandant_id = V03.mandant_id AND V02.wup_cluster_id
     = V03.wup_cluster_id AND COALESCE(V03.wup_cluster_del_fg, 0) = 0;