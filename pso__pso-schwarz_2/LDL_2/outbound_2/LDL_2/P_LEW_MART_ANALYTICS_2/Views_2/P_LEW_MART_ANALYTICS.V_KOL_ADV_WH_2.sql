CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_kol_adv_wh_2 (client_id, wh_loc_sid, item_ian, range_plan_cd, adv_dt,
sales_qty) AS SELECT client_id,
 wh_loc_sid,
 item_ian,
 range_plan_cd,
 adv_dt,
 sales_qty
FROM ldl_p_lew_mart_analytics.t_kol_adv_item_2 AS ADV_WH
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), range_plan_cd, CAST(wh_loc_sid AS STRING), CAST(item_ian AS STRING)
      ORDER BY sales_qty IS NULL, sales_qty, adv_dt IS NULL, adv_dt)) = 1;