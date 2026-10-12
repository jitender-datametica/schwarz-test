CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act_2 (move_to_st_loc_sid, st_loc_sid, store_desc,
client_id, orig_store_nr, move_fg) AS SELECT move_to_st_loc_sid,
 st_loc_sid,
 store_desc,
 client_id,
 orig_store_nr,
 move_fg
FROM ldl_p_lew_core.t_wawi_org_all_store_reloc_act_2;