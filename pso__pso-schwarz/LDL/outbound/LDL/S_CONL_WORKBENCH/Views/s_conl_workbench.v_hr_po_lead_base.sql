CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_hr_po_lead_base AS -- due to change of datatype from INTEGER to STRING

SELECT cte_s.cost_center,
 cte_d.cy_month,
 cte_e.employee_subgroup,
 PO.sex,
 PO.long_term_absent_hvi,
 PO.status_employment,
 TRIM(PO.contract_type) AS contract_type,
 PO.violation_45_60_hour_week,
 PO.violation_9_12_hour_day,
 PO.violation_rest_time,
 PO.violation_break_time,
 PO.violation_work_period,
 PO.hours_plus_9g01_9g03,
 PO.hours_minus_9g01_9g03,
 PO.surcharge_overtime,
 PO.surcharge_late_night_hours,
 PO.holiday_balance_we,
 PO.holiday_balance_bw,
 PO.holiday_balance_adv,
 PO.residual_leave,
 PO.parttime_factor,
 PO.sick_leave_percentage,
 PO.sick_days,
 PO.sick_days_cumulative,
 PO.hours_sick,
 PO.hours_gross,
 PO.hours_sick_absent_9glc,
 PO.hours_work_month,
 PO.hours_other,
 PO.hours_target,
 PO.hours_vacation,
 PO.hours_overtime,
 PO.hours_holiday,
 PO.date_birth,
 PO.date_joining,
 PO.date_resignation
FROM (SELECT DISTINCT cost_center
  FROM ldl_s_conl_workbench.v_m_cost_center_all
  WHERE cost_center IS NOT NULL) AS cte_s
 INNER JOIN (SELECT DISTINCT cy_month
  FROM ldl_s_conl_workbench.t_i_hr_po_lead
  WHERE cost_center IS NOT NULL) AS cte_d ON TRUE
 INNER JOIN (SELECT DISTINCT employee_subgroup
  FROM ldl_s_conl_workbench.t_i_hr_po_lead
  WHERE cost_center IS NOT NULL) AS cte_e ON TRUE
 LEFT JOIN ldl_s_conl_workbench.t_i_hr_po_lead AS PO ON cte_s.cost_center = CASE
     WHEN PO.cost_center LIKE '%ECD01%' OR PO.cost_center LIKE '%ECG02%' OR PO.cost_center LIKE '%EC001%' OR PO.cost_center
        LIKE '%EC002%' OR PO.cost_center LIKE '%EC003%'
     THEN 'ECD01'
     WHEN LENGTH(TRIM(PO.cost_center)) = 5
     THEN RIGHT(TRIM(PO.cost_center), 3)
     WHEN LENGTH(TRIM(PO.cost_center)) = 6
     THEN RIGHT(TRIM(PO.cost_center), 6)
     ELSE NULL
     END AND cte_d.cy_month = PO.cy_month AND cte_e.employee_subgroup = PO.employee_subgroup;