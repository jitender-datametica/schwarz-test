CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PVT_SELECTION_1
(
      client_id
    , pk_id
    , user_id
    , start_dt
    , end_dt
    , week_id
    , price_retail_new
    , price_retail_old
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
AS
   SELECT
         client_id,
   pk_id,
   user_id,
   start_dt,
   end_dt,
   week_id,
   price_retail_new,
   price_retail_old,
   countrywide_fg,
   snd_placement_fg,
   flyer_id,
   radio_fg,
   tv_fg,
   price_retail_new_edited,
   piece_forecast_qty,
   piece_forecast_qty_edited,
   discount_rel_pv,
   baseline_net_val,
   period_forecast_desc,
   note,
   comment_strng,
   region_id
  FROM p_lew_mart_analytics.t_pvt_selection_1
;