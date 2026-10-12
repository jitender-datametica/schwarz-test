CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_AGG_STAT_ORDER_DAY_1
(
 client_id
,dat_calendar
,py_day
,currency_iso_cd
,curr_tot_id

,order_cnt_stationary_day             /* Kunden      */
,order_lin_cnt_stationary_day         /* Abverkauf   */
,turnover_net_val_stationary_day      /*  Umsatz_EJR */
,plan_turnover_net_val_stationary_day /* Umsatz_Plan */

,order_cnt_stationary_pyd         /* Kunden          */
,order_lin_cnt_stationary_pyd     /* Abverkauf       */
,turnover_net_val_stationary_pyd  /* Umsatz_EJR      */
)
AS
   SELECT
   work1.client_id,
   work1.dat_calendar,
     
   case when (to_number(to_char(work1.dat_calendar,'MM_1' )|| to_char(work1.dat_calendar, 'DD'))) = 229 THEN NULL ELSE work2.dat_calendar END AS py_day,
  
   work1.currency_iso_cd,
   work1.curr_tot_id,
   work1.order_cnt_stationary   AS order_cnt_stationary_day                           /* Kunden     */,
   work1.order_lin_cnt_stationary    AS order_lin_cnt_stationary_day                 /* Abverkauf   */,
   work1.turnover_net_val_stationary    AS turnover_net_val_stationary_day           /* Umsatz_EJR  */,
   work1.plan_turnover_net_val_stationary AS plan_turnover_net_val_stationary_day    /* Umsatz_Plan */,
   CASE WHEN (to_number(to_char(work1.dat_calendar,'MM_1' )|| to_char(work1.dat_calendar, 'DD')))  = 229 THEN NULL ELSE work2.order_cnt_stationary END AS order_cnt_stationary_pyd                /* Kunden     */,
   CASE WHEN (to_number(to_char(work1.dat_calendar,'MM_1' )|| to_char(work1.dat_calendar, 'DD')))  = 229 THEN NULL ELSE work2.order_lin_cnt_stationary END AS order_lin_cnt_stationary_pyd        /* Abverkauf  */,
   CASE WHEN (to_number(to_char(work1.dat_calendar,'MM_1' )|| to_char(work1.dat_calendar, 'DD'))) = 229 THEN NULL ELSE work2.turnover_net_val_stationary END AS turnover_net_val_stationary_pyd  /* Umsatz_EJR */
   
   
   FROM p_lew_mart_lead_ac.v_agg_stat_order_day_work_1 work1
   INNER JOIN p_lew_core_ac.v_cal_calendarday_1 cal
   ON cal.cal_dt = work1.dat_calendar
   LEFT OUTER JOIN p_lew_mart_lead_ac.v_agg_stat_order_day_work_1 work2
   ON work1.client_id = work2.client_id
   AND work1.currency_iso_cd  = work2.currency_iso_cd
   AND work1.curr_tot_id = work2.curr_tot_id
   AND cal.cal_dt_prev_1y = work2.dat_calendar;