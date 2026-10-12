CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_region_2 (mandant_id, region_id, vs_id_alt, region_kbez,
region_bez) AS SELECT mandant_id,
 wup_cluster_id AS region_id,
  wup_cluster_id - 100 AS vs_id_alt,
 wup_cluster_bez AS region_kbez,
 wup_cluster_descr AS region_bez
FROM kfl_production_dbp_view.v_ts_scm_l_wup_cluster_2
WHERE wup_cluster_id IN (101, 102, 103, 106, 107, 108)
 AND mandant_id = 1
UNION ALL
SELECT mandant_id,
 vs_id AS region_id,
 vs_id AS vs_id_alt,
 vs_bez AS region_kbez,
 vs_bez AS region_bez
FROM kfl_production_dbp_view.v_vs_2
WHERE mandant_id <> 1;