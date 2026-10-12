CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_pvt_selection_retro (user_id, client_id, pk_id, orig_item_nr,
start_dt, end_dt, period_id, brand_type, cannib_effect, vat_pct_val, price_buying_pv, price_retail_old, price_retail_new
, price_retail_receipt, pv_value_kpi, margin_old, margin_new, additional_sales_val, stock_effect, additional_revenue_val
, base_freq_val, additional_freq_val, pv_calc_kpi, n_actions, n_actions_first_page, n_actions_inside,
n_actions_last_page, sales, store_count, tv, radio, placement, leaflet, value1, value2, value3, value4, start_dt_plan,
end_dt_plan, week_id, price_retail_new_plan, price_retail_old_plan, countrywide_fg, snd_placement_fg, flyer_id, radio_fg
, tv_fg, price_retail_new_edited, piece_forecast_qty, piece_forecast_qty_edited, discount_rel_pv, baseline_net_val,
period_forecast_desc, note, comment_strng, region_id) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_pvt_selection_retro;