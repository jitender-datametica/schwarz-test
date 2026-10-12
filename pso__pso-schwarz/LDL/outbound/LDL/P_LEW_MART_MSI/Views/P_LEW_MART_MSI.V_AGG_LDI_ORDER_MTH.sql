/*
 * ----------------------------------------------------------------------------
 *  History:
 * 
 *   Vrs Date       Developer               Task
 *   --- ---------- ----------------------- --------------------------------
 *   1.0 2022-11-07 Andrzej Wandtke         AP0140749 CC Dashboard - Initial version 
 * ----------------------------------------------------------------------------
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_ldi_order_mth (client_id
OPTIONS(description='The surrogate key for a WAWI client.'), client_id_online
OPTIONS(description='The surrogate key for a WAWI client.'), cy OPTIONS(description='Calendar year'), cy_month
OPTIONS(description='Calendar month'), order_cnt_mth
OPTIONS(description='The number of orders which have been placed with Lidl Digital on that day. (The total number of orders is reduced by the number of cancellations.) '),
order_line_cnt_mth
OPTIONS(description='The number of order lines which have been placed with Lidl Digital on that day. (This is the total number of ordered items, reduced by orders that have been cancelled later ON and by returns.)'))
AS WITH CTE_C_STORE AS (SELECT country_sid AS client_id,
   client_id AS client_id_online
  FROM ldl_p_lew_core_ac.v_client
  WHERE client_online_fg = 1
   AND lob_cd = 'LDL'), CTE_CY AS (SELECT S.client_id AS client_id_online,
   CAL.cy,
   CAL.cy_month,
   SUM(S.adj_order_cnt) AS order_cnt,
   SUM(S.adj_order_line_cnt) AS order_line_cnt
  FROM ldl_p_lew_precore_ac.v_ldi_order_summary AS S
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON S.dwh_cal_dt = CAL.cal_dt
  WHERE S.dwh_cal_dt >= PARSE_DATE('%F', '2016-01-01')
  GROUP BY client_id_online,
   CAL.cy,
   CAL.cy_month) (SELECT c_store.client_id,
   c_store.client_id_online,
   cy0.cy,
   cy0.cy_month,
   cy0.order_cnt AS order_cnt_mth,
   cy0.order_line_cnt AS order_line_cnt_mth
  FROM CTE_C_STORE AS c_store
   INNER JOIN CTE_CY AS cy0 ON c_store.client_id_online = cy0.client_id_online);