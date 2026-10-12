CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_kol_adv_cbx_predecessor
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT DISTINCT CBX.client_id,
 CBX.client_id_order,
 CBX.pre_item_ian AS item_ian,
 CBX.pre_range_plan_cd AS range_plan_cd,
 t2.adv_dt,
 CBX.dwh_updated
FROM ldl_p_lew_mart_analytics.t_kol_cbx_item_base AS CBX
 LEFT JOIN (SELECT client_id,
   item_ian,
   range_plan_cd,
   adv_dt,
   SUM(sales_qty) AS sales_qty
  FROM ldl_p_lew_mart_analytics.v_kol_adv_wh_predecessor AS ADV_WH
  GROUP BY client_id,
   item_ian,
   range_plan_cd,
   adv_dt
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_ian AS STRING), range_plan_cd ORDER BY
        sales_qty IS NULL, sales_qty)) = 1) AS t2 ON CBX.client_id_order = t2.client_id AND CBX.pre_item_ian = t2.item_ian
      AND CBX.range_plan_cd = t2.range_plan_cd AND t2.adv_dt BETWEEN CBX.pre_range_advertise_from_dt AND CBX.pre_range_advertise_to_dt
   
WHERE CBX.pre_item_ian IS NOT NULL;