CREATE OR REPLACE VIEW S_CONL_WORKBENCH.V_HR_PO_LEAD_EMP_FLOW_2
AS
(SELECT
hr_lead.cy_month
,hr_lead.orig_store_nr
,hr_lead.classification_2
,hr_lead.employee_subgroup
,hr_lead.hours_gross
,hr_lead.hours_overtime
,hr_lead.hours_vacation
,hr_lead.hours_holiday
,hr_lead.hours_sick
,hr_lead.hours_other
,hr_lead.hours_contract
,hr_lead.sick_perc_hours
,hr_lead.hours_gross_temporary_helper
,hr_lead.sick_perc_contract_hours
,hr_lead.holiday_balance_we
,hr_lead.holiday_balance_bw
,hr_lead.holiday_balance_adv
,hr_lead.violation_rest_time
,hr_lead.violation_break_time
,hr_lead.violation_9_12_hour_day
,hr_lead.violation_45_60_hour_week
,hr_lead.violation_work_period
,hr_lead.sleeping_employment
,hr_lead.temporary_helper_12_hours
,hr_lead.sick_days
,hr_lead.sick_days_count
,hr_lead.long_term_sick
,hr_lead.surcharge_overtime
,hr_lead.surcharge_late_night_hours
,hr_lead.extra_plus_hours
,hr_lead.extra_plus_hours_count
,hr_lead.extra_minus_hours
,hr_lead.extra_minus_hours_count
,hr_lead.headcount
,hr_lead.fte_hours_month
,hr_lead.age
,hr_lead.contract_non_permanent_ft
,hr_lead.contract_non_permanent_pt
,hr_lead.contract_non_permanent_hk
,hr_lead.contract_permanent_ft
,hr_lead.contract_permanent_pt
,hr_lead.contract_permanent_0_hours
,hr_lead.contract_permanent_hk
,hr_lead.years_service
,hr_lead.amount_women_diversity
,hr_lead.amount_total_diversity
,hr_lead.amount_women_diversity_5ABF
,hr_lead.amount_total_diversity_5ABF
,hr_lead.long_term_absence 
,inflow.employee_inflow
,outflow.employee_outflow
,CLA_hourly_wage
FROM s_conl_workbench.v_hr_po_lead_2 AS hr_lead
LEFT JOIN
	(SELECT
cy_month
,employee_subgroup
,orig_store_nr
,employee_inflow
FROM s_conl_workbench.v_employee_inflow_2 AS infl) AS inflow
ON hr_lead.cy_month = inflow.cy_month
AND hr_lead.employee_subgroup = inflow.employee_subgroup
AND hr_lead.orig_store_nr = inflow.orig_store_nr
LEFT JOIN
	(SELECT
cy_month
,employee_subgroup
,orig_store_nr
,employee_outflow
FROM s_conl_workbench.v_employee_outflow_2 AS outfl ) AS outflow
ON hr_lead.cy_month = outflow.cy_month
AND hr_lead.employee_subgroup = outflow.employee_subgroup
AND hr_lead.orig_store_nr = outflow.orig_store_nr
LEFT JOIN s_conl_workbench.v_CLA_hourly_wage_2 AS wage
ON hr_lead.cy_month = wage.cy_month
AND hr_lead.orig_store_nr = wage.orig_store_nr
);