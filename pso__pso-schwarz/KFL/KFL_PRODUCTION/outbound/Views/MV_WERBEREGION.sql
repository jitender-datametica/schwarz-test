CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_werberegion (mandant_id, wreg_id, wreg_bez) AS SELECT
 mandant_id,
  CASE
  WHEN wup_cluster_id IN (102, 107)
  THEN 1
  WHEN wup_cluster_id IN (101, 103)
  THEN 2
  WHEN wup_cluster_id IN (106, 108)
  THEN 3
  ELSE NULL
  END AS wreg_id,
  CASE
  WHEN wup_cluster_id IN (102, 107)
  THEN 'SÜD'
  WHEN wup_cluster_id IN (101, 103)
  THEN 'OST'
  WHEN wup_cluster_id IN (106, 108)
  THEN 'WEST'
  ELSE NULL
  END AS wreg_bez
FROM kfl_production_dbp_data.ts_scm_wup_cluster_zu AS V01
WHERE mandant_id = 1
 AND nb_id = 0
GROUP BY mandant_id,
 wreg_id,
 wreg_bez;