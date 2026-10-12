CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_gfk_category_map_ifg_1 (client_id, gfk_cat_sid, sub_item_grp_sid,
item_fam_grp_sid, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 gfk_cat_sid,
 sub_item_grp_sid,
 item_fam_grp_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_gfk_category_map_ifg_1;