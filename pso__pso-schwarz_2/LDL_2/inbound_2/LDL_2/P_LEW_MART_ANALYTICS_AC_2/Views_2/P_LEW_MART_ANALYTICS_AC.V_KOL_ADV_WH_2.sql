CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_ADV_WH_2
(
      client_id
    , wh_loc_sid
    , item_ian
    , range_plan_cd
    , adv_dt
    , sales_qty
)
AS
   SELECT
         client_id,
   wh_loc_sid,
   item_ian,
   range_plan_cd,
   adv_dt,
   sales_qty
  FROM p_lew_mart_analytics.v_kol_adv_wh_2
;