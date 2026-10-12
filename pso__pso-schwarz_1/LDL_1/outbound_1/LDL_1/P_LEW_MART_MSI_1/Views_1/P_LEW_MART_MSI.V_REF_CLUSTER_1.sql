CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_cluster_1 (cluster_id, cluster_desc, sorting_order) AS SELECT cluster_id,
 cluster_desc,
 sorting_order
FROM ldl_p_lew_core_ac.v_wawi_ref_cluster_1 AS V;