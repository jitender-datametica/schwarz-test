CREATE OR REPLACE VIEW s_conl_workbench.v_mis_ber_turnover_customer_2
AS
(SELECT
om_kl.client_id as client_id,
store.move_to_store_id as store_id,
cal.cy_month as cy_month,
SUM(CASE
WHEN (store.move_fg=1 AND ((om_kl.dat_formdate>=store.dat_opening_ovis)AND(om_kl.dat_formdate<COALESCE(store.dat_closing_ovis,DATE '2099-12-31')))AND(om_kl.dat_formdate>=COALESCE(cal_prev_calc.prev_cy_dat_calendar,DATE '2010-03-01'))AND(om_kl.dat_formdate>=store.dat_calc_start_py)) THEN om_kl.val_rtl_net
WHEN (store.move_fg=0 AND ((om_kl.dat_formdate>=store.dat_opening_ovis)AND(om_kl.dat_formdate<COALESCE(store.dat_closing_ovis,DATE '2099-12-31')))AND(om_kl.dat_formdate>=COALESCE(cal_prev_calc.prev_cy_dat_calendar,DATE '2010-03-01'))AND(om_kl.dat_formdate>=store.dat_calc_start_py)) THEN om_kl.val_rtl_net
ELSE 0 END) as ber_turnover_cy,

SUM(CASE
WHEN (store.move_fg=1 AND ((om_kl.dat_formdate>=store.dat_opening_ovis)AND(om_kl.dat_formdate<COALESCE(store.dat_closing_ovis,DATE '2099-12-31')))AND(om_kl.dat_formdate>=COALESCE(cal_prev_calc.prev_cy_dat_calendar,DATE '2010-03-01'))AND(om_kl.dat_formdate>=store.dat_calc_start_py)) THEN om_kl.cnt_customer
WHEN (store.move_fg=0 AND ((om_kl.dat_formdate>=store.dat_opening_ovis)AND(om_kl.dat_formdate<COALESCE(store.dat_closing_ovis,DATE '2099-12-31')))AND(om_kl.dat_formdate>=COALESCE(cal_prev_calc.prev_cy_dat_calendar,DATE '2010-03-01'))AND(om_kl.dat_formdate>=store.dat_calc_start_py)) THEN om_kl.cnt_customer
ELSE 0 END) as ber_customer_cy,

SUM(CASE
WHEN (store.move_fg=1 AND ((om_kl.dat_formdate>=store.dat_opening_ovis)AND(om_kl.dat_formdate<COALESCE(store.dat_closing_ovis,DATE '2099-12-31')))AND(om_kl.dat_formdate>=COALESCE(cal_prev_calc.prev_cy_dat_calendar,DATE '2010-03-01'))) THEN om_kl.val_rtl_net
WHEN (store.move_fg=0 AND ((om_kl.dat_formdate>=store.dat_opening_ovis)AND(om_kl.dat_formdate<COALESCE(store.dat_closing_ovis,DATE '2099-12-31')))AND(om_kl.dat_formdate>=COALESCE(cal_prev_calc.prev_cy_dat_calendar,DATE '2010-03-01'))) THEN om_kl.val_rtl_net
ELSE 0 END) as ber_turnover_py,

SUM(CASE
WHEN (store.move_fg=1 AND ((om_kl.dat_formdate>=store.dat_opening_ovis)AND(om_kl.dat_formdate<COALESCE(store.dat_closing_ovis,DATE '2099-12-31')))AND(om_kl.dat_formdate>=COALESCE(cal_prev_calc.prev_cy_dat_calendar,DATE '2010-03-01'))) THEN om_kl.cnt_customer
WHEN (store.move_fg=0 AND ((om_kl.dat_formdate>=store.dat_opening_ovis)AND(om_kl.dat_formdate<COALESCE(store.dat_closing_ovis,DATE '2099-12-31')))AND(om_kl.dat_formdate>=COALESCE(cal_prev_calc.prev_cy_dat_calendar,DATE '2010-03-01'))) THEN om_kl.cnt_customer
ELSE 0 END) as ber_customer_py
FROM s_conl.v_agg_store_day_turnover_ext_2 as om_kl
INNER JOIN s_conl.v_org_store_pre_2 as store
ON om_kl.client_id = store.client_id
AND om_kl.store_id = store.store_id
LEFT JOIN s_conl.v_cal_calendarday_2 as cal
ON om_kl.dat_formdate = cal.dat_calendar
LEFT JOIN s_conl.v_cal_calendarday_2 as cal_prev_calc
ON store.dat_calc_start_py = cal_prev_calc.dat_calendar
GROUP BY
om_kl.client_id,
store.move_to_store_id,
cal.cy_month
);


