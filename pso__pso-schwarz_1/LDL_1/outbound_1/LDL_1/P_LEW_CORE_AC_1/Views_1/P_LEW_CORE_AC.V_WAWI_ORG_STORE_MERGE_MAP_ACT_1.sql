CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_store_merge_map_act_1 (aspect_id, client_id, st_loc_sid,
move_to_st_loc_sid, wh_loc_sid) AS SELECT aspect_id,
 client_id,
 st_loc_sid,
 move_to_st_loc_sid,
 wh_loc_sid
FROM ldl_p_lew_core.t_wawi_org_store_merge_map_act_1;