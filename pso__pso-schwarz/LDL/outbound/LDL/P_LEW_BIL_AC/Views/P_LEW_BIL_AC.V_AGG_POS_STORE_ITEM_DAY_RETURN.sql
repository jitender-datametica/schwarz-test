CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_pos_store_item_day_return AS SELECT client_id,
 loc_sid_store,
 item_sid,
 dwh_cal_dt,
 return_qty,
 return_reason_cd
FROM ldl_p_lew_bil.t_agg_pos_store_item_day_return;