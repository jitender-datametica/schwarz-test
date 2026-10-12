-- 2022-12-05, AP0150311_SPEC0174516, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ts_scm_cluster_uhrzeit (cluster_id, cluster_bez,
cluster_element_id, cluster_element_bez) AS SELECT DISTINCT cluster_id,
 cluster_bez,
  CASE
  WHEN cluster_id = 4 AND cluster_element_id = 4
  THEN 3
  ELSE cluster_element_id
  END AS cluster_element_id,
  CASE
  WHEN cluster_id = 4 AND cluster_element_id IN (3, 4)
  THEN 'Nacht'
  ELSE cluster_element_bez
  END AS cluster_element_bez
FROM kfl_production_dbp_msi_data.ts_scm_cluster
WHERE cluster_typ_bez LIKE '%Uhrzeit%';