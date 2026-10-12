CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_data_mask (client_id, region_sid, period_sid,
src_assort_parent_cat_cd, interface_name, mask_data_fg, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 region_sid,
 period_sid,
 src_assort_parent_cat_cd,
 interface_name,
 mask_data_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_data_mask;