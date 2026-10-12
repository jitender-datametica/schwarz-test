CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_KOL_ADV_ITEM_2
(
      client_id
    , range_plan_cd
    , wh_loc_sid
    , item_ian
    , adv_dt
    , sales_qty
)
AS
   SELECT
         client_id,
   range_plan_cd,
   wh_loc_sid,
   item_ian,
   adv_dt,
   sales_qty
  FROM p_lew_mart_analytics.t_kol_adv_item_2
;