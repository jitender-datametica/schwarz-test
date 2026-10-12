CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_parent_wh_1 (client_id, parent_wh_loc_sid, parent_wh_desc,
parent_wh_fg, load_id) AS SELECT client_id,
 parent_wh_loc_sid,
 parent_wh_desc,
 parent_wh_fg,
 load_id
FROM ldl_p_lew_core.t_wawi_org_parent_wh_1;