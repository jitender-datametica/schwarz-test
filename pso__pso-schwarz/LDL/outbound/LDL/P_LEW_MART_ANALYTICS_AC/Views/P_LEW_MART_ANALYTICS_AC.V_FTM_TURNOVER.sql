CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_ftm_turnover (client_id, country_code, dat_formdate, cy_week,
store_id, orig_store_nr, item_id, orig_item_nr, itemgroup_int_id, subitemgroup_id, item_type, sales_net_val,
sales_pieces_ejr, buying_val, sales_based_margin, sales_based_margin_pct) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_ftm_turnover;