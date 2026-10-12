-- 2022-12-06, AP0150311_SPEC0174516, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ts_scm_cluster_km (cluster_id, cluster_bez,
cluster_element_id, cluster_element_bez) AS SELECT cluster_id,
 cluster_bez,
 cluster_element_id,
 cluster_element_bez
FROM kfl_production_dbp_msi_data.ts_scm_cluster
WHERE cluster_typ_bez LIKE '%Entfernung%';