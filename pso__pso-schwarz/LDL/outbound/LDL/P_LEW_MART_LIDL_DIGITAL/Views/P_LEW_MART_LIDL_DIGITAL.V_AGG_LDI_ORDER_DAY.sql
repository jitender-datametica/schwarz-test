/*
 *
 *  Vrs Date       Developer               Task
 *  --- ---------- ----------------------- --------------------------------
 *  1.0 2020-02-28 Pawel Wieczorek         Initial version
 *                                         20200228_2413_Precalc_Lidl_Online IDMO-2753
 *
 *  1.1 2020-03-23 Pawel Wieczorek         Change dates range
 *                                         20200228_2413_Precalc_Lidl_Online IDMO-2753
 *
 *  1.2 2020-04-03 Pawel Wieczorek         Limit data since 2016-01-01, cast date explicit
 *                                         20200228_2413_Precalc_Lidl_Online IDMO-2753
 *
 * 
 *  1.3 2022-05-22 Pawel Wieczorek         INC4758554 Add condition - skip Kaufland shops. Added by Appollo program
 * 
 * 
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_ldi_order_day (client_id
OPTIONS(description='The surrogate key for a WAWI client.'), client_id_online
OPTIONS(description='The surrogate key for a WAWI client.'), cy OPTIONS(description='Calendar year'), dat_calendar
OPTIONS(description='Calendar date'), currency_iso_cd OPTIONS(description='Currency ISO Code'), curr_tot_id
OPTIONS(description='Currency tot identifier'), order_cnt_day
OPTIONS(description='The number of orders which have been placed with Lidl Digital on that day. (The total number of orders is reduced by the number of cancellations.)'),
order_line_cnt_day
OPTIONS(description='The number of order lines which have been placed with Lidl Digital on that day. (This is the total number of ordered items, reduced by orders that have been cancelled later ON and by returns.)'),
turnover_net_val_day
OPTIONS(description='The net turnover amount for the given country and date for Lidl Digital expressed in local currency (as indicated by the currency code for the turnover). The turnover is reduced by cancellations and returns.'),
plan_turnover_net_val_day
OPTIONS(description='The net turnover amount that was planned for the given country and date for Lidl Digital expressed in the currency indicated by the corresponding currency code. (Cancellations and returns have already been factored into the planned amount.)'),
order_cnt_pyd
OPTIONS(description='Prevoius Day Year - The number of orders which have been placed with Lidl Digital on that day. (The total number of orders is reduced by the number of cancellations.)'),
order_line_cnt_pyd
OPTIONS(description='Prevoius Day Year - The number of order lines which have been placed with Lidl Digital on that day. (This is the total number of ordered items, reduced by orders that have been cancelled later ON and by returns.)'),
turnover_net_val_pyd
OPTIONS(description='Prevoius Day Year - The net turnover amount for the given country and date for Lidl Digital expressed in local currency (as indicated by the currency code for the turnover). The turnover is reduced by cancellations and returns.'))
OPTIONS(DESCRIPTION = `PRECALCULATED LIDL DIGITAL KPIS - MIS LEAD > FREIGEGEBENE BERICHTE > LIDL ONLINE > LIDL ONLINE_STATIONAR`)
AS WITH CTE_C_STORE AS (SELECT country_sid AS client_id,
   client_id AS client_id_online
  FROM ldl_p_lew_core_ac.v_client
  WHERE client_online_fg = 1
   AND lob_cd = 'LDL'), CTE_CY AS (SELECT S.client_id AS client_id_online,
   cal.cy,
   S.dwh_cal_dt AS dat_calendar,
    CASE
    WHEN MOD(CAST(cal.cy_month AS BIGNUMERIC), 100) = 2 AND cal.day_of_month = 29
    THEN NULL
    ELSE DATE_ADD(S.dwh_cal_dt, INTERVAL - 1 YEAR)
    END AS py_day,
   S.adj_turnover_curr_cd AS curr_cd,
   S.plan_turnover_curr_cd AS plan_curr_cd,
   SUM(S.adj_order_cnt) AS order_cnt,
   SUM(S.adj_order_line_cnt) AS order_line_cnt,
   SUM(S.adj_turnover_net_val) AS turnover_net_val,
   SUM(S.plan_turnover_net_val) AS plan_turnover_net_val
  FROM ldl_p_lew_precore_ac.v_ldi_order_summary AS S
   INNER JOIN (SELECT cal_dt,
     cy,
     cy_month,
     day_of_month
    FROM ldl_p_lew_core_ac.v_cal_calendarday) AS cal ON S.dwh_cal_dt = cal.cal_dt
  WHERE S.dwh_cal_dt >= PARSE_DATE('%F', '2016-01-01')
  GROUP BY client_id_online,
   cal.cy,
   dat_calendar,
   py_day,
   curr_cd,
   plan_curr_cd), CTE_PY AS (SELECT client_id AS client_id_online,
   dwh_cal_dt AS dat_calendar,
   adj_turnover_curr_cd AS curr_cd,
   SUM(adj_order_cnt) AS order_cnt,
   SUM(adj_order_line_cnt) AS order_line_cnt,
   SUM(adj_turnover_net_val) AS turnover_net_val
  FROM ldl_p_lew_precore_ac.v_ldi_order_summary AS S
  WHERE dwh_cal_dt >= PARSE_DATE('%F', '2015-01-01')
  GROUP BY client_id_online,
   dat_calendar,
   curr_cd) (/* current year */ SELECT c_store.client_id,
   c_store.client_id_online,
   cy0.cy,
   cy0.dat_calendar,
   CURR_RATE.currency_iso_cd,
   CURR_RATE.curr_tot_id,
   cy0.order_cnt AS order_cnt_day,
   cy0.order_line_cnt AS order_line_cnt_day,
    cy0.turnover_net_val / CURR_RATE.rate_currency_exchange AS turnover_net_val_day,
    cy0.plan_turnover_net_val * CASE
     WHEN CURR_RATE.currency_iso_cd = 'EUR'
     THEN 1.0
     ELSE PLAN_CURR_RATE.rate_currency_exchange
     END AS plan_turnover_net_val_day,
   py.order_cnt AS order_cnt_pyd,
   py.order_line_cnt AS order_line_cnt_pyd,
    py.turnover_net_val / CURR_RATE.rate_currency_exchange AS turnover_net_val_pyd
  FROM CTE_C_STORE AS c_store
   INNER JOIN CTE_CY AS cy0 ON c_store.client_id_online /* previus year */ = cy0.client_id_online
   LEFT JOIN CTE_PY AS py ON cy0.py_day = py.dat_calendar AND cy0.client_id_online = py.client_id_online AND cy0.curr_cd
      = py.curr_cd
   INNER JOIN ldl_p_lew_mart_lidl_digital_ac.v_ref_currency AS CURR_RATE ON c_store.client_id = CURR_RATE.client_id AND
     cy0.curr_cd = CURR_RATE.to_currency_iso_cd
   LEFT JOIN ldl_p_lew_mart_lidl_digital_ac.v_ref_currency AS PLAN_CURR_RATE ON c_store.client_id = PLAN_CURR_RATE.client_id
       AND cy0.plan_curr_cd = PLAN_CURR_RATE.currency_iso_cd AND cy0.curr_cd = PLAN_CURR_RATE.to_currency_iso_cd);