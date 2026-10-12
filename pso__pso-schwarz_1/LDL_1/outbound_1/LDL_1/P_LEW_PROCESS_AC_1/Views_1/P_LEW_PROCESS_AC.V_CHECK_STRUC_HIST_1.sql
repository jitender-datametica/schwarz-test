CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_check_struc_hist_1 (db_name, tbl_name, col_name, col_type, dwh_valid_from,
dwh_valid_to, dwh_real_start, dwh_load_id, dwh_created, dwh_updated) AS SELECT db_name,
 tbl_name,
 col_name,
 col_type,
 dwh_valid_from,
 dwh_valid_to,
 dwh_real_start,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_check_struc_hist_1;