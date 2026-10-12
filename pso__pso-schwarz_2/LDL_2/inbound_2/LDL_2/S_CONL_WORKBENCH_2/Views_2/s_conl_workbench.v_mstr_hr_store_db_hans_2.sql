CREATE OR REPLACE VIEW s_conl_workbench.v_mstr_hr_store_db_hans_2
AS
(SELECT
'Nederland' as Land_2,
cc_map.cost_center as cost_center,
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
--lj.employee_subgroup as Functiegroep,
		-- LJ Uren -- 
sum(lj.hours_gross) as Uren_Bruto_LJ,
sum(lj.hours_overtime) as Uren_Meer_LJ,
sum(lj.hours_vacation) as Uren_Verlof_ADV_LJ,
sum(lj.hours_holiday) as Uren_Betaalde_feestdag_LJ,
sum(lj.hours_sick) as Uren_Ziekte_LJ,
sum(lj.hours_other) as Uren_Overige_LJ,
sum(lj.hours_contract) as Uren_Contract_LJ,
sum(CASE
WHEN lj.employee_subgroup LIKE any ('%6G%','%6H%') THEN lj.hours_gross-lj.hours_other-lj.hours_sick-lj.hours_holiday-lj.hours_vacation-lj.hours_overtime
else 0 END) as Uren_gewerkt_HK_LJ,

		-- VJ Uren -- 
sum(vj.hours_gross) as Uren_Bruto_VJ,
sum(vj.hours_overtime) as Uren_Meer_VJ,
sum(vj.hours_vacation) as Uren_Verlof_ADV_VJ,
sum(vj.hours_holiday) as Uren_Betaalde_feestdag_VJ,
sum(vj.hours_sick) as Uren_Ziekte_VJ,
sum(vj.hours_other) as Uren_Overige_VJ,
sum(vj.hours_contract) as Uren_Contract_VJ,
sum(CASE
WHEN vj.employee_subgroup LIKE any ('%6G%','%6H%') THEN vj.hours_gross-vj.hours_other-vj.hours_sick-vj.hours_holiday-vj.hours_vacation-vj.hours_overtime
else 0 END) as Uren_gewerkt_HK_VJ

-- HR-cijfers --
--sum(lj.sick_perc_hours) as HR_Ziektepercentage_Uren_LJ,
--sum(lj.sick_perc_contract_hours) as HR_Ziektepercentage_CU_LJ,
--sum(lj.violation_rest_time) as HR_Overschr_Rustperiodes_LJ,
--sum(lj.violation_break_time) as HR_Overschr_Pauzes_LJ,
--sum(lj.violation_9_12_hour_day) as HR_Plus_12_u_d_Arbeid_LJ,
--sum(lj.violation_45_60_hour_week) as HR_Plus_60_u_w_Arbeid_LJ,
--sum(lj.violation_work_period) as HR_Overschr_Werkperiode_LJ,
--sum(lj.sleeping_employment) as HR_Slapende_Dienstverbanden_LJ,
--sum(lj.temporary_helper_12_hours) as HR_Hulpkrachten_Meer_12_Uur_LJ,
--sum(lj.sick_days) as HR_Duur_Verzuim_In_Dagen_LJ,
--sum(lj.sick_days_count) as HR_Duur_Verzuim_In_Aantal_LJ,
--sum(lj.long_term_sick) as HR_Langdurig_Zieken_LJ,
--sum(lj.surcharge_overtime) as HR_Toeslag_Meeruren_LJ,
--sum(lj.surcharge_late_night_hours) as HR_Toeslag_Vroeg_Laat_LJ,
--sum(lj.extra_plus_hours) as HR_Meeruren_Comp_Potje_LJ,
--sum(lj.extra_plus_hours_count) as HR_Meeruren_CP_Aantal_LJ,
--sum(lj.extra_minus_hours) as HR_Minuren_LJ,
--sum(lj.extra_minus_hours_count) as HR_Minuren_Aantal_LJ,
--sum(lj.headcount) as HR_Headcount_LJ,
--sum(lj.amount_women_diversity) as HR_Aantal_vrouwen_LJ,
--sum(lj.amount_total_diversity) as HR_Aantal_Totaal_LJ,
--sum(lj.long_term_absence) as HR_Langzeitabwesend_LJ,
--sum(lj.age) as HR_Leeftijd_LJ,
--sum(lj.years_service) as Dienstjahre_LJ,
--sum(lj.employee_inflow) as Instroom_LJ,
--sum(lj.employee_outflow) as Uitstroom_LJ,
--sum(lj.CLA_hourly_wage) as CAO_uurloon_LJ,
--sum(vj.sick_perc_hours) as HR_Ziektepercentage_Uren_VJ,
--sum(vj.sick_perc_contract_hours) as HR_Ziektepercentage_CU_VJ,
--sum(vj.violation_rest_time) as HR_Overschr_Rustperiodes_VJ,
--sum(vj.violation_break_time) as HR_Overschr_Pauzes_VJ,
--sum(vj.violation_9_12_hour_day) as HR_Plus_12_u_d_Arbeid_VJ,
--sum(vj.violation_45_60_hour_week) as HR_Plus_60_u_w_Arbeid_VJ,
--sum(vj.violation_work_period) as HR_Overschr_Werkperiode_VJ,
--sum(vj.sleeping_employment) as HR_Slapende_Dienstverbanden_VJ,
--sum(vj.temporary_helper_12_hours) as HR_Hulpkrachten_Meer_12_Uur_VJ,
--sum(vj.sick_days) as HR_Duur_Verzuim_In_Dagen_VJ,
--sum(vj.sick_days_count) as HR_Duur_Verzuim_In_Aantal_VJ,
--sum(vj.long_term_sick) as HR_Langdurig_Zieken_VJ,
--sum(vj.surcharge_overtime) as HR_Toeslag_Meeruren_VJ,
--sum(vj.surcharge_late_night_hours) as HR_Toeslag_Vroeg_Laat_VJ,
--sum(vj.extra_plus_hours) as HR_Meeruren_Comp_Potje_VJ,
--sum(vj.extra_plus_hours_count) as HR_Meeruren_CP_Aantal_VJ,
--sum(vj.extra_minus_hours) as HR_Minuren_VJ,
--sum(vj.extra_minus_hours_count) as HR_Minuren_Aantal_VJ,
--sum(vj.headcount) as HR_Headcount_VJ,
--sum(vj.amount_women_diversity) as HR_Aantal_Vrouwen_VJ,
--sum(vj.amount_total_diversity) as HR_Aantal_Totaal_VJ,
--sum(vj.long_term_absence) as HR_Langzeitabwesend_VJ,
--sum(vj.age) as HR_Leeftijd_VJ,
--sum(vj.years_service) as Dienstjahre_VJ,
--sum(vj.employee_inflow) as Instroom_VJ,
--sum(vj.employee_outflow) as Uitstroom_VJ,
--sum(vj.CLA_hourly_wage) as CAO_uurloon_VJ,
--Uren_Bruto_LJ/sum(lj.fte_hours_month) as FTE_LJ,
--Uren_Bruto_VJ/sum(vj.fte_hours_month) as FTE_VJ,
--sum(lj.contract_non_permanent_ft) as HR_Bepaalde_Tijd_FT_LJ, 	
--sum(lj.contract_non_permanent_pt) as HR_Bepaalde_Tijd_PT_LJ, 	
--sum(lj.contract_non_permanent_hk) as HR_Bepaalde_Tijd_HK_LJ, 	
--sum(lj.contract_permanent_ft) as HR_Onbepaalde_Tijd_FT_LJ,     	
--sum(lj.contract_permanent_pt) as HR_Onbepaalde_Tijd_PT_LJ, 		
--sum(lj.contract_permanent_0_hours) as HR_Onbepaalde_Tijd_0_uren_LJ, 
--sum(lj.contract_permanent_hk) as HR_Onbepaalde_Tijd_HK_LJ,
--sum(vj.contract_non_permanent_ft) as HR_Bepaalde_Tijd_FT_VJ, 	
--sum(vj.contract_non_permanent_pt) as HR_Bepaalde_Tijd_PT_VJ, 	
--sum(vj.contract_non_permanent_hk) as HR_Bepaalde_Tijd_HK_VJ, 	
--sum(vj.contract_permanent_ft) as HR_Onbepaalde_Tijd_FT_VJ,     	
--sum(vj.contract_permanent_pt) as HR_Onbepaalde_Tijd_PT_VJ, 		
--sum(vj.contract_permanent_0_hours) as HR_Onbepaalde_Tijd_0_uren_VJ, 
--sum(vj.contract_permanent_hk) as HR_Onbepaalde_Tijd_HK_VJ
FROM s_conl_workbench.v_hr_po_lead_emp_flow_2 as lj

LEFT JOIN s_conl_workbench.v_m_cost_center_all_2 as cc_map
ON lj.orig_store_nr = cc_map.cost_center

LEFT JOIN s_conl_workbench.v_m_cost_center_store_2 as store_map -- Store master data 
ON  lj.orig_store_nr = CAST(store_map.cost_center AS VARCHAR(25))

INNER JOIN s_conl.v_cal_month_2 as cal -- vj mapping
ON lj.cy_month = cal.cy_month

LEFT JOIN s_conl_workbench.v_hr_po_lead_emp_flow_2 as vj
ON vj.cy_month = cal.prev_cy_month
AND lj.orig_store_nr = vj.orig_store_nr
AND lj.employee_subgroup = vj.employee_subgroup

WHERE lj.cy_month >= 201803
	--AND cc_map.cost_center like '%209648%'
	--AND lj.classification_2 like 'Filiaal'
	--AND lj.employee_subgroup like any ('5A','5B','5F','6A','6G','8A')
	--AND Eroeffnungsdatum is not null	

GROUP BY
cc_map.cost_center,
store_map.store_nr,
store_map.store_name,
store_map.wh_id,
store_map.wh_name,
store_map.account_manager_name,
store_map.sales_manager_name,
store_map.longitude,
store_map.latitude,
store_map.dat_opening_ovis,
store_map.dat_closing_ovis,
cal.cy,
cal.byr,
cal.month_id,
cal.cy_month

);


