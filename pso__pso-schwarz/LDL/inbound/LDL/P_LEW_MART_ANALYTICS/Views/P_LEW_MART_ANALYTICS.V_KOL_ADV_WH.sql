CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_KOL_ADV_WH
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
         adv_wh.client_id,
   adv_wh.wh_loc_sid,
   adv_wh.item_ian,
   adv_wh.range_plan_cd,
   adv_wh.adv_dt,
   adv_wh.sales_qty
  FROM p_lew_mart_analytics.t_kol_adv_item AS adv_wh
   QUALIFY ROW_NUMBER() OVER
   (
       PARTITION BY adv_wh.client_id, adv_wh.range_plan_cd, adv_wh.wh_loc_sid, adv_wh.item_ian
       ORDER BY adv_wh.sales_qty DESC NULLS LAST, adv_wh.adv_dt ASC
   ) = 1
;