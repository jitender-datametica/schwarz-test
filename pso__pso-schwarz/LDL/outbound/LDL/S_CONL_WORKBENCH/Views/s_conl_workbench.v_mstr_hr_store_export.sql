CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mstr_hr_store_export AS -- Uren --
 -- HR-cijfers --
 -- FTE --

-- lj.fte_hours_month AS FTE_Hours_LJ,
 -- vj.fte_hours_month AS FTE_Hours_VJ,
 -- Contract type --
 -- Restsaldo ---

-- CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_We_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_We_Verlof_LJ_VM,

-- CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_Bovenwe_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_BW_Verlof_LJ_VM,

-- CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_Verlof_LJ_VM,

-- CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_We_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_We_Verlof_VJ_VM,

-- CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_Bovenwe_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_BW_Verlof_VJ_VM,

-- CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_Verlof_VJ_VM

-- Store master data
 -- vj mapping
 -- AND Functiegroep LIKE ANY ()

-- AND NOT  (store_map.store_nr=699 and cal.cy_month=201904)

-- and (store_map.transfer_fg=1 OR (store_map.transfer_fg = 0 and lj.cy_month>=cal_d.cy_month)) -- uren voor opeing

-- For Testing -----------------------
 -- AND store_map.store_nr in (699,700)
 -- AND cal.cy_month >=

