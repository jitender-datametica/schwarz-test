CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_order_record_2 (client_id, order_record_id, sup_sid, loc_sid, order_type_cd,
dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 order_record_id,
 sup_sid,
 loc_sid,
 order_type_cd,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_order_record_2;