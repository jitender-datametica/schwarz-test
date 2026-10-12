-- AP0150311_SPEC0174516, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ts_scm_cluster (cluster_typ_id
, cluster_typ_bez, cluster_id, cluster_bez, cluster_element_id, cluster_element_bez, zeit_von, zeit_bis, wert_von,
wert_bis) AS SELECT cluster_typ_id,
 cluster_typ_bez,
 cluster_id,
 cluster_bez,
 cluster_element_id,
 cluster_element_bez,
 zeit_von,
 zeit_bis,
 wert_von,
 wert_bis
FROM kfl_production_dbp_msi_data.ts_scm_cluster;