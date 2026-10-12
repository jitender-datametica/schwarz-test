/* Kunden */ /* Abverkauf */ /* Umsatz_EJR */ /* Kunden */ /* Umsatz_Plan */ /* Abverkauf */ /* Umsatz_EJR */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_agg_stat_order_day_2 (client_id, dat_calendar, py_day, currency_iso_cd,
curr_tot_id, order_cnt_stationary_day, order_lin_cnt_stationary_day, turnover_net_val_stationary_day,
plan_turnover_net_val_stationary_day, order_cnt_stationary_pyd, order_lin_cnt_stationary_pyd,
turnover_net_val_stationary_pyd) AS /* Kunden */ /* Abverkauf */ /* Umsatz_EJR */ /* Umsatz_Plan */ /* Kunden */
/* Abverkauf */ /* Umsatz_EJR */ SELECT WORK1.client_id,
 WORK1.dat_calendar,
  CASE
  WHEN ROUND(CAST(FORMAT_DATE('%m', WORK1.dat_calendar) || FORMAT_DATE('%d', WORK1.dat_calendar) AS BIGNUMERIC), 0) =
   229
  THEN NULL
  ELSE WORK2.dat_calendar
  END AS py_day,
 WORK1.currency_iso_cd,
 WORK1.curr_tot_id,
 WORK1.order_cnt_stationary AS order_cnt_stationary_day,
 WORK1.order_lin_cnt_stationary AS order_lin_cnt_stationary_day,
 WORK1.turnover_net_val_stationary AS turnover_net_val_stationary_day,
 WORK1.plan_turnover_net_val_stationary AS plan_turnover_net_val_stationary_day,
  CASE
  WHEN ROUND(CAST(FORMAT_DATE('%m', WORK1.dat_calendar) || FORMAT_DATE('%d', WORK1.dat_calendar) AS BIGNUMERIC), 0) =
   229
  THEN NULL
  ELSE WORK2.order_cnt_stationary
  END AS order_cnt_stationary_pyd,
  CASE
  WHEN ROUND(CAST(FORMAT_DATE('%m', WORK1.dat_calendar) || FORMAT_DATE('%d', WORK1.dat_calendar) AS BIGNUMERIC), 0) =
   229
  THEN NULL
  ELSE WORK2.order_lin_cnt_stationary
  END AS order_lin_cnt_stationary_pyd,
  CASE
  WHEN ROUND(CAST(FORMAT_DATE('%m', WORK1.dat_calendar) || FORMAT_DATE('%d', WORK1.dat_calendar) AS BIGNUMERIC), 0) =
   229
  THEN NULL
  ELSE WORK2.turnover_net_val_stationary
  END AS turnover_net_val_stationary_pyd
FROM ldl_p_lew_mart_lead_ac.v_agg_stat_order_day_work_2 AS WORK1
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON WORK1.dat_calendar = CAL.cal_dt
 LEFT JOIN ldl_p_lew_mart_lead_ac.v_agg_stat_order_day_work_2 AS WORK2 ON WORK1.client_id = WORK2.client_id AND WORK1.currency_iso_cd
      = WORK2.currency_iso_cd AND WORK1.curr_tot_id = WORK2.curr_tot_id AND CAL.cal_dt_prev_1y = WORK2.dat_calendar;