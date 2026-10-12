CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_meas_grp_1 (meas_grp_id, meas_grp_desc, img_meas_url_link,
meas_grp_text_id, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT meas_grp_id
 ,
 meas_grp_desc,
 img_meas_url_link,
 meas_grp_text_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_meas_grp_1;