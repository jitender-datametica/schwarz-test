CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_region_2 (mandant_id, region_id, vs_id_alt, region_kbez,
region_bez) AS SELECT mandant_id,
 wup_cluster_id AS region_id,
  wup_cluster_id - 100 AS vs_id_alt,
 wup_cluster_bez AS region_kbez,
 wup_cluster_descr AS region_bez
FROM kfl_production_dbp_view.v_ts_scm_l_wup_cluster_2 AS LWC
WHERE wup_cluster_id IN (101, 102, 103, 106, 107, 108)
UNION DISTINCT
SELECT mandant_id,
 - 1 AS region_id,
 - 1 AS vs_id_alt,
 '-/-' AS region_kbez,
 'Keine Zuordnung' AS region_bez
FROM kfl_production_dbp_view.v_mandant_2;