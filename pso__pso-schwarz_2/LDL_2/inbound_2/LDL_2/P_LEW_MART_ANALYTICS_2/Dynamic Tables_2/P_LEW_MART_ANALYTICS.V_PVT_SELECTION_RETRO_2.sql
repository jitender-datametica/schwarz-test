
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PVT_SELECTION_RETRO_2
(
      user_id
    , client_id
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
    , sales_2
    , store_count
    , tv
    , radio
    , placement
    , leaflet
    , value1
    , value2
    , value3
    , value4
    , start_dt_plan
    , end_dt_plan
    , week_id
    , price_retail_new_plan
    , price_retail_old_plan
    , countrywide_fg
    , snd_placement_fg
    , flyer_id
    , radio_fg
    , tv_fg
    , price_retail_new_edited
    , piece_forecast_qty
    , piece_forecast_qty_edited
    , discount_rel_pv
    , baseline_net_val
    , period_forecast_desc
    , note
    , comment_strng
    , region_id
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
        selec.user_id,
   retro.client_id,
   retro.pk_id,
   retro.orig_item_nr,
   retro.start_dt,
   retro.end_dt,
   retro.period_id,
   retro.brand_type,
   retro.cannib_effect,
   retro.vat_pct_val,
   retro.price_buying_pv,
   retro.price_retail_old,
   retro.price_retail_new,
   retro.price_retail_receipt,
   retro.pv_value_kpi,
   retro.margin_old,
   retro.margin_new,
   retro.additional_sales_val,
   retro.stock_effect,
   retro.additional_revenue_val,
   retro.base_freq_val,
   retro.additional_freq_val,
   retro.pv_calc_kpi,
   retro.n_actions,
   retro.n_actions_first_page,
   retro.n_actions_inside,
   retro.n_actions_last_page,
   retro.sales_2,
   retro.store_count,
   retro.tv,
   retro.radio,
   retro.placement,
   retro.leaflet,
   retro.value1,
   retro.value2,
   retro.value3,
   retro.value4,
   selec.start_dt AS start_dt_plan,
   selec.end_dt AS end_dt_plan,
   selec.week_id,
   selec.price_retail_new AS price_retail_new_plan,
   selec.price_retail_old AS price_retail_old_plan,
   selec.countrywide_fg,
   selec.snd_placement_fg,
   selec.flyer_id,
   selec.radio_fg,
   selec.tv_fg,
   selec.price_retail_new_edited,
   selec.piece_forecast_qty,
   selec.piece_forecast_qty_edited,
   selec.discount_rel_pv,
   selec.baseline_net_val,
   selec.period_forecast_desc,
   selec.note,
   selec.comment_strng,
   selec.region_id
   FROM p_lew_mart_analytics.t_pvt_retro_2 retro
   INNER JOIN p_lew_mart_analytics.t_pvt_selection_2 selec
   ON retro.client_id = selec.client_id
   AND retro.pk_id = selec.pk_id
   ;
