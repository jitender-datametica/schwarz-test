CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_po_lager_1 AS -- metadata
 /* headcount */ /* FTE */
/* gemiddeld bruto uurloon */ /* contractsoort onbepaalde tijd */ /* contractsoort bepaalde tijd */
/* gemiddeld aantal dienstjaren */ /* gemiddelde leeftijd onbepaalde tijd */ /* gemiddelde leeftijd bepaalde tijd */
/* leeftijd >= 23 jaar */ /* leeftijd < 23 jaar */ SELECT cost_center,
 cy_month,
 SUM(headcount_teammanager) AS headcount_teammanager,
 SUM(headcount_medewerker) AS headcount_medewerker,
 SUM(headcount_hulpkracht) AS headcount_hulpkracht,
 SUM(fte_teammanager) AS fte_teammanager,
 SUM(fte_medewerker) AS fte_medewerker,
 SUM(fte_hulpkracht) AS fte_hulpkracht,
 MAX(cla_hourly_wage_teammanager) AS cla_hourly_wage_teammanager,
 MAX(cla_hourly_wage_medewerker) AS cla_hourly_wage_medewerker,
 MAX(cla_hourly_wage_hulpkracht) AS cla_hourly_wage_hulpkracht,
 SUM(permanent_contract_teammanager) AS permanent_contract_teammanager,
 SUM(permanent_contract_medewerker) AS permanent_contract_medewerker,
 SUM(permanent_contract_hulpkracht) AS permanent_contract_hulpkracht,
 SUM(non_permanent_contract_teammanager) AS non_permanent_contract_teammanager,
 SUM(non_permanent_contract_medewerker) AS non_permanent_contract_medewerker,
 SUM(non_permanent_contract_hulpkracht) AS non_permanent_contract_hulpkracht,
 AVG(years_service_teammanager) AS avg_years_service_teammanager,
 AVG(years_service_medewerker) AS avg_years_service_medewerker,
 AVG(years_service_hulpkracht) AS avg_years_service_hulpkracht,
 AVG(age_permanent_contract_teammanager) AS avg_age_permanent_contract_teammanager,
 AVG(age_permanent_contract_medewerker) AS avg_age_permanent_contract_medewerker,
 AVG(age_permanent_contract_hulpkracht) AS avg_age_permanent_contract_hulpkracht,
 AVG(age_non_permanent_contract_teammanager) AS avg_age_non_permanent_contract_teammanager,
 AVG(age_non_permanent_contract_medewerker) AS avg_age_non_permanent_contract_medewerker,
 AVG(age_non_permanent_contract_hulpkracht) AS avg_age_non_permanent_contract_hulpkracht,
 SUM(age_23_and_older_teammanager) AS age_23_and_older_teammanager,
 SUM(age_23_and_older_medewerker) AS age_23_and_older_medewerker,
 SUM(age_23_and_older_hulpkracht) AS age_23_and_older_hulpkracht,
 SUM(age_under_23_teammanager) AS age_under_23_teammanager,
 SUM(age_under_23_medewerker) AS age_under_23_medewerker,
 SUM(age_under_23_hulpkracht) AS age_under_23_hulpkracht
FROM ldl_s_conl_workbench.v_g_po_lager_prep_1
GROUP BY cost_center,
 cy_month;