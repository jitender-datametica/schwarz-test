CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_receiving_count_status (rcv_cnt_status_id, rcv_cnt_status_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT rcv_cnt_status_id,
 rcv_cnt_status_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_receiving_count_status;