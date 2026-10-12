CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_AGG_CNTRY_ITM_MTH_SALES_ASIS_1 as
   SELECT agg.client_id,	
   agg.orig_item_nr,	
   agg.dat_valid_from_item,	
   agg.cy_month,	
   Sum(agg.qty_total) AS qty_total,	
   Sum(agg.cnt_store_week) AS cnt_store_week,	
   Sum(agg.qty_total) / CASE WHEN Sum(agg.cnt_store_week) = 0 THEN null ELSE Sum(agg.cnt_store_week) END AS avg_qty_sold_per_str_week,	
   Sum(agg.val_rtl_ejr_asis) AS val_rtl_ejr_asis,	
   Sum(agg.val_rtl_net_ejr_asis) AS val_rtl_net_ejr_asis,	
   Sum(agg.val_rtl_str_days_w_sales_asis) AS val_rtl_str_days_w_sales_asis,	
   Sum(agg.val_rtl_str_net_days_w_sales_asis) AS val_rtl_str_net_days_w_sales_asis,	
   100 * Sum(agg.val_rtl_ejr_asis) / CASE WHEN Sum(agg.val_rtl_str_days_w_sales_asis) = 0 THEN null ELSE Sum(agg.val_rtl_str_days_w_sales_asis) END AS item_turnover_ratio_eff,	
   100 * Sum(agg.val_rtl_net_ejr_asis) / CASE WHEN Sum(agg.val_rtl_str_net_days_w_sales_asis) = 0 THEN null ELSE Sum(agg.val_rtl_str_net_days_w_sales_asis) END AS item_turnover_ratio_net_eff	
   FROM p_lew_mart_msi.t_agg_wh_itm_mth_sales_asis_1 AS agg	
   GROUP BY agg.client_id,	
       agg.orig_item_nr,	
       agg.dat_valid_from_item,	
       agg.cy_month	
;