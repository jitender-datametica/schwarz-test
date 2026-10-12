CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_scm_l_wup_cluster_1 AS (SELECT mandant_id,
  wup_cluster_id,
  wup_cluster_bez,
  wup_cluster_descr,
  wup_cluster_del_fg,
  update_timestamp,
  update_user,
  1 AS own_cluster
 FROM kfl_production_dbp_view.v_ts_scm_l_wup_cluster_1 AS V01
 WHERE wup_cluster_del_fg = 0
 UNION DISTINCT
 SELECT mandant_id,
  - 1 AS wup_cluster_id,
  'Alle (DIF)' AS wup_cluster_bez,
  'Alle Markt Cluster (DIF)' AS wup_cluster_descr,
  0 AS wup_cluster_del_fg,
  CURRENT_TIMESTAMP() AS update_timestamp,
  'System' AS update_user,
  0 AS own_cluster
 FROM kfl_production_dbp_view.v_mandant_1 AS V03
 WHERE mandant_id = 1)
UNION DISTINCT
SELECT mandant_id,
 - 99 AS wup_cluster_id,
 'nicht zugeordnet' AS wup_cluster_bez,
 'Markt ist keinem Cluster zugeordnet' AS wup_cluster_descr,
 0 AS wup_cluster_del_fg,
 CURRENT_TIMESTAMP() AS update_timestamp,
 'System' AS update_user,
 0 AS own_cluster
FROM kfl_production_dbp_view.v_mandant_1 AS V03
WHERE mandant_id = 1;