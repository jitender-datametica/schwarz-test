CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_agg_cntry_itm_mth_sales_asis_2 AS SELECT client_id,
 orig_item_nr,
 dat_valid_from_item,
 cy_month,
 SUM(qty_total) AS qty_total,
 SUM(cnt_store_week) AS cnt_store_week,
  SUM(qty_total) / CASE
   WHEN SUM(cnt_store_week) = 0
   THEN NULL
   ELSE SUM(cnt_store_week)
   END AS avg_qty_sold_per_str_week,
 SUM(val_rtl_ejr_asis) AS val_rtl_ejr_asis,
 SUM(val_rtl_net_ejr_asis) AS val_rtl_net_ejr_asis,
 SUM(val_rtl_str_days_w_sales_asis) AS val_rtl_str_days_w_sales_asis,
 SUM(val_rtl_str_net_days_w_sales_asis) AS val_rtl_str_net_days_w_sales_asis,
   100 * SUM(val_rtl_ejr_asis) / CASE
   WHEN SUM(val_rtl_str_days_w_sales_asis) = 0
   THEN NULL
   ELSE SUM(val_rtl_str_days_w_sales_asis)
   END AS item_turnover_ratio_eff,
   100 * SUM(val_rtl_net_ejr_asis) / CASE
   WHEN SUM(val_rtl_str_net_days_w_sales_asis) = 0
   THEN NULL
   ELSE SUM(val_rtl_str_net_days_w_sales_asis)
   END AS item_turnover_ratio_net_eff
FROM ldl_p_lew_mart_msi.t_agg_wh_itm_mth_sales_asis_2 AS AGG
GROUP BY client_id,
 orig_item_nr,
 dat_valid_from_item,
 cy_month;