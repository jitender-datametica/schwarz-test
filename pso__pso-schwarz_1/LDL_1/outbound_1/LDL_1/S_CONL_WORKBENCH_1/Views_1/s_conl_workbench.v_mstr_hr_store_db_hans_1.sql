CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mstr_hr_store_db_hans_1 AS -- lj.employee_subgroup as Functiegroep,

-- LJ Uren --
 -- VJ Uren --
 -- HR-cijfers --
 -- sum(lj.sick_perc_hours) as HR_Ziektepercentage_Uren_LJ,

-- sum(lj.sick_perc_contract_hours) as HR_Ziektepercentage_CU_LJ,

-- sum(lj.violation_rest_time) as HR_Overschr_Rustperiodes_LJ,

-- sum(lj.violation_break_time) as HR_Overschr_Pauzes_LJ,

-- sum(lj.violation_9_12_hour_day) as HR_Plus_12_u_d_Arbeid_LJ,

-- sum(lj.violation_45_60_hour_week) as HR_Plus_60_u_w_Arbeid_LJ,

-- sum(lj.violation_work_period) as HR_Overschr_Werkperiode_LJ,

-- sum(lj.sleeping_employment) as HR_Slapende_Dienstverbanden_LJ,

-- sum(lj.temporary_helper_12_hours) as HR_Hulpkrachten_Meer_12_Uur_LJ,

-- sum(lj.sick_days) as HR_Duur_Verzuim_In_Dagen_LJ,
 -- sum(lj.sick_days_count) as HR_Duur_Verzuim_In_Aantal_LJ,

-- sum(lj.long_term_sick) as HR_Langdurig_Zieken_LJ,
 -- sum(lj.surcharge_overtime) as HR_Toeslag_Meeruren_LJ,

-- sum(lj.surcharge_late_night_hours) as HR_Toeslag_Vroeg_Laat_LJ,

-- sum(lj.extra_plus_hours) as HR_Meeruren_Comp_Potje_LJ,

-- sum(lj.extra_plus_hours_count) as HR_Meeruren_CP_Aantal_LJ,
 -- sum(lj.extra_minus_hours) as HR_Minuren_LJ,

-- sum(lj.extra_minus_hours_count) as HR_Minuren_Aantal_LJ,
 -- sum(lj.headcount) as HR_Headcount_LJ,

-- sum(lj.amount_women_diversity) as HR_Aantal_vrouwen_LJ,
 -- sum(lj.amount_total_diversity) as HR_Aantal_Totaal_LJ,

-- sum(lj.long_term_absence) as HR_Langzeitabwesend_LJ,
 -- sum(lj.age) as HR_Leeftijd_LJ,

-- sum(lj.years_service) as Dienstjahre_LJ,
 -- sum(lj.employee_inflow) as Instroom_LJ,

-- sum(lj.employee_outflow) as Uitstroom_LJ,
 -- sum(lj.CLA_hourly_wage) as CAO_uurloon_LJ,

-- sum(vj.sick_perc_hours) as HR_Ziektepercentage_Uren_VJ,

-- sum(vj.sick_perc_contract_hours) as HR_Ziektepercentage_CU_VJ,

-- sum(vj.violation_rest_time) as HR_Overschr_Rustperiodes_VJ,

-- sum(vj.violation_break_time) as HR_Overschr_Pauzes_VJ,

-- sum(vj.violation_9_12_hour_day) as HR_Plus_12_u_d_Arbeid_VJ,

-- sum(vj.violation_45_60_hour_week) as HR_Plus_60_u_w_Arbeid_VJ,

-- sum(vj.violation_work_period) as HR_Overschr_Werkperiode_VJ,

-- sum(vj.sleeping_employment) as HR_Slapende_Dienstverbanden_VJ,

-- sum(vj.temporary_helper_12_hours) as HR_Hulpkrachten_Meer_12_Uur_VJ,

-- sum(vj.sick_days) as HR_Duur_Verzuim_In_Dagen_VJ,
 -- sum(vj.sick_days_count) as HR_Duur_Verzuim_In_Aantal_VJ,

-- sum(vj.long_term_sick) as HR_Langdurig_Zieken_VJ,
 -- sum(vj.surcharge_overtime) as HR_Toeslag_Meeruren_VJ,

-- sum(vj.surcharge_late_night_hours) as HR_Toeslag_Vroeg_Laat_VJ,

-- sum(vj.extra_plus_hours) as HR_Meeruren_Comp_Potje_VJ,

-- sum(vj.extra_plus_hours_count) as HR_Meeruren_CP_Aantal_VJ,
 -- sum(vj.extra_minus_hours) as HR_Minuren_VJ,

-- sum(vj.extra_minus_hours_count) as HR_Minuren_Aantal_VJ,
 -- sum(vj.headcount) as HR_Headcount_VJ,

-- sum(vj.amount_women_diversity) as HR_Aantal_Vrouwen_VJ,
 -- sum(vj.amount_total_diversity) as HR_Aantal_Totaal_VJ,

-- sum(vj.long_term_absence) as HR_Langzeitabwesend_VJ,
 -- sum(vj.age) as HR_Leeftijd_VJ,

-- sum(vj.years_service) as Dienstjahre_VJ,
 -- sum(vj.employee_inflow) as Instroom_VJ,

-- sum(vj.employee_outflow) as Uitstroom_VJ,
 -- sum(vj.CLA_hourly_wage) as CAO_uurloon_VJ,

-- Uren_Bruto_LJ/sum(lj.fte_hours_month) as FTE_LJ,
 -- Uren_Bruto_VJ/sum(vj.fte_hours_month) as FTE_VJ,

