CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_meas_fmt_2 (meas_fmt_id, meas_fmt_colr_desc, meas_fmt_dec,
deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT meas_fmt_id,
 meas_fmt_colr_desc,
 meas_fmt_dec,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_meas_fmt_2;