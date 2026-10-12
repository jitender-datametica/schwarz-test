CREATE OR REPLACE VIEW S_CONL_WORKBENCH.V_MSTR_HR_STORE_EXPORT_2
AS
(SELECT
--store_map.store_nr AS  filial_nr,
store_map.store_id AS filial_id
,2 AS  ges_type_id
,22 AS landes_id
,cal.cy_month AS monat_id
,lj.employee_subgroup AS Functiegroep
-- Uren -- 
,lj.hours_gross AS Uren_Bruto_LJ
,lj.hours_gross_temporary_helper AS Uren_bruto_hulpkrachten_LJ
,lj.hours_overtime AS Uren_Meer_LJ
,lj.hours_vacation AS Uren_Verlof_ADV_LJ
,lj.hours_holiday AS Uren_Betaalde_feestdag_LJ
,lj.hours_sick AS Uren_Ziekte_LJ
,lj.hours_other AS Uren_Overige_LJ
,lj.hours_contract AS Uren_Contract_LJ
,vj.hours_gross AS Uren_Bruto_VJ
,vj.hours_gross_temporary_helper AS Uren_bruto_hulpkrachten_VJ
,vj.hours_overtime AS Uren_Meer_VJ
,vj.hours_vacation AS Uren_Verlof_ADV_VJ
,vj.hours_holiday AS Uren_Betaalde_feestdag_VJ
,vj.hours_sick AS Uren_Ziekte_VJ
,vj.hours_other AS Uren_Overige_VJ
,vj.hours_contract AS Uren_Contract_VJ
-- HR-cijfers --
,lj.sick_perc_hours AS HR_Ziektepercentage_Uren_LJ
,lj.sick_perc_contract_hours AS HR_Ziektepercentage_CU_LJ
,lj.violation_rest_time AS HR_Overschr_Rustperiodes_LJ
,lj.violation_break_time AS HR_Overschr_Pauzes_LJ
,lj.violation_9_12_hour_day AS HR_Plus_12_u_d_Arbeid_LJ
,lj.violation_45_60_hour_week AS HR_Plus_60_u_w_Arbeid_LJ
,lj.violation_work_period AS HR_Overschr_Werkperiode_LJ
,lj.sleeping_employment AS HR_Slapende_Dienstverbanden_LJ
,lj.temporary_helper_12_hours AS HR_Hulpkrachten_Meer_12_Uur_LJ
,lj.sick_days AS HR_Duur_Verzuim_In_Dagen_LJ
,lj.sick_days_count AS HR_Duur_Verzuim_In_Aantal_LJ
,lj.long_term_sick AS HR_Langdurig_Zieken_LJ
,lj.surcharge_overtime AS HR_Toeslag_Meeruren_LJ
,lj.surcharge_late_night_hours AS HR_Toeslag_Vroeg_Laat_LJ
,lj.extra_plus_hours AS HR_Meeruren_Comp_Potje_LJ
,lj.extra_plus_hours_count AS HR_Meeruren_CP_Aantal_LJ
,lj.extra_minus_hours AS HR_Minuren_LJ
,lj.extra_minus_hours_count AS HR_Minuren_Aantal_LJ
,lj.headcount AS HR_Headcount_LJ
,lj.amount_women_diversity AS HR_Aantal_vrouwen_LJ
,lj.amount_women_diversity_5abf AS HR_Aantal_vrouwen_LJ_5abf
,lj.amount_total_diversity AS HR_Aantal_Totaal_LJ
,lj.amount_total_diversity_5abf AS HR_Aantal_Totaal_LJ_5abf
,lj.long_term_absence AS HR_Langzeitabwesend_LJ
,lj.age AS HR_Leeftijd_LJ
,lj.years_service AS Dienstjahre_LJ
,lj.employee_inflow AS Instroom_LJ
,lj.employee_outflow AS Uitstroom_LJ
,lj.CLA_hourly_wage AS CAO_uurloon_LJ
,vj.sick_perc_hours AS HR_Ziektepercentage_Uren_VJ
,vj.sick_perc_contract_hours AS HR_Ziektepercentage_CU_VJ
,vj.violation_rest_time AS HR_Overschr_Rustperiodes_VJ
,vj.violation_break_time AS HR_Overschr_Pauzes_VJ
,vj.violation_9_12_hour_day AS HR_Plus_12_u_d_Arbeid_VJ
,vj.violation_45_60_hour_week AS HR_Plus_60_u_w_Arbeid_VJ
,vj.violation_work_period AS HR_Overschr_Werkperiode_VJ
,vj.sleeping_employment AS HR_Slapende_Dienstverbanden_VJ
,vj.temporary_helper_12_hours AS HR_Hulpkrachten_Meer_12_Uur_VJ
,vj.sick_days AS HR_Duur_Verzuim_In_Dagen_VJ
,vj.sick_days_count AS HR_Duur_Verzuim_In_Aantal_VJ
,vj.long_term_sick AS HR_Langdurig_Zieken_VJ
,vj.surcharge_overtime AS HR_Toeslag_Meeruren_VJ
,vj.surcharge_late_night_hours AS HR_Toeslag_Vroeg_Laat_VJ
,vj.extra_plus_hours AS HR_Meeruren_Comp_Potje_VJ
,vj.extra_plus_hours_count AS HR_Meeruren_CP_Aantal_VJ
,vj.extra_minus_hours AS HR_Minuren_VJ
,vj.extra_minus_hours_count AS HR_Minuren_Aantal_VJ
,vj.headcount AS HR_Headcount_VJ
,vj.amount_women_diversity AS HR_Aantal_Vrouwen_VJ
,vj.amount_women_diversity_5abf AS HR_Aantal_Vrouwen_VJ_5abf
,vj.amount_total_diversity AS HR_Aantal_Totaal_VJ
,vj.amount_total_diversity_5abf AS HR_Aantal_Totaal_VJ_5abf
,vj.long_term_absence AS HR_Langzeitabwesend_VJ
,vj.age AS HR_Leeftijd_VJ
,vj.years_service AS Dienstjahre_VJ
,vj.employee_inflow AS Instroom_VJ
,vj.employee_outflow AS Uitstroom_VJ
,vj.CLA_hourly_wage AS CAO_uurloon_VJ
-- FTE --
--lj.fte_hours_month AS FTE_Hours_LJ,
,Uren_Bruto_LJ/lj.fte_hours_month AS FTE_LJ
--vj.fte_hours_month AS FTE_Hours_VJ,
,Uren_Bruto_VJ/vj.fte_hours_month AS FTE_VJ
-- Contract type --
,lj.contract_non_permanent_ft AS HR_Bepaalde_Tijd_FT_LJ
,lj.contract_non_permanent_pt AS HR_Bepaalde_Tijd_PT_LJ
,lj.contract_non_permanent_hk AS HR_Bepaalde_Tijd_HK_LJ
,lj.contract_permanent_ft AS HR_Onbepaalde_Tijd_FT_LJ
,lj.contract_permanent_pt AS HR_Onbepaalde_Tijd_PT_LJ
,lj.contract_permanent_0_hours AS HR_Onbepaalde_Tijd_0_uren_LJ
,lj.contract_permanent_hk AS HR_Onbepaalde_Tijd_HK_LJ
,vj.contract_non_permanent_ft AS HR_Bepaalde_Tijd_FT_VJ
,vj.contract_non_permanent_pt AS HR_Bepaalde_Tijd_PT_VJ
,vj.contract_non_permanent_hk AS HR_Bepaalde_Tijd_HK_VJ
,vj.contract_permanent_ft AS HR_Onbepaalde_Tijd_FT_VJ
,vj.contract_permanent_pt AS HR_Onbepaalde_Tijd_PT_VJ
,vj.contract_permanent_0_hours AS HR_Onbepaalde_Tijd_0_uren_VJ
,vj.contract_permanent_hk AS HR_Onbepaalde_Tijd_HK_VJ
-- Restsaldo ---
,lj.holiday_balance_adv AS HR_Restsaldo_ADV_LJ
,lj.holiday_balance_we AS HR_Restsaldo_We_Verlof_LJ
--CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_We_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_We_Verlof_LJ_VM,
,lj.holiday_balance_bw AS HR_Restsaldo_Bovenwe_Verlof_LJ
--CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_Bovenwe_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_BW_Verlof_LJ_VM,
,HR_Restsaldo_We_Verlof_LJ + HR_Restsaldo_Bovenwe_Verlof_LJ AS HR_Restsaldo_Verlof_LJ
--CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_Verlof_LJ_VM,
,vj.holiday_balance_adv AS HR_Restsaldo_ADV_VJ
,vj.holiday_balance_we AS HR_Restsaldo_We_Verlof_VJ
--CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_We_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_We_Verlof_VJ_VM,
,vj.holiday_balance_bw AS HR_Restsaldo_Bovenwe_Verlof_VJ
--CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_Bovenwe_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_BW_Verlof_VJ_VM,
,HR_Restsaldo_We_Verlof_VJ + HR_Restsaldo_Bovenwe_Verlof_VJ AS HR_Restsaldo_Verlof_VJ
--CASE when cal.month_id = 1 then 0 ELSE MAX(HR_Restsaldo_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, lj.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_Verlof_VJ_VM
FROM s_conl_workbench.v_hr_po_lead_emp_flow_2 AS lj
INNER JOIN s_conl_workbench.v_m_cost_center_store_2 AS store_map -- Store master data 
ON  lj.orig_store_nr = CAST(store_map.cost_center AS VARCHAR(25))
INNER JOIN s_conl.v_cal_month_2 AS cal -- vj mapping
ON lj.cy_month = cal.cy_month
LEFT JOIN s_conl_workbench.v_hr_po_lead_emp_flow_2 AS vj
ON vj.cy_month = cal.prev_cy_month
AND lj.orig_store_nr = vj.orig_store_nr
AND lj.employee_subgroup = vj.employee_subgroup
WHERE lj.cy_month >= 201803
-- Filter op filiaal
AND store_map.mis_store_active_fg = 1
AND store_map.store_nr >= 100
AND lj.classification_2 LIKE 'Filiaal'
--AND store_map.store_nr > 100
AND lj.employee_subgroup LIKE ANY ('5A','5B','5F','6A','6G','8A')
        -- AND Functiegroep LIKE ANY ()

        --AND NOT  (store_map.store_nr=699 and cal.cy_month=201904)
        --and (store_map.transfer_fg=1 OR (store_map.transfer_fg = 0 and lj.cy_month>=cal_d.cy_month)) -- uren voor opeing 

        ------------- For Testing -----------------------
        --AND store_map.store_nr in (699,700)
        --AND cal.cy_month >= 
        ------------- For Testing --------------------
)
;