CREATE OR REPLACE VIEW s_conl_workbench.v_mis_net_hours_1
AS
(SELECT
wt.client_id as client_id,
store.move_to_store_id as store_id,
store.store_nr as store_nr,
cal.cy_month as cy_month,
sum(coalesce(wt.time_working_netto_std,0)) as hours_net_working,
sum(coalesce(mt.time_missing_period,0)) as hours_net_missing,
hours_net_working+hours_net_missing as hours_net
FROM s_conl.v_ptm_working_time_store_1 as wt
LEFT JOIN s_conl.v_ptm_missingtimes_wh_perf_1 as mt
ON 	wt.client_id = mt.client_id
AND wt.store_id = mt.store_id
AND wt.dat_working = mt.dat_working
INNER JOIN s_conl_workbench.v_m_cost_center_store_1 as store
ON wt.store_id = store.store_id
AND wt.client_id = 22
INNER JOIN s_conl.v_cal_calendarday_1 as cal
ON cal.dat_calendar = wt.dat_working
GROUP BY
wt.client_id,
store.move_to_store_id,
store.store_nr,
cal.cy_month
);


