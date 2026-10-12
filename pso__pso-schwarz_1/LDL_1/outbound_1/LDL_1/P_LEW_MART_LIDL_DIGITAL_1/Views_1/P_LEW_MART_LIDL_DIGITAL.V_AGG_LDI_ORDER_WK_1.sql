/*
 *----------------------------------------------------------------------------
 * History:
 *
 *  Vrs Date       Developer               Task
 *  --- ---------- ----------------------- --------------------------------
 *  1.0 2020-02-28 Pawel Wieczorek         Initial version
 *                                         20200228_2413_Precalc_Lidl_Online IDMO-2753
 *
 *  1.1 2020-04-03 Pawel Wieczorek         Limit data since 2016-01-01, cast date explicit
 *                                         20200228_2413_Precalc_Lidl_Online IDMO-2753
 *  1.3 2022-05-22 Pawel Wieczorek         INC4758554 Add condition - skip Kaufland shops. Added by Appollo program
 * 
 *  1.4 2022-05-30 Pawel Wieczorek         INC4758554 Fixing wrong aggregation
 * 
 *  1.5 2022-05-30 Pawel Wieczorek         INC4758554 Fixing wrong pyw aggregation for 202001
 *
 *----------------------------------------------------------------------------
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_ldi_order_wk_1 (client_id
OPTIONS(description='The surrogate key for a WAWI client.'), client_id_online
OPTIONS(description='The surrogate key for a WAWI client.'), cy OPTIONS(description='Calendar_1 year'), cy_week
OPTIONS(description='Calendar_1 week'), currency_iso_cd OPTIONS(description='Currency ISO Code'), curr_tot_id
OPTIONS(description='Currency tot identifier'), order_cnt_wk
OPTIONS(description='The number of orders which have been placed with Lidl Digital on that day. (The total number of orders is reduced by the number of cancellations.)'),
order_line_cnt_wk
OPTIONS(description='The number of order lines which have been placed with Lidl Digital on that day. (This is the total number of ordered items, reduced by orders that have been cancelled later on and by returns.)'),
turnover_net_val_wk
OPTIONS(description='The net turnover amount for the given country_1 and date for Lidl Digital expressed in local currency (as indicated by the currency code for the turnover). The turnover is reduced by cancellations and returns.'),
plan_turnover_net_val_wk
OPTIONS(description='The net turnover amount that was planned for the given country_1 and date for Lidl Digital expressed in the currency indicated by the corresponding currency code. (Cancellations and returns have already been factored into the planned amount.)'),
order_cnt_pyw
OPTIONS(description='Prevoius Week Year - The number of orders which have been placed with Lidl Digital on that day. (The total number of orders is reduced by the number of cancellations.)'),
order_line_cnt_pyw
OPTIONS(description='Prevoius Week Year - The number of order lines which have been placed with Lidl Digital on that day. (This is the total number of ordered items, reduced by orders that have been cancelled later ON and by returns.)'),
turnover_net_val_pyw
OPTIONS(description='Prevoius Week Year - The net turnover amount for the given country_1 and date for Lidl Digital expressed in local currency (as indicated by the currency code for the turnover). The turnover is reduced by cancellations and returns.'))
OPTIONS(DESCRIPTION = `PRECALCULATED LIDL DIGITAL KPIS`) AS WITH CTE_STORE AS (SELECT country_sid AS client_id,
   client_id AS client_id_online
  FROM ldl_p_lew_core_ac.v_client_1
  WHERE client_online_fg = 1
   AND lob_cd = 'LDL'), CTE_CY AS (SELECT S.client_id AS client_id_online,
   CAL.cy,
   CAL.cy_week,
   S.adj_turnover_curr_cd AS curr_cd,
   S.plan_turnover_curr_cd AS plan_curr_cd,
   SUM(S.adj_order_cnt) AS order_cnt,
   SUM(S.adj_order_line_cnt) AS order_line_cnt,
   SUM(S.adj_turnover_net_val) AS turnover_net_val,
   SUM(S.plan_turnover_net_val) AS plan_turnover_net_val
  FROM ldl_p_lew_precore_ac.v_ldi_order_summary_1 AS S
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON S.dwh_cal_dt = CAL.cal_dt
  WHERE S.dwh_cal_dt >= PARSE_DATE('%F', '2016-01-01')
  GROUP BY client_id_online,
   CAL.cy,
   CAL.cy_week,
   curr_cd,
   plan_curr_cd), CTE_WEEK AS (SELECT cy_week,
   TRUNC(CAST(cy_week / 100 AS BIGNUMERIC)) AS cy,
   cy_week_prev_1y
  FROM ldl_p_lew_core_ac.v_cal_week_1), CTE_PY AS (SELECT S0.client_id AS client_id_online,
   CAL0.cy_week,
   S0.adj_turnover_curr_cd AS curr_cd,
   S0.plan_turnover_curr_cd AS plan_curr_cd,
   SUM(S0.adj_order_cnt) AS order_cnt,
   SUM(S0.adj_order_line_cnt) AS order_line_cnt,
   SUM(S0.adj_turnover_net_val) AS turnover_net_val,
   SUM(S0.plan_turnover_net_val) AS plan_turnover_net_val
  FROM ldl_p_lew_precore_ac.v_ldi_order_summary_1 AS S0
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL0 ON S0.dwh_cal_dt = CAL0.cal_dt
  WHERE S0.dwh_cal_dt >= PARSE_DATE('%F', '2016-01-01')
  GROUP BY client_id_online,
   CAL0.cy_week,
   curr_cd,
   plan_curr_cd) (/* current year */ SELECT c_store.client_id,
   c_store.client_id_online,
   cy0.cy,
   cy0.cy_week,
   CURR_RATE.currency_iso_cd,
   CURR_RATE.curr_tot_id,
   cy0.order_cnt AS order_cnt_wk,
   cy0.order_line_cnt AS order_line_cnt_wk,
    cy0.turnover_net_val / CURR_RATE.rate_currency_exchange AS turnover_net_val_wk,
    cy0.plan_turnover_net_val * CASE
     WHEN CURR_RATE.currency_iso_cd = 'EUR'
     THEN 1.0
     ELSE PLAN_CURR_RATE.rate_currency_exchange
     END AS plan_turnover_net_val_wk,
   py.order_cnt AS order_cnt_pyw,
   py.order_line_cnt AS order_line_cnt_pyw,
    py.turnover_net_val / CURR_RATE.rate_currency_exchange AS turnover_net_val_pyw
  FROM CTE_STORE AS c_store
   INNER JOIN CTE_CY AS cy0 ON c_store.client_id_online /* for week 202001 we should chose 2020 not 2020 and 2019 */ =
    cy0.client_id_online
   LEFT JOIN CTE_WEEK AS w ON cy0.cy_week = w.cy_week AND cy0.cy /* previus year */ = w.cy
   LEFT JOIN CTE_PY AS py ON w.cy_week_prev_1y = py.cy_week AND cy0.client_id_online = py.client_id_online AND cy0.curr_cd
      = py.curr_cd
   INNER JOIN ldl_p_lew_mart_lidl_digital_ac.v_ref_currency_1 AS CURR_RATE ON c_store.client_id = CURR_RATE.client_id AND
     cy0.curr_cd = CURR_RATE.to_currency_iso_cd
   LEFT JOIN ldl_p_lew_mart_lidl_digital_ac.v_ref_currency_1 AS PLAN_CURR_RATE ON c_store.client_id = PLAN_CURR_RATE.client_id
       AND cy0.plan_curr_cd = PLAN_CURR_RATE.currency_iso_cd AND cy0.curr_cd = PLAN_CURR_RATE.to_currency_iso_cd);