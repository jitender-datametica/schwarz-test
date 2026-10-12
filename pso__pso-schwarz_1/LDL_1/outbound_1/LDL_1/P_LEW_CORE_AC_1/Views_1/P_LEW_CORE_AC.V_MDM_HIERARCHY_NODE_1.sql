CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_hierarchy_node_1 (client_id, hier_node_sid, src_hierarchy_cd,
src_hier_node_path, hier_node_cd, hier_node_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 hier_node_sid,
 src_hierarchy_cd,
 src_hier_node_path,
 hier_node_cd,
 hier_node_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_hierarchy_node_1;