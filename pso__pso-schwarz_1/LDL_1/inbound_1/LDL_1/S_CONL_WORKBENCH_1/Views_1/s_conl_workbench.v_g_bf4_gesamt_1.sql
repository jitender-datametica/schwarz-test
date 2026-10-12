CREATE OR REPLACE VIEW s_conl_workbench.v_g_bf4_gesamt_1
AS
(SELECT

-- metadata
CAST(CASE
WHEN warehouse_id = 1 THEN 109648
WHEN warehouse_id= 2 THEN 209648
WHEN warehouse_id= 3 THEN 319648
WHEN warehouse_id= 4 THEN 409648
WHEN warehouse_id= 5 THEN 509648
WHEN warehouse_id= 6 THEN 609648
WHEN warehouse_id= 9 THEN 909648
ELSE NULL END AS VARCHAR(15)) as cost_center,
TO_NUMBER(cal.cy_month) as cy_month,
'Gesellschaft' as gesell_DL,
'Lager' as fil_lag_fix,
CASE
WHEN warehouse_description is null THEN 'Totaal'
WHEN warehouse_description = 'De Graaf Non Food' THEN 'De Graaf'
ELSE warehouse_description END as regio,
'Warenbereitstellung' as regio_sub,
NULL as vl,
NULL as rm,
/* warehouse data*/
warehouse_turnover as warehouse_turnover,
returns_value as returns_value,
warehouse_vat_rate as warehouse_vat_rate,
warehouse_turnover_net as warehouse_turnover_net,
returns_value_net as returns_value_net,
CASE
WHEN warehouse_turnover_net = 0
OR returns_value_net = 0 THEN 0
ELSE (returns_value_net/warehouse_turnover_net)*100 END as returns_quote,
gross_cases_picking as netto_cases_picking,
euro_per_case as euro_per_case,
pallets_in as pallets_in,
pallets_out as pallets_out,
CASE
WHEN gross_cases_picking = 0
OR pallets_out = 0 THEN 0
ELSE gross_cases_picking/pallets_out END as cases_per_pallet,
/*WE: groep is opgeheven, data staat er als filler*/
0 as WE_hours_gross,
warehouse_hours_overtime as WE_hours_overtime,
0 as WE_hours_sick,
0 as WE_hours_holiday,
hours_external_organisation as WE_hours_external,
hours_total_WH_organisation as WE_hours_total,
0 as hours_excise,
0 as hours_stickering,
CASE
WHEN pallets_out = 0 OR hours_total_WH_organisation = 0 THEN 0
ELSE (pallets_out/hours_total_WH_organisation) END as WE_pallets_per_hour,
/* WB*/
hours_gross_operations as WB_hours_gross,
hours_overtime_operations as WB_hours_overtime,
hours_sick_operations as WB_hours_sick,
hours_leave_operations as WB_hours_holiday,
hours_external_operations as WB_hours_external,
hours_total_operations as WB_hours_total,
hours_returns as hours_returns,
hours_picking as hours_WAMAS,
(hours_total_operations- hours_picking) as difference_total_WAMAS,
CASE
WHEN returns_value_net = 0
OR hours_returns = 0 THEN 0
ELSE returns_value_net/hours_returns END as returns_euro_per_hour,
CASE
WHEN gross_cases_picking = 0 OR hours_total_operations = 0 THEN 0
ELSE (gross_cases_picking/hours_total_operations) END as cases_per_hour,
CASE
WHEN pallets_out = 0 OR hours_total_operations = 0 THEN 0
ELSE (pallets_out/hours_total_operations) END as WB_pallets_per_hour,
/* WA*/
hours_netto_process as WA_hours_gross,
pr_hours_overtime as WA_hours_overtime,
hours_sick_process as WA_hours_sick,
hours_leave_process as WA_hours_holiday,
hours_external_process as WA_hours_external,
hours_total_process as WA_hours_total,
CASE
WHEN pallets_out = 0 OR hours_total_process = 0 THEN 0
ELSE (pallets_out / hours_total_process) END as WA_pallets_per_hour,
/* rest*/
hours_total_house_tech + hours_total_WH_organisation as hours_BT_and_house_tech,
(hours_total - hours_total_external) as hours_total_DC,
hours_total_external as hours_total_external,
hours_total as hours_total,
CASE
WHEN gross_cases_picking = 0
OR hours_total = 0 THEN 0
ELSE gross_cases_picking / hours_total END as productivity_cases_per_hour_total,
CASE
WHEN pallets_out = 0
OR hours_total = 0 THEN 0
ELSE pallets_out / hours_total END as productivity_pallets_per_hour_total,
cost_per_pallet as cost_per_pallet
FROM s_conl_workbench.t_i_g_elke_business_1 as grietje

-- t_i_g_elke_business_1 contains booking_year and month_id
LEFT JOIN s_conl_workbench.t_m_month_periode_1 as cal
ON grietje.business_year = cal.booking_year
AND grietje.report_month = cal.month_id
);


