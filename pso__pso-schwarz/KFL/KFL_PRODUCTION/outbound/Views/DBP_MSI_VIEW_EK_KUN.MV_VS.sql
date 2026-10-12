CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_vs (mandant_id, vs_id, vs_bez) AS SELECT mandant_id,
 vs_id,
 vs_bez
FROM kfl_production_dbp_data.vs AS V01
WHERE mandant_id <> 1
UNION ALL
SELECT DISTINCT mandant_id,
  CASE
  WHEN wup_cluster_id IN (102, 107)
  THEN 1
  WHEN wup_cluster_id IN (101, 103)
  THEN 2
  WHEN wup_cluster_id IN (106, 108)
  THEN 3
  ELSE NULL
  END AS vs_id,
  CASE
  WHEN wup_cluster_id IN (102, 107)
  THEN 'Süd'
  WHEN wup_cluster_id IN (101, 103)
  THEN 'Ost'
  WHEN wup_cluster_id IN (106, 108)
  THEN 'West'
  ELSE NULL
  END AS vs_bez
FROM kfl_production_dbp_data.ts_scm_wup_cluster_zu AS V01
WHERE mandant_id = 1
 AND nb_id = 0;