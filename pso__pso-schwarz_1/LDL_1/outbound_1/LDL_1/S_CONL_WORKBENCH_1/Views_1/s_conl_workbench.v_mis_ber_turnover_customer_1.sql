CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mis_ber_turnover_customer_1 AS SELECT OM_KL.client_id,
 STORE.move_to_store_id AS store_id,
 CAL.cy_month,
 SUM(CASE
   WHEN STORE.move_fg = 1 AND OM_KL.dat_formdate >= STORE.dat_opening_ovis AND OM_KL.dat_formdate < COALESCE(STORE.dat_closing_ovis
         , DATE '2099-12-31') AND OM_KL.dat_formdate >= COALESCE(CAL_PREV_CALC.prev_cy_dat_calendar, DATE '2010-03-01')
     AND OM_KL.dat_formdate >= STORE.dat_calc_start_py OR STORE.move_fg = 0 AND OM_KL.dat_formdate >= STORE.dat_opening_ovis
          AND OM_KL.dat_formdate < COALESCE(STORE.dat_closing_ovis, DATE '2099-12-31') AND OM_KL.dat_formdate >=
       COALESCE(CAL_PREV_CALC.prev_cy_dat_calendar, DATE '2010-03-01') AND OM_KL.dat_formdate >= STORE.dat_calc_start_py
      
   THEN OM_KL.val_rtl_net
   ELSE 0
   END) AS ber_turnover_cy,
 SUM(CASE
   WHEN STORE.move_fg = 1 AND OM_KL.dat_formdate >= STORE.dat_opening_ovis AND OM_KL.dat_formdate < COALESCE(STORE.dat_closing_ovis
         , DATE '2099-12-31') AND OM_KL.dat_formdate >= COALESCE(CAL_PREV_CALC.prev_cy_dat_calendar, DATE '2010-03-01')
     AND OM_KL.dat_formdate >= STORE.dat_calc_start_py OR STORE.move_fg = 0 AND OM_KL.dat_formdate >= STORE.dat_opening_ovis
          AND OM_KL.dat_formdate < COALESCE(STORE.dat_closing_ovis, DATE '2099-12-31') AND OM_KL.dat_formdate >=
       COALESCE(CAL_PREV_CALC.prev_cy_dat_calendar, DATE '2010-03-01') AND OM_KL.dat_formdate >= STORE.dat_calc_start_py
      
   THEN OM_KL.cnt_customer
   ELSE 0
   END) AS ber_customer_cy,
 SUM(CASE
   WHEN STORE.move_fg = 1 AND OM_KL.dat_formdate >= STORE.dat_opening_ovis AND OM_KL.dat_formdate < COALESCE(STORE.dat_closing_ovis
        , DATE '2099-12-31') AND OM_KL.dat_formdate >= COALESCE(CAL_PREV_CALC.prev_cy_dat_calendar, DATE '2010-03-01')
    OR STORE.move_fg = 0 AND OM_KL.dat_formdate >= STORE.dat_opening_ovis AND OM_KL.dat_formdate < COALESCE(STORE.dat_closing_ovis
        , DATE '2099-12-31') AND OM_KL.dat_formdate >= COALESCE(CAL_PREV_CALC.prev_cy_dat_calendar, DATE '2010-03-01')
   THEN OM_KL.val_rtl_net
   ELSE 0
   END) AS ber_turnover_py,
 SUM(CASE
   WHEN STORE.move_fg = 1 AND OM_KL.dat_formdate >= STORE.dat_opening_ovis AND OM_KL.dat_formdate < COALESCE(STORE.dat_closing_ovis
        , DATE '2099-12-31') AND OM_KL.dat_formdate >= COALESCE(CAL_PREV_CALC.prev_cy_dat_calendar, DATE '2010-03-01')
    OR STORE.move_fg = 0 AND OM_KL.dat_formdate >= STORE.dat_opening_ovis AND OM_KL.dat_formdate < COALESCE(STORE.dat_closing_ovis
        , DATE '2099-12-31') AND OM_KL.dat_formdate >= COALESCE(CAL_PREV_CALC.prev_cy_dat_calendar, DATE '2010-03-01')
   THEN OM_KL.cnt_customer
   ELSE 0
   END) AS ber_customer_py
FROM ldl_s_conl.v_agg_store_day_turnover_ext_1 AS OM_KL
 INNER JOIN ldl_s_conl.v_org_store_pre_1 AS STORE ON OM_KL.client_id = STORE.client_id AND OM_KL.store_id = STORE.store_id
   
 LEFT JOIN ldl_s_conl.v_cal_calendarday_1 AS CAL ON OM_KL.dat_formdate = CAL.dat_calendar
 LEFT JOIN ldl_s_conl.v_cal_calendarday_1 AS CAL_PREV_CALC ON STORE.dat_calc_start_py = CAL_PREV_CALC.dat_calendar
GROUP BY OM_KL.client_id,
 store_id,
 CAL.cy_month;