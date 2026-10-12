CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_data_confidence_1 (data_confidence_fg, data_confidence_desc,
dwh_load_id, dwh_created, dwh_updated) AS SELECT data_confidence_fg,
 data_confidence_desc,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_data_confidence_1;