-- sum(lj.contract_non_permanent_ft) as HR_Bepaalde_Tijd_FT_LJ,

-- sum(lj.contract_non_permanent_pt) as HR_Bepaalde_Tijd_PT_LJ,

-- sum(lj.contract_non_permanent_hk) as HR_Bepaalde_Tijd_HK_LJ,

-- sum(lj.contract_permanent_ft) as HR_Onbepaalde_Tijd_FT_LJ,

-- sum(lj.contract_permanent_pt) as HR_Onbepaalde_Tijd_PT_LJ,

-- sum(lj.contract_permanent_0_hours) as HR_Onbepaalde_Tijd_0_uren_LJ,

-- sum(lj.contract_permanent_hk) as HR_Onbepaalde_Tijd_HK_LJ,

-- sum(vj.contract_non_permanent_ft) as HR_Bepaalde_Tijd_FT_VJ,

-- sum(vj.contract_non_permanent_pt) as HR_Bepaalde_Tijd_PT_VJ,

-- sum(vj.contract_non_permanent_hk) as HR_Bepaalde_Tijd_HK_VJ,

-- sum(vj.contract_permanent_ft) as HR_Onbepaalde_Tijd_FT_VJ,

-- sum(vj.contract_permanent_pt) as HR_Onbepaalde_Tijd_PT_VJ,

-- sum(vj.contract_permanent_0_hours) as HR_Onbepaalde_Tijd_0_uren_VJ,

-- sum(vj.contract_permanent_hk) as HR_Onbepaalde_Tijd_HK_VJ
 -- Store master data
 -- vj mapping
 SELECT 'Nederland' AS
 land_1,
 CC_MAP.cost_center,
 STORE_MAP.store_nr AS filialnummer,
 STORE_MAP.store_name AS filialname,
 STORE_MAP.wh_id AS ges_nummer,
 STORE_MAP.wh_name AS ges_name,
 STORE_MAP.account_manager_name AS vertriebsleiter,
 STORE_MAP.sales_manager_name AS verkaufsleiter,
 STORE_MAP.longitude AS lengtegraad,
 STORE_MAP.latitude AS breedtegraad,
 -- store_map.transfer_fg,
 -- Verkaufsfläche
 STORE_MAP.dat_opening_ovis AS eroeffnungsdatum,
 STORE_MAP.dat_closing_ovis AS `schließungsdatum`,
 CAL.cy AS kalenderjahr,
 CAL.byr AS geschaeftsjahr,
 CAL.month_id AS monat_nr,
 CAL.cy_month AS monat_gj,
 SUM(LJ.hours_gross) AS uren_bruto_lj,
 SUM(LJ.hours_overtime) AS uren_meer_lj,
 SUM(LJ.hours_vacation) AS uren_verlof_adv_lj,
 SUM(LJ.hours_holiday) AS uren_betaalde_feestdag_lj,
 SUM(LJ.hours_sick) AS uren_ziekte_lj,
 SUM(LJ.hours_other) AS uren_overige_lj,
 SUM(LJ.hours_contract) AS uren_contract_lj,
 SUM(CASE
   WHEN LJ.employee_subgroup LIKE '%6G%' OR LJ.employee_subgroup LIKE '%6H%'
   THEN LJ.hours_gross - LJ.hours_other - LJ.hours_sick - LJ.hours_holiday - LJ.hours_vacation - LJ.hours_overtime
   ELSE 0
   END) AS uren_gewerkt_hk_lj,
 SUM(VJ.hours_gross) AS uren_bruto_vj,
 SUM(VJ.hours_overtime) AS uren_meer_vj,
 SUM(VJ.hours_vacation) AS uren_verlof_adv_vj,
 SUM(VJ.hours_holiday) AS uren_betaalde_feestdag_vj,
 SUM(VJ.hours_sick) AS uren_ziekte_vj,
 SUM(VJ.hours_other) AS uren_overige_vj,
 SUM(VJ.hours_contract) AS uren_contract_vj,
 SUM(CASE
   WHEN VJ.employee_subgroup LIKE '%6G%' OR VJ.employee_subgroup LIKE '%6H%'
   THEN VJ.hours_gross - VJ.hours_other - VJ.hours_sick - VJ.hours_holiday - VJ.hours_vacation - VJ.hours_overtime
   ELSE 0
   END) AS uren_gewerkt_hk_vj
FROM ldl_s_conl_workbench.v_hr_po_lead_emp_flow_1 AS LJ
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_all_1 AS CC_MAP ON LJ.orig_store_nr = CC_MAP.cost_center
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_store_1 AS STORE_MAP ON LJ.orig_store_nr = CAST(STORE_MAP.cost_center AS STRING)
  
 INNER JOIN ldl_s_conl.v_cal_month_1 AS CAL ON LJ.cy_month = CAL.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_hr_po_lead_emp_flow_1 AS VJ ON CAL.prev_cy_month = VJ.cy_month AND LJ.orig_store_nr = VJ
    .orig_store_nr AND LJ.employee_subgroup = VJ.employee_subgroup
WHERE LJ.cy_month >= 201803 -- AND cc_map.cost_center like '%209648%'
 -- AND lj.classification_2 like 'Filiaal'

  -- AND lj.employee_subgroup like any ('5A','5B','5F','6A','6G','8A')
 -- AND Eroeffnungsdatum is not null

GROUP BY CC_MAP.cost_center,
 filialnummer,
 filialname,
 ges_nummer,
 ges_name,
 vertriebsleiter,
 verkaufsleiter,
 lengtegraad,
 breedtegraad,
 eroeffnungsdatum,
 `schließungsdatum`,
 kalenderjahr,
 geschaeftsjahr,
 monat_nr,
 monat_gj;