CREATE OR REPLACE VIEW s_conl_workbench.v_mis_turnover_customer_1
-- Auto. omzet groei & Auto. klanten groei
AS
(SELECT
om_kl.client_id as client_id,
store.move_to_store_id as store_id,
store.store_nr as store_nr,
cal.cy_month as cy_month,
sum(coalesce(om_kl.val_rtl_net,0)) as turnover,
sum(coalesce(om_kl.cnt_customer,0)) as customer
FROM s_conl.v_agg_store_day_turnover_ext_1 as om_kl
INNER JOIN s_conl_workbench.v_m_cost_center_store_1 as store
ON om_kl.store_id = store.store_id
AND om_kl.client_id = 22
INNER JOIN s_conl.v_cal_calendarday_1 as cal
ON cal.dat_calendar = om_kl.dat_formdate
GROUP BY
om_kl.client_id,
store.move_to_store_id,
store.store_nr,
cal.cy_month

);


