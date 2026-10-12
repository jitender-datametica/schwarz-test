CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_pos_store_receipt_day_hour_live (client_id, loc_sid_store, dwh_cal_dt,
receipt_tmsp_hour, receipt_tmsp_half_hour, lidl_plus_fg, turnover_relevant_fg, is_year_seq, cnt_receipt_sales,
total_net_val, dwh_created) AS SELECT client_id,
 loc_sid_store,
 dwh_cal_dt,
 receipt_tmsp_hour,
 receipt_tmsp_half_hour,
 lidl_plus_fg,
 turnover_relevant_fg,
 is_year_seq,
 cnt_receipt_sales,
 total_net_val,
 dwh_created
FROM ldl_p_lew_bil.t_agg_pos_store_receipt_day_hour_live;