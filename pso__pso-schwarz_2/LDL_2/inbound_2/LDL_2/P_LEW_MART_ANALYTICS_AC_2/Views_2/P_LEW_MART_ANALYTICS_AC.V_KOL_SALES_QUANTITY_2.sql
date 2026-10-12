CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_SALES_QUANTITY_2
(
      client_id
    , item_ian
    , item_sid
    , orig_store_nr
    , adv_store_dt
    , adv_ian_dt
    , range_plan_cd
    , ean_barcode_clean
    , sales_hour
    , sales_dt
    , sales_qty
)
AS
   SELECT
         client_id,
   item_ian,
   item_sid,
   orig_store_nr,
   adv_store_dt,
   adv_ian_dt,
   range_plan_cd,
   ean_barcode_clean,
   sales_hour,
   sales_dt,
   sales_qty
  FROM p_lew_mart_analytics.t_kol_sales_quantity_2
;