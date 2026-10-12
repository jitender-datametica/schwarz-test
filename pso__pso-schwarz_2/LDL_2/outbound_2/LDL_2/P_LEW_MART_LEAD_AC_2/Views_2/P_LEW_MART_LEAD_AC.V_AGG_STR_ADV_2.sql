CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_str_adv_2 (client_id, loc_sid_store_move_to, loc_sid_wh, wh_id,
flg_itm_grp, dat_adv, qty_sales_1_day, qty_sales_3_day, qty_sales_7_day, qty_stc_real_1_day, qty_delivery_1_day,
qty_stc_real_3_day, qty_delivery_3_day, qty_stc_real_7_day, qty_delivery_7_day, timestamp_mod) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_str_adv_2;