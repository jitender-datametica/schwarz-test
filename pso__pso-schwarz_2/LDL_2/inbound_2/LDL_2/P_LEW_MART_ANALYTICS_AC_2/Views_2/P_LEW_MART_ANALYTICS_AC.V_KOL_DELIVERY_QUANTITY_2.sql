CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_DELIVERY_QUANTITY_2
(
      client_id
    , item_ian
    , orig_store_nr
    , adv_store_dt
    , adv_ian_dt
    , range_plan_cd
    , delivery_qty
)
AS
   SELECT
         client_id,
   item_ian,
   orig_store_nr,
   adv_store_dt,
   adv_ian_dt,
   range_plan_cd,
   delivery_qty
  FROM p_lew_mart_analytics.t_kol_delivery_quantity_2
;