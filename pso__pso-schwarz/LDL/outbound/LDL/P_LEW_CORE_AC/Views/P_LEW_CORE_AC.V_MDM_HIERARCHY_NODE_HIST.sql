CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_hierarchy_node_hist (client_id, hier_node_sid, hier_node_sid_parent,
hier_node_level, hier_node_root_fg, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 hier_node_sid,
 hier_node_sid_parent,
 hier_node_level,
 hier_node_root_fg,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_hierarchy_node_hist;