CREATE OR REPLACE VIEW s_conl_workbench.v_g_po_lager_2
AS
(SELECT

	-- metadata
cost_center
,
cy_month,
/* headcount*/
SUM(headcount_teammanager) as headcount_teammanager,
SUM(headcount_medewerker) as headcount_medewerker,
SUM(headcount_hulpkracht) as headcount_hulpkracht,
/* FTE*/
SUM(fte_teammanager) as fte_teammanager,
SUM(fte_medewerker) as fte_medewerker,
SUM(fte_hulpkracht) as fte_hulpkracht,
/* gemiddeld bruto uurloon*/
MAX(CLA_hourly_wage_teammanager) as CLA_hourly_wage_teammanager,
MAX(CLA_hourly_wage_medewerker) as CLA_hourly_wage_medewerker,
MAX(CLA_hourly_wage_hulpkracht) as CLA_hourly_wage_hulpkracht,
/* contractsoort onbepaalde tijd*/
SUM(permanent_contract_teammanager) as permanent_contract_teammanager,
SUM(permanent_contract_medewerker) as permanent_contract_medewerker,
SUM(permanent_contract_hulpkracht) as permanent_contract_hulpkracht,
/* contractsoort bepaalde tijd*/
SUM(non_permanent_contract_teammanager) as non_permanent_contract_teammanager,
SUM(non_permanent_contract_medewerker) as non_permanent_contract_medewerker,
SUM(non_permanent_contract_hulpkracht) as non_permanent_contract_hulpkracht,
/* gemiddeld aantal dienstjaren*/
AVG(years_service_teammanager) as avg_years_service_teammanager,
AVG(years_service_medewerker) as avg_years_service_medewerker,
AVG(years_service_hulpkracht) as avg_years_service_hulpkracht,
/* gemiddelde leeftijd onbepaalde tijd*/
AVG(age_permanent_contract_teammanager) as avg_age_permanent_contract_teammanager,
AVG(age_permanent_contract_medewerker) as avg_age_permanent_contract_medewerker,
AVG(age_permanent_contract_hulpkracht) as avg_age_permanent_contract_hulpkracht,
/* gemiddelde leeftijd bepaalde tijd*/
AVG(age_non_permanent_contract_teammanager) as avg_age_non_permanent_contract_teammanager,
AVG(age_non_permanent_contract_medewerker) as avg_age_non_permanent_contract_medewerker,
AVG(age_non_permanent_contract_hulpkracht) as avg_age_non_permanent_contract_hulpkracht,
/* leeftijd >= 23 jaar*/
SUM(age_23_and_older_teammanager) as age_23_and_older_teammanager,
SUM(age_23_and_older_medewerker) as age_23_and_older_medewerker,
SUM(age_23_and_older_hulpkracht) as age_23_and_older_hulpkracht,
/* leeftijd < 23 jaar*/
SUM(age_under_23_teammanager) as age_under_23_teammanager,
SUM(age_under_23_medewerker) as age_under_23_medewerker,
SUM(age_under_23_hulpkracht) as age_under_23_hulpkracht
FROM s_conl_workbench.v_g_po_lager_prep_2

	GROUP BY cost_center, cy_month

);



