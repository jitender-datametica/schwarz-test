CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_tr_category_ifg_1 (client_id, sub_item_grp_sid, item_fam_grp_sid,
active_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 sub_item_grp_sid,
 item_fam_grp_sid,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_tr_category_ifg_1;