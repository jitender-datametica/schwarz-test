CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_order_record_pos (client_id, order_record_id, order_record_pos_id, loc_sid,
item_sid, uom_sid, uom_cd, return_reason_mark, return_reason_label, dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated)
AS SELECT client_id,
 order_record_id,
 order_record_pos_id,
 loc_sid,
 item_sid,
 uom_sid,
 uom_cd,
 return_reason_mark,
 return_reason_label,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_order_record_pos;