-- For Testing --------------------
 SELECT -- store_map.store_nr AS  filial_nr,
 STORE_MAP.store_id AS filial_id,
 2 AS ges_type_id,
 22 AS landes_id,
 CAL.cy_month AS monat_id,
 LJ.employee_subgroup AS functiegroep,
 LJ.hours_gross AS uren_bruto_lj,
 LJ.hours_gross_temporary_helper AS uren_bruto_hulpkrachten_lj,
 LJ.hours_overtime AS uren_meer_lj,
 LJ.hours_vacation AS uren_verlof_adv_lj,
 LJ.hours_holiday AS uren_betaalde_feestdag_lj,
 LJ.hours_sick AS uren_ziekte_lj,
 LJ.hours_other AS uren_overige_lj,
 LJ.hours_contract AS uren_contract_lj,
 VJ.hours_gross AS uren_bruto_vj,
 VJ.hours_gross_temporary_helper AS uren_bruto_hulpkrachten_vj,
 VJ.hours_overtime AS uren_meer_vj,
 VJ.hours_vacation AS uren_verlof_adv_vj,
 VJ.hours_holiday AS uren_betaalde_feestdag_vj,
 VJ.hours_sick AS uren_ziekte_vj,
 VJ.hours_other AS uren_overige_vj,
 VJ.hours_contract AS uren_contract_vj,
 LJ.sick_perc_hours AS hr_ziektepercentage_uren_lj,
 LJ.sick_perc_contract_hours AS hr_ziektepercentage_cu_lj,
 LJ.violation_rest_time AS hr_overschr_rustperiodes_lj,
 LJ.violation_break_time AS hr_overschr_pauzes_lj,
 LJ.violation_9_12_hour_day AS hr_plus_12_u_d_arbeid_lj,
 LJ.violation_45_60_hour_week AS hr_plus_60_u_w_arbeid_lj,
 LJ.violation_work_period AS hr_overschr_werkperiode_lj,
 LJ.sleeping_employment AS hr_slapende_dienstverbanden_lj,
 LJ.temporary_helper_12_hours AS hr_hulpkrachten_meer_12_uur_lj,
 LJ.sick_days AS hr_duur_verzuim_in_dagen_lj,
 LJ.sick_days_count AS hr_duur_verzuim_in_aantal_lj,
 LJ.long_term_sick AS hr_langdurig_zieken_lj,
 LJ.surcharge_overtime AS hr_toeslag_meeruren_lj,
 LJ.surcharge_late_night_hours AS hr_toeslag_vroeg_laat_lj,
 LJ.extra_plus_hours AS hr_meeruren_comp_potje_lj,
 LJ.extra_plus_hours_count AS hr_meeruren_cp_aantal_lj,
 LJ.extra_minus_hours AS hr_minuren_lj,
 LJ.extra_minus_hours_count AS hr_minuren_aantal_lj,
 LJ.headcount AS hr_headcount_lj,
 LJ.amount_women_diversity AS hr_aantal_vrouwen_lj,
 LJ.amount_women_diversity_5abf AS hr_aantal_vrouwen_lj_5abf,
 LJ.amount_total_diversity AS hr_aantal_totaal_lj,
 LJ.amount_total_diversity_5abf AS hr_aantal_totaal_lj_5abf,
 LJ.long_term_absence AS hr_langzeitabwesend_lj,
 LJ.age AS hr_leeftijd_lj,
 LJ.years_service AS dienstjahre_lj,
 LJ.employee_inflow AS instroom_lj,
 LJ.employee_outflow AS uitstroom_lj,
 LJ.cla_hourly_wage AS cao_uurloon_lj,
 VJ.sick_perc_hours AS hr_ziektepercentage_uren_vj,
 VJ.sick_perc_contract_hours AS hr_ziektepercentage_cu_vj,
 VJ.violation_rest_time AS hr_overschr_rustperiodes_vj,
 VJ.violation_break_time AS hr_overschr_pauzes_vj,
 VJ.violation_9_12_hour_day AS hr_plus_12_u_d_arbeid_vj,
 VJ.violation_45_60_hour_week AS hr_plus_60_u_w_arbeid_vj,
 VJ.violation_work_period AS hr_overschr_werkperiode_vj,
 VJ.sleeping_employment AS hr_slapende_dienstverbanden_vj,
 VJ.temporary_helper_12_hours AS hr_hulpkrachten_meer_12_uur_vj,
 VJ.sick_days AS hr_duur_verzuim_in_dagen_vj,
 VJ.sick_days_count AS hr_duur_verzuim_in_aantal_vj,
 VJ.long_term_sick AS hr_langdurig_zieken_vj,
 VJ.surcharge_overtime AS hr_toeslag_meeruren_vj,
 VJ.surcharge_late_night_hours AS hr_toeslag_vroeg_laat_vj,
 VJ.extra_plus_hours AS hr_meeruren_comp_potje_vj,
 VJ.extra_plus_hours_count AS hr_meeruren_cp_aantal_vj,
 VJ.extra_minus_hours AS hr_minuren_vj,
 VJ.extra_minus_hours_count AS hr_minuren_aantal_vj,
 VJ.headcount AS hr_headcount_vj,
 VJ.amount_women_diversity AS hr_aantal_vrouwen_vj,
 VJ.amount_women_diversity_5abf AS hr_aantal_vrouwen_vj_5abf,
 VJ.amount_total_diversity AS hr_aantal_totaal_vj,
 VJ.amount_total_diversity_5abf AS hr_aantal_totaal_vj_5abf,
 VJ.long_term_absence AS hr_langzeitabwesend_vj,
 VJ.age AS hr_leeftijd_vj,
 VJ.years_service AS dienstjahre_vj,
 VJ.employee_inflow AS instroom_vj,
 VJ.employee_outflow AS uitstroom_vj,
 VJ.cla_hourly_wage AS cao_uurloon_vj,
  LJ.hours_gross / LJ.fte_hours_month AS fte_lj,
  VJ.hours_gross / VJ.fte_hours_month AS fte_vj,
 LJ.contract_non_permanent_ft AS hr_bepaalde_tijd_ft_lj,
 LJ.contract_non_permanent_pt AS hr_bepaalde_tijd_pt_lj,
 LJ.contract_non_permanent_hk AS hr_bepaalde_tijd_hk_lj,
 LJ.contract_permanent_ft AS hr_onbepaalde_tijd_ft_lj,
 LJ.contract_permanent_pt AS hr_onbepaalde_tijd_pt_lj,
 LJ.contract_permanent_0_hours AS hr_onbepaalde_tijd_0_uren_lj,
 LJ.contract_permanent_hk AS hr_onbepaalde_tijd_hk_lj,
 VJ.contract_non_permanent_ft AS hr_bepaalde_tijd_ft_vj,
 VJ.contract_non_permanent_pt AS hr_bepaalde_tijd_pt_vj,
 VJ.contract_non_permanent_hk AS hr_bepaalde_tijd_hk_vj,
 VJ.contract_permanent_ft AS hr_onbepaalde_tijd_ft_vj,
 VJ.contract_permanent_pt AS hr_onbepaalde_tijd_pt_vj,
 VJ.contract_permanent_0_hours AS hr_onbepaalde_tijd_0_uren_vj,
 VJ.contract_permanent_hk AS hr_onbepaalde_tijd_hk_vj,
 LJ.holiday_balance_adv AS hr_restsaldo_adv_lj,
 LJ.holiday_balance_we AS hr_restsaldo_we_verlof_lj,
 LJ.holiday_balance_bw AS hr_restsaldo_bovenwe_verlof_lj,
  LJ.holiday_balance_we + LJ.holiday_balance_bw AS hr_restsaldo_verlof_lj,
 VJ.holiday_balance_adv AS hr_restsaldo_adv_vj,
 VJ.holiday_balance_we AS hr_restsaldo_we_verlof_vj,
 VJ.holiday_balance_bw AS hr_restsaldo_bovenwe_verlof_vj,
  VJ.holiday_balance_we + VJ.holiday_balance_bw AS hr_restsaldo_verlof_vj
FROM ldl_s_conl_workbench.v_hr_po_lead_emp_flow AS LJ
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_store AS STORE_MAP ON LJ.orig_store_nr = CAST(STORE_MAP.cost_center AS STRING)
  
 INNER JOIN ldl_s_conl.v_cal_month AS CAL ON LJ.cy_month = CAL.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_hr_po_lead_emp_flow AS VJ ON CAL.prev_cy_month = VJ.cy_month AND LJ.orig_store_nr = VJ
    .orig_store_nr AND LJ.employee_subgroup = VJ.employee_subgroup
WHERE LJ.cy_month >= 201803 -- Filter op filiaal

 AND STORE_MAP.mis_store_active_fg = 1
 AND STORE_MAP.store_nr >= 100
 AND LJ.classification_2 LIKE 'Filiaal' -- AND store_map.store_nr > 100

 AND (LJ.employee_subgroup LIKE '5A' OR LJ.employee_subgroup LIKE '5B' OR LJ.employee_subgroup LIKE '5F' OR LJ.employee_subgroup
      LIKE '6A' OR LJ.employee_subgroup LIKE '6G' OR LJ.employee_subgroup LIKE '8A');