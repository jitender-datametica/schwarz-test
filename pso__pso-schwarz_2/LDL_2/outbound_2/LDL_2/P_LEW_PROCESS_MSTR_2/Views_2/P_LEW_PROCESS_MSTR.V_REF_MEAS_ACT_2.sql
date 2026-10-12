CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_meas_act_2 (meas_id, meas_desc, meas_type_id, meas_grp_id,
curr_meas_fg, mstr_mtrc_guid, meas_fmt_id, unit_text_id, tot_fl, avg_fl, deleted_fg, dwh_valid_from, dwh_valid_to,
dwh_load_id, dwh_created, dwh_updated) AS SELECT meas_id,
 meas_desc,
 meas_type_id,
 meas_grp_id,
 curr_meas_fg,
 mstr_mtrc_guid,
 meas_fmt_id,
 unit_text_id,
 tot_fl,
 avg_fl,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_meas_2
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0;