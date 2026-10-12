CREATE OR REPLACE VIEW s_conl_workbench.v_g_bf4_gesamt_export_2
AS
(SELECT
-- metadata
cal.booking_periode|| CASE
WHEN regio = 'De Graaf Non Food' THEN 'De Graaf'
ELSE regio END||
'Warenbereitstellung' as maand_dc_proces,
CASE
WHEN regio = 'Totaal' THEN 1
WHEN regio = 'Heerenveen' THEN 2
WHEN regio = 'Etten-Leur' THEN 3
WHEN regio = 'Oosterhout' THEN 4
WHEN regio = 'Zwaag' THEN 5
WHEN regio = 'Weert' THEN 6
WHEN regio = 'De Graaf Non Food' THEN 7
WHEN regio = 'Waddinxveen' THEN 8 END as sorting,
cal.booking_periode as maand,
CASE
WHEN regio = 'De Graaf Non Food' THEN 'De Graaf'
ELSE regio END as DC,
right(CAST(bf4.cy_month AS varchar(10)), 4) as year_month,
/* bf4 gesamt*/
warehouse_turnover,
returns_value,
warehouse_vat_rate,
warehouse_turnover_net,
returns_value_net,
returns_quote,
netto_cases_picking,
euro_per_case,
pallets_in,
pallets_out,
cases_per_pallet,
WE_hours_gross,
WE_hours_overtime,
WE_hours_sick,
WE_hours_holiday,
WE_hours_external,
WE_hours_total,
hours_excise,
hours_stickering,
WE_pallets_per_hour,
WB_hours_gross,
WB_hours_overtime,
WB_hours_sick,
WB_hours_holiday,
WB_hours_external,
WB_hours_total,
hours_returns,
hours_WAMAS,
difference_total_WAMAS,
returns_euro_per_hour,
cases_per_hour,
WB_pallets_per_hour,
WA_hours_gross,
WA_hours_overtime,
WA_hours_sick,
WA_hours_holiday,
WA_hours_external,
WA_hours_total,
WA_pallets_per_hour,
hours_BT_and_house_tech,
hours_total_DC,
hours_total_external,
hours_total,
productivity_cases_per_hour_total,
productivity_pallets_per_hour_total,
cost_per_pallet
FROM s_conl_workbench.v_g_bf4_gesamt_2 bf4

LEFT JOIN s_conl_workbench.t_m_month_periode_2 cal
ON bf4.cy_month = cal.cy_month
);


