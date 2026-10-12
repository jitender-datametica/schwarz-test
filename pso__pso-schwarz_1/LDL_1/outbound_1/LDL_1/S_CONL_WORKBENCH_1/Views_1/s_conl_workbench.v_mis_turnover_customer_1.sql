-- Auto. omzet groei & Auto. klanten groei
 CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mis_turnover_customer_1 AS
SELECT OM_KL.client_id,
 STORE.move_to_store_id AS store_id,
 STORE.store_nr,
 CAL.cy_month,
 SUM(COALESCE(OM_KL.val_rtl_net, 0)) AS turnover,
 SUM(COALESCE(OM_KL.cnt_customer, 0)) AS customer
FROM ldl_s_conl.v_agg_store_day_turnover_ext_1 AS OM_KL
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_store_1 AS STORE ON OM_KL.store_id = STORE.store_id AND OM_KL.client_id =
   22
 INNER JOIN ldl_s_conl.v_cal_calendarday_1 AS CAL ON OM_KL.dat_formdate = CAL.dat_calendar
GROUP BY OM_KL.client_id,
 store_id,
 STORE.store_nr,
 CAL.cy_month;