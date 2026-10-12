CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_day_item_adv_asis_2 (client_id, loc_sid_wh, wh_id,
loc_sid_store_move_to, itemgroup_int_id, item_id, dat_adv, dat_formdate, qty_sales, qty_delivery, qty_stc_real,
repeat_fg, timestamp_mod) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_store_day_item_adv_asis_2;