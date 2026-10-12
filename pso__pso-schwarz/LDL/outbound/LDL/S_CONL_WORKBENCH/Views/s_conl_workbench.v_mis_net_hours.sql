CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mis_net_hours AS SELECT WT.client_id,
 STORE.move_to_store_id AS store_id,
 STORE.store_nr,
 CAL.cy_month,
 SUM(COALESCE(WT.time_working_netto_std, 0)) AS hours_net_working,
 SUM(COALESCE(MT.time_missing_period, 0)) AS hours_net_missing,
  SUM(COALESCE(WT.time_working_netto_std, 0)) + SUM(COALESCE(MT.time_missing_period, 0)) AS hours_net
FROM ldl_s_conl.v_ptm_working_time_store AS WT
 LEFT JOIN ldl_s_conl.v_ptm_missingtimes_wh_perf AS MT ON WT.client_id = MT.client_id AND WT.store_id = MT.store_id AND
   WT.dat_working = MT.dat_working
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_store AS STORE ON WT.store_id = STORE.store_id AND WT.client_id = 22
 INNER JOIN ldl_s_conl.v_cal_calendarday AS CAL ON WT.dat_working = CAL.dat_calendar
GROUP BY WT.client_id,
 store_id,
 STORE.store_nr,
 CAL.cy_month;