CREATE OR REPLACE VIEW s_conl_workbench.v_mstr_hr_store_old_backup20191212_2
AS
(SELECT
'Nederland' as Land_2,
store_map.store_nr as Filialnummer,
store_map.store_name as Filialname,
store_map.wh_id as GES_Nummer,
store_map.wh_name as GES_Name,
store_map.account_manager_name as Vertriebsleiter,
store_map.sales_manager_name as Verkaufsleiter,
store_map.longitude as lengtegraad,
store_map.latitude  as breedtegraad,
--store_map.transfer_fg,
-- Verkaufsfläche
store_map.dat_opening_ovis as Eroeffnungsdatum,
store_map.dat_closing_ovis as "Schließungsdatum",
cal.cy as Kalenderjahr,
cal.byr as Geschaeftsjahr,
cal.month_id as Monat_Nr,
cal.cy_month as Monat_GJ,
cte_e.employee_subgroup as Functiegroep,
		-- Uren -- 
lj.hours_gross as Uren_Bruto_LJ,
lj.hours_overtime as Uren_Meer_LJ,
lj.hours_vacation as Uren_Verlof_ADV_LJ,
lj.hours_holiday as Uren_Betaalde_feestdag_LJ,
lj.hours_sick as Uren_Ziekte_LJ,
lj.hours_other as Uren_Overige_LJ,
lj.hours_contract as Uren_Contract_LJ,
vj.hours_gross as Uren_Bruto_VJ,
vj.hours_overtime as Uren_Meer_VJ,
vj.hours_vacation as Uren_Verlof_ADV_VJ,
vj.hours_holiday as Uren_Betaalde_feestdag_VJ,
vj.hours_sick as Uren_Ziekte_VJ,
vj.hours_other as Uren_Overige_VJ,
vj.hours_contract as Uren_Contract_VJ,
-- HR-cijfers --
lj.sick_perc_hours as HR_Ziektepercentage_Uren_LJ,
lj.sick_perc_contract_hours as HR_Ziektepercentage_CU_LJ,
lj.violation_rest_time as HR_Overschr_Rustperiodes_LJ,
lj.violation_break_time as HR_Overschr_Pauzes_LJ,
lj.violation_9_12_hour_day as HR_Plus_12_u_d_Arbeid_LJ,
lj.violation_45_60_hour_week as HR_Plus_60_u_w_Arbeid_LJ,
lj.violation_work_period as HR_Overschr_Werkperiode_LJ,
lj.sleeping_employment as HR_Slapende_Dienstverbanden_LJ,
lj.temporary_helper_12_hours as HR_Hulpkrachten_Meer_12_Uur_LJ,
lj.sick_days as HR_Duur_Verzuim_In_Dagen_LJ,
lj.sick_days_count as HR_Duur_Verzuim_In_Aantal_LJ,
lj.long_term_sick as HR_Langdurig_Zieken_LJ,
lj.surcharge_overtime as HR_Toeslag_Meeruren_LJ,
lj.surcharge_late_night_hours as HR_Toeslag_Vroeg_Laat_LJ,
lj.extra_plus_hours as HR_Meeruren_Comp_Potje_LJ,
lj.extra_plus_hours_count as HR_Meeruren_CP_Aantal_LJ,
lj.extra_minus_hours as HR_Minuren_LJ,
lj.extra_minus_hours_count as HR_Minuren_Aantal_LJ,
lj.headcount as HR_Headcount_LJ,
lj.amount_women_diversity as HR_Aantal_vrouwen_LJ,
lj.amount_total_diversity as HR_Aantal_Totaal_LJ,
lj.long_term_absence as HR_Langzeitabwesend_LJ,
lj.age as HR_Leeftijd_LJ,
lj.years_service as Dienstjahre_LJ,
--			lj.employee_inflow as Instroom_LJ,
--			lj.employee_outflow as Uitstroom_LJ,
--			lj.CLA_hourly_wage as CAO_uurloon_LJ,
vj.sick_perc_hours as HR_Ziektepercentage_Uren_VJ,
vj.sick_perc_contract_hours as HR_Ziektepercentage_CU_VJ,
vj.violation_rest_time as HR_Overschr_Rustperiodes_VJ,
vj.violation_break_time as HR_Overschr_Pauzes_VJ,
vj.violation_9_12_hour_day as HR_Plus_12_u_d_Arbeid_VJ,
vj.violation_45_60_hour_week as HR_Plus_60_u_w_Arbeid_VJ,
vj.violation_work_period as HR_Overschr_Werkperiode_VJ,
vj.sleeping_employment as HR_Slapende_Dienstverbanden_VJ,
vj.temporary_helper_12_hours as HR_Hulpkrachten_Meer_12_Uur_VJ,
vj.sick_days as HR_Duur_Verzuim_In_Dagen_VJ,
vj.sick_days_count as HR_Duur_Verzuim_In_Aantal_VJ,
vj.long_term_sick as HR_Langdurig_Zieken_VJ,
vj.surcharge_overtime as HR_Toeslag_Meeruren_VJ,
vj.surcharge_late_night_hours as HR_Toeslag_Vroeg_Laat_VJ,
vj.extra_plus_hours as HR_Meeruren_Comp_Potje_VJ,
vj.extra_plus_hours_count as HR_Meeruren_CP_Aantal_VJ,
vj.extra_minus_hours as HR_Minuren_VJ,
vj.extra_minus_hours_count as HR_Minuren_Aantal_VJ,
vj.headcount as HR_Headcount_VJ,
vj.amount_women_diversity as HR_Aantal_Vrouwen_VJ,
vj.amount_total_diversity as HR_Aantal_Totaal_VJ,
vj.long_term_absence as HR_Langzeitabwesend_VJ,
vj.age as HR_Leeftijd_VJ,
vj.years_service as Dienstjahre_VJ,
--			vj.employee_inflow as Instroom_VJ,
--			vj.employee_outflow as Uitstroom_VJ,
--			vj.CLA_hourly_wage as CAO_uurloon_VJ,

	-- FTE --
lj.fte_hours_month as FTE_Hours_LJ,
Uren_Bruto_LJ/FTE_Hours_LJ as FTE_LJ,
vj.fte_hours_month as FTE_Hours_VJ,
Uren_Bruto_VJ/FTE_Hours_VJ as FTE_VJ,

	-- Contract type --
lj.contract_non_permanent_ft as HR_Bepaalde_Tijd_FT_LJ,
lj.contract_non_permanent_pt as HR_Bepaalde_Tijd_PT_LJ,
lj.contract_non_permanent_hk as HR_Bepaalde_Tijd_HK_LJ,
lj.contract_permanent_ft as HR_Onbepaalde_Tijd_FT_LJ,
lj.contract_permanent_pt as HR_Onbepaalde_Tijd_PT_LJ,
lj.contract_permanent_0_hours as HR_Onbepaalde_Tijd_0_uren_LJ,
lj.contract_permanent_hk as HR_Onbepaalde_Tijd_HK_LJ,
vj.contract_non_permanent_ft as HR_Bepaalde_Tijd_FT_VJ,
vj.contract_non_permanent_pt as HR_Bepaalde_Tijd_PT_VJ,
vj.contract_non_permanent_hk as HR_Bepaalde_Tijd_HK_VJ,
vj.contract_permanent_ft as HR_Onbepaalde_Tijd_FT_VJ,
vj.contract_permanent_pt as HR_Onbepaalde_Tijd_PT_VJ,
vj.contract_permanent_0_hours as HR_Onbepaalde_Tijd_0_uren_VJ,
vj.contract_permanent_hk as HR_Onbepaalde_Tijd_HK_VJ,

	-- Restsaldo ---
lj.holiday_balance_adv as HR_Restsaldo_ADV_LJ,
lj.holiday_balance_we as HR_Restsaldo_We_Verlof_LJ,
CASE
WHEN cal.month_id = 1 THEN 0
ELSE MAX(HR_Restsaldo_We_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, cte_e.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_We_Verlof_LJ_VM,
lj.holiday_balance_bw as HR_Restsaldo_Bovenwe_Verlof_LJ,
CASE
WHEN cal.month_id = 1 THEN 0
ELSE MAX(HR_Restsaldo_Bovenwe_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, cte_e.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_BW_Verlof_LJ_VM,
HR_Restsaldo_We_Verlof_LJ + HR_Restsaldo_Bovenwe_Verlof_LJ as HR_Restsaldo_Verlof_LJ,
CASE
WHEN cal.month_id = 1 THEN 0
ELSE MAX(HR_Restsaldo_Verlof_LJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, cte_e.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_Verlof_LJ_VM,

vj.holiday_balance_adv as HR_Restsaldo_ADV_VJ,
vj.holiday_balance_we as HR_Restsaldo_We_Verlof_VJ,
CASE
WHEN cal.month_id = 1 THEN 0
ELSE MAX(HR_Restsaldo_We_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, cte_e.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_We_Verlof_VJ_VM,
vj.holiday_balance_bw as HR_Restsaldo_Bovenwe_Verlof_VJ,
CASE
WHEN cal.month_id = 1 THEN 0
ELSE MAX(HR_Restsaldo_Bovenwe_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, cte_e.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_BW_Verlof_VJ_VM,
HR_Restsaldo_We_Verlof_VJ + HR_Restsaldo_Bovenwe_Verlof_VJ as HR_Restsaldo_Verlof_VJ,
CASE
WHEN cal.month_id = 1 THEN 0
ELSE MAX(HR_Restsaldo_Verlof_VJ)OVER(PARTITION BY 1 ORDER BY store_map.store_nr, cte_e.employee_subgroup, cal.cy_month ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) END AS HR_Restsaldo_Verlof_VJ_VM
FROM
(SELECT DISTINCT orig_store_nr,
cy_month
FROM s_conl_workbench.v_hr_po_lead_2 where orig_store_nr is not null) as cte_s
		CROSS JOIN
			(SELECT DISTINCT employee_subgroup
FROM s_conl_workbench.v_hr_po_lead_2 where orig_store_nr is not null)as cte_e
INNER JOIN s_conl_workbench.v_m_cost_center_store_2 as store_map -- Store master data 
ON cte_s.orig_store_nr = store_map.cost_center
INNER JOIN s_conl.v_cal_month_2 as cal -- vj mapping
ON cte_s.cy_month = cal.cy_month
-- LEFT  JOIN s_conl.v_cal_calendarday_2 as cal_d
	--ON store_map.dat_opening_ovis = cal_d.dat_calendar
LEFT JOIN s_conl_workbench.v_hr_po_lead_2 lj
ON cte_s.orig_store_nr = lj.orig_store_nr
AND cte_s.cy_month = lj.cy_month
AND cte_e.employee_subgroup = lj.employee_subgroup
LEFT JOIN s_conl_workbench.v_hr_po_lead_2 as vj
ON vj.cy_month = cal.prev_cy_month
AND cte_s.orig_store_nr = vj.orig_store_nr
AND cte_e.employee_subgroup = vj.employee_subgroup

WHERE cte_s.cy_month >= 201803
			--AND NOT  (store_map.store_nr=699 and cal.cy_month=201904)
			--and (store_map.transfer_fg=1 OR (store_map.transfer_fg = 0 and lj.cy_month>=cal_d.cy_month)) -- uren voor opeing 

			------------- For Testing -----------------------
			--AND store_map.store_nr in (699,700)
			--AND cal.cy_month >= 
			------------- For Testing -----------------------

)
;


