CREATE OR REPLACE VIEW s_conl_workbench.v_hr_po_lead_base
AS
(SELECT
cte_s.cost_center,
cte_d.cy_month,
cte_e.employee_subgroup,
po.sex,
po.long_term_absent_hvi,
po.status_employment,
trim(po.contract_type) as contract_type -- due to change of datatype from INT to varchar
,
po.violation_45_60_hour_week,
po.violation_9_12_hour_day,
po.violation_rest_time,
po.violation_break_time,
po.violation_work_period,
po.hours_plus_9G01_9G03,
po.hours_minus_9G01_9G03,
po.surcharge_overtime,
po.surcharge_late_night_hours,
po.holiday_balance_we,
po.holiday_balance_bw,
po.holiday_balance_adv,
po.residual_leave,
po.parttime_factor,
po.sick_leave_percentage,
po.sick_days,
po.sick_days_cumulative,
po.hours_sick,
po.hours_gross,
po.hours_sick_absent_9GLC,
po.hours_work_month,
po.hours_other,
po.hours_target,
po.hours_vacation,
po.hours_overtime,
po.hours_holiday,
po.date_birth,
po.date_joining,
po.date_resignation
FROM
(SELECT DISTINCT cost_center
FROM s_conl_workbench.v_m_cost_center_all where cost_center is not null) as cte_s
CROSS JOIN
	(SELECT DISTINCT cy_month
FROM s_conl_workbench.t_i_hr_po_lead where cost_center is not null) as cte_d
CROSS JOIN
	(SELECT DISTINCT employee_subgroup
FROM s_conl_workbench.t_i_hr_po_lead where cost_center is not null)as cte_e
LEFT JOIN s_conl_workbench.t_i_hr_po_lead as po
ON cte_s.cost_center = CASE
WHEN po.cost_center like any ('%ECD01%','%ECG02%','%EC001%','%EC002%','%EC003%') THEN 'ECD01'
WHEN length(trim(po.cost_center)) = 5 THEN right(trim(po.cost_center), 3)
WHEN length(trim(po.cost_center)) = 6 THEN right(trim(po.cost_center), 6) END
AND cte_d.cy_month = po.cy_month
AND cte_e.employee_subgroup = po.employee_subgroup
);


