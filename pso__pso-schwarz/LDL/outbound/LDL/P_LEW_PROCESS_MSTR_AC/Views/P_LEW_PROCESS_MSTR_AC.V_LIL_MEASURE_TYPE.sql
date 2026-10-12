CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_measure_type (meas_tp_id, meas_tp_desc, dwh_load_id, dwh_created
, dwh_updated) AS SELECT meas_tp_id,
 meas_tp_desc,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_measure_type;