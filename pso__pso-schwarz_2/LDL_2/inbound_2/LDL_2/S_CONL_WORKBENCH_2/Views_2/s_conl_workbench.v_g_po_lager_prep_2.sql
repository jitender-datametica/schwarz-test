CREATE OR REPLACE VIEW s_conl_workbench.v_g_po_lager_prep_2
AS
( SELECT

	-- metadata
lead.cost_center,
lead.cy_month,
lead.employee_subgroup,
contract_type,
/* contractsoort onbepaalde tijd*/
CASE
WHEN contract_type in (90, 92, 94, 96)
AND lead.employee_subgroup = '5C'
AND status_employment = 3 THEN 1
ELSE null END as permanent_contract_teammanager,
CASE
WHEN contract_type in (90, 92, 94, 96)
AND lead.employee_subgroup = '6B'
AND status_employment = 3 THEN 1
ELSE null END as permanent_contract_medewerker,
CASE
WHEN contract_type in (90, 92, 94, 96)
AND lead.employee_subgroup = '6H'
AND status_employment = 3 THEN 1
ELSE null END as permanent_contract_hulpkracht,
/* contractsoort bepaalde tijd*/
CASE
WHEN contract_type in (91, 93, 97)
AND lead.employee_subgroup = '5C'
AND status_employment = 3 THEN 1
ELSE null END as non_permanent_contract_teammanager,
CASE
WHEN contract_type in (91, 93, 97)
AND lead.employee_subgroup = '6B'
AND status_employment = 3 THEN 1
ELSE null END as non_permanent_contract_medewerker,
CASE
WHEN contract_type in (91, 93, 97)
AND lead.employee_subgroup = '6H'
AND status_employment = 3 THEN 1
ELSE null END as non_permanent_contract_hulpkracht,
/* aantal dienstjaren*/
CASE
WHEN date_resignation is null THEN CASE
WHEN lead.employee_subgroup = '5C'
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_joining) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_joining))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_joining))-1) END
ELSE null END
ELSE CASE
WHEN lead.employee_subgroup = '5C'
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM date_resignation)>= EXTRACT(MONTH FROM date_joining) THEN (EXTRACT (YEAR FROM date_resignation) - EXTRACT (YEAR FROM date_joining))
ELSE ((EXTRACT (YEAR FROM date_resignation) - EXTRACT (YEAR FROM date_joining))-1) END
ELSE null END END as years_service_teammanager,
CASE
WHEN date_resignation is null THEN CASE
WHEN lead.employee_subgroup = '6B'
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_joining) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_joining))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_joining))-1) END
ELSE null END
ELSE CASE
WHEN lead.employee_subgroup = '6B'
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM date_resignation)>= EXTRACT(MONTH FROM date_joining) THEN (EXTRACT (YEAR FROM date_resignation) - EXTRACT (YEAR FROM date_joining))
ELSE ((EXTRACT (YEAR FROM date_resignation) - EXTRACT (YEAR FROM date_joining))-1) END
ELSE null END END as years_service_medewerker,
CASE
WHEN date_resignation is null THEN CASE
WHEN lead.employee_subgroup = '6H'
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_joining) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_joining))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_joining))-1) END
ELSE null END
ELSE CASE
WHEN lead.employee_subgroup = '6H'
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM date_resignation)>= EXTRACT(MONTH FROM date_joining) THEN (EXTRACT (YEAR FROM date_resignation) - EXTRACT (YEAR FROM date_joining))
ELSE ((EXTRACT (YEAR FROM date_resignation) - EXTRACT (YEAR FROM date_joining))-1) END
ELSE null END END as years_service_hulpkracht,
/* gemiddelde leeftijd onbepaalde tijd*/
CASE
WHEN lead.employee_subgroup = '5C'
AND contract_type in (90, 92, 94, 96)
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END
ELSE null END as age_permanent_contract_teammanager,
CASE
WHEN lead.employee_subgroup = '6B'
AND contract_type in (90, 92, 94, 96)
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END
ELSE null END as age_permanent_contract_medewerker,
CASE
WHEN lead.employee_subgroup = '6H'
AND contract_type in (90, 92, 94, 96)
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END
ELSE null END as age_permanent_contract_hulpkracht,
/* gemiddelde leeftijd bepaalde tijd*/
CASE
WHEN lead.employee_subgroup = '5C'
AND contract_type in (91, 93, 97)
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END
ELSE null END as age_non_permanent_contract_teammanager,
CASE
WHEN lead.employee_subgroup = '6B'
AND contract_type in (91, 93, 97)
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END
ELSE null END as age_non_permanent_contract_medewerker,
CASE
WHEN lead.employee_subgroup = '6H'
AND contract_type in (91, 93, 97)
AND status_employment = 3 THEN CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END
ELSE null END as age_non_permanent_contract_hulpkracht,
/* FTE*/
CAST(CASE
WHEN lead.employee_subgroup = '5C'
AND status_employment = 3 THEN  hours_gross / cal_fte.fte_hours_month
ELSE null END as Number(38,5)) as fte_teammanager,
CAST(CASE
WHEN lead.employee_subgroup = '6B'
AND status_employment = 3 THEN  hours_gross / cal_fte.fte_hours_month
ELSE null END as Number(38,5)) as fte_medewerker,
CAST(CASE
WHEN lead.employee_subgroup = '6H'
AND status_employment = 3 THEN  hours_gross / cal_fte.fte_hours_month
ELSE null END as Number(38,5)) as fte_hulpkracht,
/* headcount*/
CASE
WHEN lead.employee_subgroup = '5C'
AND status_employment = 3 THEN 1
ELSE null END as headcount_teammanager,
CASE
WHEN lead.employee_subgroup = '6B'
AND status_employment = 3 THEN 1
ELSE null END as headcount_medewerker,
CASE
WHEN lead.employee_subgroup = '6H'
AND status_employment = 3 THEN 1
ELSE null END as headcount_hulpkracht,
/* leeftijd >= 23 jaar*/
CASE
WHEN lead.employee_subgroup = '5C'
AND status_employment = 3
AND CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END >= 23 THEN 1
ELSE null END as age_23_and_older_teammanager,
CASE
WHEN lead.employee_subgroup = '6B'
AND status_employment = 3
AND CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END >= 23 THEN 1
ELSE null END as age_23_and_older_medewerker,
CASE
WHEN lead.employee_subgroup = '6H'
AND status_employment = 3
AND CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END >= 23 THEN 1
ELSE null END as age_23_and_older_hulpkracht,
/* leeftijd < 23 jaar*/
CASE
WHEN lead.employee_subgroup = '5C'
AND status_employment = 3
AND CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END < 23 THEN 1
ELSE null END as age_under_23_teammanager,
CASE
WHEN lead.employee_subgroup = '6B'
AND status_employment = 3
AND CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END < 23 THEN 1
ELSE null END as age_under_23_medewerker,
CASE
WHEN lead.employee_subgroup = '6H'
AND status_employment = 3
AND CASE
WHEN EXTRACT(MONTH FROM CURRENT_DATE)>= EXTRACT(MONTH FROM date_birth) THEN (EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))
ELSE ((EXTRACT (YEAR FROM CURRENT_DATE) - EXTRACT (YEAR FROM date_birth))-1) END < 23 THEN 1
ELSE null END as age_under_23_hulpkracht,
/* gemiddeld CAO uurloon*/
CASE
WHEN lead.employee_subgroup = '5C' THEN CLA_hourly_wage
ELSE null END as CLA_hourly_wage_teammanager,
CASE
WHEN lead.employee_subgroup = '6B' THEN CLA_hourly_wage
ELSE null END as CLA_hourly_wage_medewerker,
CASE
WHEN lead.employee_subgroup = '6H' THEN CLA_hourly_wage
ELSE null END as CLA_hourly_wage_hulpkracht



FROM s_conl_workbench.t_i_hr_po_lead_2 as lead

LEFT JOIN s_conl_workbench.v_CLA_hourly_wage_2 as wage
ON lead.cy_month = wage.cy_month
AND lead.cost_center = wage.orig_store_nr

	-- voor FTE berekening
		INNER JOIN (SELECT
				cal.cy_month
					,(SUM(CASE
						WHEN cal.day_of_week in (1,2,3,4,5)
							THEN 1
							ELSE 0
						END)*8) as fte_hours_month
				FROM s_conl.v_cal_calendarday_2 as cal
				GROUP BY cal.cy_month) as cal_fte
		ON lead.cy_month = cal_fte.cy_month

	WHERE 1=1
	AND status_employment = 3
	AND right(lead.cost_center, 2) in (48, 68)
	AND lead.employee_subgroup in ('5C','6B','6H')

)
 ;




