CREATE OR REPLACE VIEW s_conl_workbench.v_g_elke_logistics_1
AS
(SELECT
-- metadata
CAST(TRUNC(bf3.cost_center) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ as cost_center,
bf3.cy_month as cy_month,
bf3.gesell_DL as classification_1,
bf3.fil_lag_fix as classification_2,
bf3.regio as classification_3,
bf3.regio_sub as classification_4,
bf3.vl as classification_5,
bf3.rm as classification_6,
/*bf4 data*/
bf4.netto_cases_picking as cases,
bf4.pallets_in as pallets_in,
bf4.pallets_out as pallets_out,
bf4.WE_hours_gross as WE_hours_gross,
bf4.WE_hours_overtime as WE_hours_overtime,
bf4.WE_hours_sick as WE_hours_sick,
bf4.WE_hours_holiday as WE_hours_holiday,
bf4.WE_hours_external as WE_hours_external,
bf4.WE_hours_total as WE_hours_total,
bf4.WB_hours_gross as WB_hours_gross,
bf4.WB_hours_overtime as WB_hours_overtime,
bf4.WB_hours_sick as WB_hours_sick,
bf4.WB_hours_holiday as WB_hours_holiday,
bf4.WB_hours_external as WB_hours_external,
bf4.WB_hours_total as WB_hours_total,
bf4.WA_hours_gross as WA_hours_gross,
bf4.WA_hours_overtime as WA_hours_overtime,
bf4.WA_hours_sick as WA_hours_sick,
bf4.WA_hours_holiday as WA_hours_holiday,
bf4.WA_hours_external as WA_hours_external,
bf4.WA_hours_total as WA_hours_total,
bf4.hours_BT_and_house_tech as hours_BT_and_house_tech,
bf4.hours_total - bf4.hours_total_external as hours_internal,
bf4.hours_total_external as hours_total_external,
bf4.hours_total as hours_total,
bf4.productivity_cases_per_hour_total as productivity_cases_per_hour_total,
bf4.productivity_pallets_per_hour_total as productivity_pallets_per_hour_total,
/* bf3 data	*/
bf3.load_factor as load_factor,
bf3.amount_of_trips as amount_of_trips,
(bf3.load_factor * bf3.amount_of_trips) as load_factor_times_trips,
bf3.amount_of_trucks_per_day,
bf3.kilometers,
bf3.use_time,
/* logistics rates data	*/
lr.hourly_rate as uurtarief,
lr.kilometer_rate as kilometertarief,
/* PO LEAD data part 1*/
headcount_teammanager,
headcount_medewerker,
headcount_hulpkracht,
fte_teammanager,
fte_medewerker,
fte_hulpkracht,
/* eployee_fluctuation data*/
fluc.employee_inflow_teammanager,
fluc.employee_inflow_medewerker,
fluc.employee_inflow_hulpkracht,
fluc.employee_outflow_teammanager,
fluc.employee_outflow_medewerker,
fluc.employee_outflow_hulpkracht,
/* PO LEAD data part 2*/
CLA_hourly_wage_teammanager,
CLA_hourly_wage_medewerker,
CLA_hourly_wage_hulpkracht,
permanent_contract_teammanager,
permanent_contract_medewerker,
permanent_contract_hulpkracht,
non_permanent_contract_teammanager,
non_permanent_contract_medewerker,
non_permanent_contract_hulpkracht,
avg_years_service_teammanager,
avg_years_service_medewerker,
avg_years_service_hulpkracht,
avg_age_permanent_contract_teammanager,
avg_age_permanent_contract_medewerker,
avg_age_permanent_contract_hulpkracht,
avg_age_non_permanent_contract_teammanager,
avg_age_non_permanent_contract_medewerker,
avg_age_non_permanent_contract_hulpkracht,
age_23_and_older_teammanager,
age_23_and_older_medewerker,
age_23_and_older_hulpkracht,
age_under_23_teammanager,
age_under_23_medewerker,
age_under_23_hulpkracht
FROM s_conl_workbench.v_g_bf3_gesamt_cross_join_1 as bf3

-- joining bf4 on bf3
LEFT JOIN s_conl_workbench.v_g_bf4_gesamt_1 as bf4
ON bf3.cost_center = bf4.cost_center
AND bf3.cy_month = bf4.cy_month
AND bf3.gesell_DL = bf4.gesell_DL
AND bf3.fil_lag_fix = bf4.fil_lag_fix
AND bf3.regio = bf4.regio
AND bf3.regio_sub = bf4.regio_sub


-- joining logistics_rates on bf3
LEFT JOIN s_conl_workbench.v_g_logistics_rates_1 lr
ON bf3.cost_center = lr.cost_center
AND bf3.cy_month = lr.cy_month

-- joining PO_lead data on ELKE data
LEFT JOIN s_conl_workbench.v_g_po_lager_1 as lager
ON bf3.cy_month = lager.cy_month
AND bf3.cost_center = lager.cost_center

-- joining employee_1 fluctuations on ELKE data
LEFT JOIN s_conl_workbench.v_g_employee_fluctuation_1 fluc
ON bf3.cost_center = fluc.orig_store_nr
AND bf3.cy_month = fluc.cy_month

);


