CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PVT_FORECAST_2
(
      client_id
    , orig_item_nr
    , start_dt
    , end_dt
    , period_id
    , week_id
    , discount_rel_pv
    , price_retail_asis
    , freq_asis_pv
    , piece_forecast_qty
    , baseline_net_val
    , snd_placement_fg
    , flyer_id
    , tv_radio_fg
    , null_hist_fg
    , frequency_prediction
    , frequency_baseline
    , value1
    , value2
    , partkey
    , uap_filename
    , mod_tmsp
)
AS
   SELECT
         client_id,
   orig_item_nr,
   start_dt,
   end_dt,
   period_id,
   week_id,
   discount_rel_pv,
   price_retail_asis,
   freq_asis_pv,
   piece_forecast_qty,
   baseline_net_val,
   snd_placement_fg,
   flyer_id,
   tv_radio_fg,
   null_hist_fg,
   frequency_prediction,
   frequency_baseline,
   value1,
   value2,
   partkey,
   uap_filename,
   mod_tmsp
  FROM p_lew_mart_analytics.t_pvt_forecast_2
;