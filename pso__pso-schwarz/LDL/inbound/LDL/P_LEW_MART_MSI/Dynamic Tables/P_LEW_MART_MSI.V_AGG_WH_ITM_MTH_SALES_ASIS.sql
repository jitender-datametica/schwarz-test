
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_WH_ITM_MTH_SALES_ASIS 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
      SELECT
          agg.client_id,
      wh.src_wh_id AS wh_id,
      agg.orig_item_nr,
      agg.dat_valid_from_item,
      agg.cy_month,
      agg.qty_total,
      agg.cnt_store_week,
      agg.avg_qty_sold_per_str_week,
      (agg.val_rtl_ejr_asis / cry.rate_currency_exchange) AS val_rtl_ejr_asis,
      (agg.val_rtl_net_ejr_asis / cry.rate_currency_exchange) AS val_rtl_net_ejr_asis,
      (agg.val_rtl_str_days_w_sales_asis / cry.rate_currency_exchange) AS val_rtl_str_days_w_sales_asis,
      (agg.val_rtl_str_net_days_w_sales_asis / cry.rate_currency_exchange) AS val_rtl_str_net_days_w_s_asis,
      agg.item_turnover_ratio_eff,
      agg.item_turnover_ratio_net_eff,
      cry.currency_iso_cd
      FROM p_lew_mart_msi.t_agg_wh_itm_mth_sales_asis AS agg
      INNER JOIN p_lew_bil_ac.v_warehouse AS wh
      ON wh.client_id = agg.client_id
      AND wh.loc_sid_wh =  agg.wh_loc_sid
      AND wh.dwh_actual_fg = 1
      INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
      ON  agg.client_id = cry.client_id
      AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
