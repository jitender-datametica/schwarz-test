CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_cluster (cluster_id, cluster_desc, sorting_order, load_id) AS SELECT
 cluster_id,
 cluster_desc,
 sorting_order,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_cluster;