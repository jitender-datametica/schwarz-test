CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_group_1 (client_id, item_grp_sid, src_matkl, src_wawi_cd, item_grp_name,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_grp_sid,
 src_matkl,
 src_wawi_cd,
 item_grp_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_group_1;