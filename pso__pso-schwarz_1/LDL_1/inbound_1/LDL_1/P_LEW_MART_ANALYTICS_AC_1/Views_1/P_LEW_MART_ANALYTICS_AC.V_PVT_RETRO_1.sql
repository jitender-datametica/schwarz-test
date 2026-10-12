CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PVT_RETRO_1
(
      client_id
    , pk_id
    , orig_item_nr
    , start_dt
    , end_dt
    , period_id
    , brand_type
    , cannib_effect
    , vat_pct_val
    , price_buying_pv
    , price_retail_old
    , price_retail_new
    , price_retail_receipt
    , pv_value_kpi
    , margin_old
    , margin_new
    , additional_sales_val
    , stock_effect
    , additional_revenue_val
    , base_freq_val
    , additional_freq_val
    , pv_calc_kpi
    , n_actions
    , n_actions_first_page
    , n_actions_inside
    , n_actions_last_page
    , sales_1
    , store_count
    , tv
    , radio
    , placement
    , leaflet
    , value1
    , value2
    , value3
    , value4
    , partkey
    , uap_filename
    , mod_tmsp
)
AS
   SELECT
         client_id,
   pk_id,
   orig_item_nr,
   start_dt,
   end_dt,
   period_id,
   brand_type,
   cannib_effect,
   vat_pct_val,
   price_buying_pv,
   price_retail_old,
   price_retail_new,
   price_retail_receipt,
   pv_value_kpi,
   margin_old,
   margin_new,
   additional_sales_val,
   stock_effect,
   additional_revenue_val,
   base_freq_val,
   additional_freq_val,
   pv_calc_kpi,
   n_actions,
   n_actions_first_page,
   n_actions_inside,
   n_actions_last_page,
   sales_1,
   store_count,
   tv,
   radio,
   placement,
   leaflet,
   value1,
   value2,
   value3,
   value4,
   partkey,
   uap_filename,
   mod_tmsp
  FROM p_lew_mart_analytics.t_pvt_retro_1
;