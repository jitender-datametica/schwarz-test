
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_KOL_ADV_CBX
(
      client_id
    , client_id_order
    , item_ian
    , range_plan_cd
    , adv_dt
    , dwh_updated
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT DISTINCT
         cbx.client_id,
   cbx.client_id_order,
   cbx.item_ian,
   cbx.range_plan_cd,
   adv.adv_dt,
   cbx.dwh_updated
  FROM p_lew_mart_analytics.t_kol_cbx_item_base AS cbx
   LEFT JOIN
   (
       SELECT
             adv_item.client_id,
   adv_item.item_ian,
   adv_item.range_plan_cd,
   adv_item.adv_dt,
   adv_item.sales_qty
      FROM
      (
          SELECT
                adv_wh.client_id,
   adv_wh.item_ian,
   adv_wh.range_plan_cd,
   adv_wh.adv_dt,
   SUM(adv_wh.sales_qty) AS sales_qty
          FROM p_lew_mart_analytics.v_kol_adv_wh AS adv_wh
   GROUP BY 1,2,3,4
) AS adv_item
QUALIFY ROW_NUMBER() OVER
(
   PARTITION BY adv_item.client_id, adv_item.item_ian, adv_item.range_plan_cd
   ORDER BY adv_item.sales_qty DESC NULLS LAST
) = 1
) AS adv
   ON adv.client_id = cbx.client_id_order
   AND adv.item_ian = cbx.item_ian
   AND adv.range_plan_cd = cbx.range_plan_cd
   AND adv.adv_dt BETWEEN cbx.range_advertise_from_dt AND cbx.range_advertise_to_dt
   WHERE cbx.item_ian IS NOT NULL
   ;
