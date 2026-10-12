CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_checker_scenario_cum (client_id, st_loc_sid, checker_id, dat_formdate,
cy_week, cy_month, cnt_all_suspend, cnt_all_void, cnt_all_show_price, cnt_all_return, cnt_all_deposit, cnt_all_resumed,
cnt_all_cancelled) AS SELECT T2T.p_client_id AS client_id,
 T2T.p_store_id AS st_loc_sid,
 T2T.p_checker_id AS checker_id,
 T2T.p_dat_formdate AS dat_formdate,
 CDT.cy_week,
 CDT.cy_month,
 SUM(CASE
   WHEN T2T.scenario_group_id = 1001
   THEN 1
   ELSE 0
   END) AS cnt_all_suspend,
 SUM(CASE
   WHEN T2T.scenario_group_id = 1002
   THEN 1
   ELSE 0
   END) AS cnt_all_void,
 SUM(CASE
   WHEN T2T.scenario_group_id = 1003
   THEN 1
   ELSE 0
   END) AS cnt_all_show_pric,
 SUM(CASE
   WHEN T2T.scenario_group_id = 1004
   THEN 1
   ELSE 0
   END) AS cnt_all_return,
 SUM(CASE
   WHEN T2T.scenario_group_id = 1005
   THEN 1
   ELSE 0
   END) AS cnt_all_deposit,
 SUM(CASE
   WHEN T2T.scenario_group_id = 1006
   THEN 1
   ELSE 0
   END) AS cnt_all_resumed,
 SUM(CASE
   WHEN T2T.scenario_group_id = 1007
   THEN 1
   ELSE 0
   END) AS cnt_all_cancelled
FROM ldl_p_lew_mart_msi.v_ejr_rel_trans_to_trans AS T2T
 INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS CDT ON T2T.p_dat_formdate = CDT.dat_calendar
WHERE T2T.scenario_group_id IN (1001, 1002, 1003, 1004, 1005, 1006, 1007)
 AND T2T.resumed_trans_seqnr = 1
GROUP BY client_id,
 st_loc_sid,
 checker_id,
 dat_formdate,
 CDT.cy_week,
 CDT.cy_month;