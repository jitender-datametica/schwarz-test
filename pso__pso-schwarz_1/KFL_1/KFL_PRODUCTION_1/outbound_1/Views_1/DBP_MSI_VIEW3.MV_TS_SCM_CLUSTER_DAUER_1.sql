CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_ts_scm_cluster_dauer_1 (cluster_id, cluster_bez, cluster_element_id
, cluster_element_bez) AS SELECT cluster_id,
 cluster_bez,
 cluster_element_id,
 cluster_element_bez
FROM kfl_production_dbp_msi_data.ts_scm_cluster_1
WHERE cluster_typ_bez LIKE '%Dauer%';