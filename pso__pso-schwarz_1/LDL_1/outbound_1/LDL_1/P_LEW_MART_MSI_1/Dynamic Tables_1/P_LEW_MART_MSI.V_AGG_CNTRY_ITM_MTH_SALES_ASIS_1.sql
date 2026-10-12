CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_agg_cntry_itm_mth_sales_asis_1 AS
SELECT AGG.client_id,
 AGG.orig_item_nr,
 AGG.dat_valid_from_item,
 AGG.cy_month,
 AGG.qty_total,
 AGG.cnt_store_week,
 AGG.avg_qty_sold_per_str_week,
  AGG.val_rtl_ejr_asis / CRY.rate_currency_exchange AS val_rtl_ejr_asis,
  AGG.val_rtl_net_ejr_asis / CRY.rate_currency_exchange AS val_rtl_net_ejr_asis,
  AGG.val_rtl_str_days_w_sales_asis / CRY.rate_currency_exchange AS val_rtl_str_days_w_sales_asis,
  AGG.val_rtl_str_net_days_w_sales_asis / CRY.rate_currency_exchange AS val_rtl_str_net_days_w_s_asis,
 AGG.item_turnover_ratio_eff,
 AGG.item_turnover_ratio_net_eff,
 CRY.currency_iso_cd
FROM ldl_p_lew_mart_msi.t_agg_cntry_itm_mth_sales_asis_1 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;