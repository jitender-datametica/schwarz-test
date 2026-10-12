CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_cal_busyear_1 (busyear, busyear_begin_month, busyear_end_month, busyear_cy_diff
, cy_by_seq, dwh_load_id, dwh_created, dwh_updated) AS SELECT busyear,
 busyear_begin_month,
 busyear_end_month,
 busyear_cy_diff,
 cy_by_seq,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_busyear_1;