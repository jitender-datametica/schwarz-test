CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_scm_l_art_cluster_2 AS (SELECT mandant_id,
  art_cluster_id,
  art_cluster_bez,
  art_cluster_descr,
  art_cluster_del_fg,
  update_timestamp,
  update_user,
  1 AS own_cluster
 FROM kfl_production_dbp_view.v_ts_scm_l_art_cluster_2 AS V01
 WHERE art_cluster_del_fg = 0
 UNION DISTINCT
 SELECT mandant_id,
  - 1 AS art_cluster_id,
  'Alle (DIF)' AS art_cluster_bez,
  'Alle Artikel_2 Cluster (DIF)' AS art_cluster_descr,
  0 AS art_cluster_del_fg,
  CURRENT_TIMESTAMP() AS update_timestamp,
  'System' AS update_user,
  0 AS own_cluster
 FROM kfl_production_dbp_view.v_mandant_2 AS V03
 WHERE mandant_id = 1)
UNION DISTINCT
SELECT mandant_id,
 - 99 AS art_cluster_id,
 'nicht zugeordnet' AS art_cluster_bez,
 'Artikel_2 ist keinem Cluster zugeordnet' AS art_cluster_descr,
 0 AS art_cluster_del_fg,
 CURRENT_TIMESTAMP() AS update_timestamp,
 'System' AS update_user,
 0 AS own_cluster
FROM kfl_production_dbp_view.v_mandant_2 AS V03
WHERE mandant_id = 1;