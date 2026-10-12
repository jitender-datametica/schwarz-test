CREATE OR REPLACE VIEW S_CONL_WORKBENCH.V_HR_PO_LEAD
AS
(SELECT
hr_lead.cy_month AS cy_month
,cc_mapping.orig_store_nr AS orig_store_nr
,cc_mapping.classification_2 AS classification_2
,hr_lead.employee_subgroup
-- Uren --
/* functie*/
,SUM(hr_lead.hours_gross) AS hours_gross
/*SUM(CASE WHEN status_employment=3 THEN hr_lead.hours_gross END) AS hours_gross, -- bruto uren */
,SUM(hr_lead.hours_overtime) AS hours_overtime
/* Meeruren*/
,SUM(hr_lead.hours_vacation) AS hours_vacation
/* Verlof - ADV*/
,SUM(hr_lead.hours_holiday) AS hours_holiday
/* Betaalde feestdaguren*/
,SUM(hr_lead.hours_sick) AS hours_sick
/* Ziekte-uren*/
,SUM(hr_lead.hours_other) AS hours_other
/* Overige-uren*/
,(SUM(hr_lead.hours_gross)-SUM(hr_lead.hours_overtime)-SUM(hr_lead.hours_vacation)-SUM(hr_lead.hours_holiday)-SUM(hr_lead.hours_sick)-SUM(hr_lead.hours_other)) AS hours_contract
-- HR cijfers --
/* Contracturen SUM(hr_lead.hours_work_month)*/
,SUM(hr_lead.hours_sick_absent_9GLC) AS sick_perc_hours
/* Ziektepercentage*/
,SUM(CASE WHEN hr_lead.employee_subgroup LIKE ('%6G%') AND status_employment=3 THEN hr_lead.hours_gross ELSE NULL END) AS  hours_gross_temporary_helper
-- Bruto uren Hulpkrachten
,SUM(CASE
WHEN hr_lead.employee_subgroup LIKE ('%6G%') THEN hr_lead.hours_gross
ELSE hr_lead.hours_work_month END) AS  sick_perc_contract_hours
/* Ziektepercentage*/
,SUM(CASE
WHEN status_employment=3 AND hr_lead.employee_subgroup NOT LIKE ('%6G%') THEN hr_lead.holiday_balance_we END) AS holiday_balance_we
/* Restsaldo wettelijk verlof*/
,SUM(CASE
WHEN status_employment=3 AND hr_lead.employee_subgroup NOT LIKE ('%6G%') THEN hr_lead.holiday_balance_bw END) AS holiday_balance_bw
/* Restsaldo bovenwet. verlof*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.holiday_balance_adv END) AS holiday_balance_adv
/* Restsaldo ADV*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.violation_rest_time END) AS violation_rest_time
/* Overschr. rustperiodes*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.violation_break_time END) AS violation_break_time
/* Overschr. pauzes*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.violation_9_12_hour_day END) AS violation_9_12_hour_day
/* Plus 12 u/d arbeid*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.violation_45_60_hour_week END) AS violation_45_60_hour_week
/* Plus 60 u/w arbeid*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.violation_work_period END) AS violation_work_period
/* Overschr. werkperiode*/
,SUM(CASE
WHEN (hr_lead.employee_subgroup LIKE ('%6G%') AND status_employment=3 AND hr_lead.hours_gross=0) THEN 1
ELSE 0 END) AS sleeping_employment
/* Slapende dienstverbanden*/
,SUM(CASE
WHEN (hr_lead.employee_subgroup LIKE ('%6G%') AND status_employment=3 AND(hr_lead.hours_gross > 51.6)) THEN 1
ELSE 0 END) AS temporary_helper_12_hours
/* Hulpkrachten > 12 uur*/
,SUM(CASE
WHEN (status_employment=3 AND hr_lead.sick_days<>0) THEN hr_lead.sick_days END) AS sick_days
/* Duur verzuim (in dagen)*/
,COUNT(CASE
WHEN (status_employment=3 AND hr_lead.sick_days<>0) THEN hr_lead.sick_days END) AS sick_days_count
/* Duur verzuim (in dagen) aantal met verzuim*/
,SUM(CASE
WHEN status_employment=3 AND long_term_absent_hvi LIKE ANY ('%K000%','%K001%','%K002%','%K003%','%K005%','%9200%') THEN 1
ELSE 0 END) AS long_term_sick
/* Langdurig zieken*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.surcharge_overtime END) AS surcharge_overtime
/* Toeslag t.b.v. meeruren (in uren)*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.surcharge_late_night_hours END) AS surcharge_late_night_hours
/* Toeslag t.b.v. vroeg/laat (in uren)*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.hours_plus_9G01_9G03 END) AS extra_plus_hours
/* Meeruren (comp. potje)*/
,COUNT(CASE
WHEN status_employment=3 THEN hr_lead.hours_plus_9G01_9G03 END) AS extra_plus_hours_count
/* Meeruren (comp. potje) count*/
,SUM(CASE
WHEN status_employment=3 THEN hr_lead.hours_minus_9G01_9G03 END) AS extra_minus_hours
/* Minuren*/
,COUNT(CASE
WHEN status_employment=3 THEN hr_lead.hours_minus_9G01_9G03 END) AS extra_minus_hours_count
/* Minuren count*/
,SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type IS NOT NULL) THEN 1
ELSE 0 END) AS headcount
--hours_contract/AVG(cal_fte.fte_hours_month) AS fte, 	-- FTE	--SUM(CASE WHEN status_employment=3 THEN hr_lead.hours_work_month ELSE 0 END),	
/* Headcount*/
,AVG(cal_fte.fte_hours_month) AS fte_hours_month
--
--SUM(CASE WHEN status_employment=3 THEN 
--CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM hr_lead.date_birth)
--			 			THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM hr_lead.date_birth)) 
--			 			ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM hr_lead.date_birth))-1)
--					END 
--					ELSE NULL END) AS age,   Oude Berekening
--		
,SUM(CASE
WHEN status_employment=3 THEN CASE
WHEN EXTRACT(MONTH FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(hr_lead.cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(hr_lead.cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM-DD'))>= EXTRACT(MONTH FROM hr_lead.date_birth) THEN (EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(hr_lead.cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(hr_lead.cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))
ELSE ((EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(hr_lead.cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(hr_lead.cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM-DD')) - EXTRACT (YEAR FROM hr_lead.date_birth))-1) END
ELSE NULL END) AS age
-- Bep Tijd
,SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type LIKE ANY ('%91%','%02%','%N1%')) THEN 1
ELSE 0 END) AS contract_non_permanent_ft
/* Bepaalde tijd FT*/
,SUM(CASE
WHEN (status_employment=3 AND CONTAINS( hr_lead.contract_type, '93')) THEN 1
ELSE 0 END) AS contract_non_permanent_pt
/* Bepaalde tijd PT*/
,SUM(CASE
WHEN (status_employment=3 AND CONTAINS( hr_lead.contract_type, '97')) THEN 1
ELSE 0 END) AS contract_non_permanent_hk
-- Onb Tijd
/* Bepaald hulpkracht*/
,SUM(CASE
WHEN (status_employment=3 AND hr_lead.contract_type LIKE ANY ('%90%','%01%','%N2%')) THEN 1
ELSE 0 END) AS contract_permanent_ft
/* Onbepaalde tijd fT*/
,SUM(CASE
WHEN (status_employment=3 AND CONTAINS( hr_lead.contract_type, '92')) THEN 1
ELSE 0 END) AS contract_permanent_pt
/* Onbepaalde tijd PT*/
,SUM(CASE
WHEN (status_employment=3 AND CONTAINS( hr_lead.contract_type, '94')) THEN 1
ELSE 0 END) AS contract_permanent_0_hours
/* Onbepaalde 0-uren*/
,SUM(CASE
WHEN (status_employment=3 AND CONTAINS( hr_lead.contract_type, '96')) THEN 1
ELSE 0 END) AS contract_permanent_hk
-- Overige HR-Cijfers
--SUM(CASE WHEN status_employment=3 
--    THEN EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM hr_lead.date_joining) 
--    ELSE NULL END) AS years_service oud 2, -- Dienstjaren
--AVG((date-hr_lead.date_joining)YEAR) AS years_service, -- Oud 1
/* Onbepaalde hulpkracht*/
,SUM(CASE
WHEN status_employment=3 THEN CASE
WHEN EXTRACT(MONTH FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(hr_lead.cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(hr_lead.cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM-DD'))>= EXTRACT(MONTH FROM hr_lead.date_joining) THEN (EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(hr_lead.cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(hr_lead.cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))
ELSE ((EXTRACT (YEAR FROM TO_DATE(CONCAT(LEFT(TRIM(TO_CHAR(hr_lead.cy_month)),4),'-',RIGHT(TRIM(TO_CHAR(hr_lead.cy_month)),2),'-',TO_CHAR(EXTRACT(DAY FROM CURRENT_DATE))),'YYYY-MM-DD')) - EXTRACT (YEAR FROM hr_lead.date_joining))-1) END
ELSE NULL END) AS years_service
 -- Instroom
,SUM(CASE
WHEN sex=2 AND hr_lead.employee_subgroup LIKE ANY ('%5A') AND status_employment=3 THEN 1.000
ELSE 0.000 END) AS amount_women_diversity
/* Voor - dit was ('%5A','%5B%','%5F%')*/
,SUM(CASE
WHEN hr_lead.employee_subgroup LIKE ANY ('%5A') AND status_employment=3 THEN 1.000
ELSE 0.000 END) AS amount_total_diversity
/* Aantal totaal - dit was ('%5A','%5B%','%5F%')*/
,SUM(CASE WHEN sex=2 AND hr_lead.employee_subgroup LIKE ANY ('%5A','%5B%','%5F%') AND status_employment=3 THEN 1.000 ELSE 0.000 END) AS amount_women_diversity_5ABF 
-- extra toevoeging
,SUM(CASE WHEN hr_lead.employee_subgroup LIKE ANY ('%5A','%5B%','%5F%') AND status_employment=3 THEN 1.000 ELSE 0.000 END) AS amount_total_diversity_5ABF 
-- extra toevoeging
,SUM(CASE
WHEN hr_lead.cy_month >= 202008 AND (long_term_absent_hvi IS NOT NULL) THEN 1
WHEN hr_lead.cy_month < 202008 AND  (long_term_absent_hvi LIKE ANY ('%A000%','%BA00%','%K000%','%K001%','%K002%','%K003%','%K005%','%M000%','%M005%','%SAB1%','%U000%','%U004%','%9100%','%9200%','%9300%','%@I%')) THEN 1
ELSE 0 END) AS long_term_absence-- Langseitabwesend-- 
--old:SUM(CASE WHEN long_term_absent_hvi LIKE ANY ('%A000%','%BA00%','%K000%','%K001%','%K002%','%K003%','%K005%','%M000%','%M005%','%SAB1%','%U000%','%U004%','%9100%','%9200%','%9300%','%@I%') THEN 1 ELSE 0 END) AS long_term_absence-- Langseitabwesend
FROM s_conl_workbench.v_hr_po_lead_base AS hr_lead
INNER JOIN s_conl_workbench.v_m_cost_center_all AS cc_mapping -- Umzugsfilialen
ON	hr_lead.cost_center = cc_mapping.cost_center
INNER JOIN (SELECT
cal.cy_month
,(SUM(CASE
WHEN cal.day_of_week IN (1,2,3,4,5) THEN 1
ELSE 0 END)*8) AS fte_hours_month
FROM s_conl.v_cal_calendarday AS cal
GROUP BY cal.cy_month) AS cal_fte
ON hr_lead.cy_month = cal_fte.cy_month
/* Alignment to Teradata: Replaced "WHERE (CONTAINS(hr_lead.contract_type, '95') OR hr_lead.contract_type is null)" */
WHERE (hr_lead.contract_type NOT LIKE '%95%' OR hr_lead.contract_type IS NULL)  -- Contractsoort 95 is het contract 'Bepaald 0-uren' uitzendkrachten i.v.m. Corona; wordt door HR uitgesloten
GROUP BY
	hr_lead.cy_month
	,cc_mapping.orig_store_nr
	,cc_mapping.classification_2
	,hr_lead.employee_subgroup -- functie
);