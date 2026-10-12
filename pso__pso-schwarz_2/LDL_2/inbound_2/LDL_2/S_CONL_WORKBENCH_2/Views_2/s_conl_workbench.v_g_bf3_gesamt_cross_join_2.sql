CREATE OR REPLACE VIEW s_conl_workbench.v_g_bf3_gesamt_cross_join_2
AS
(SELECT
cct.cost_center,
cal.cy_month,
'Gesellschaft' as gesell_DL,
'Lager' as fil_lag_fix,
CASE
WHEN LEFT(cct.cost_center, 1) = 1 THEN 'Heerenveen'
WHEN LEFT(cct.cost_center, 1) = 2 THEN 'Etten-Leur'
WHEN LEFT(cct.cost_center, 1) = 3 THEN 'Oosterhout'
WHEN LEFT(cct.cost_center, 1) = 4 THEN 'Zwaag'
WHEN LEFT(cct.cost_center, 1) = 5 THEN 'Weert'
WHEN LEFT(cct.cost_center, 1) = 6 THEN 'Waddinxveen'
WHEN LEFT(cct.cost_center, 1) = 9 THEN 'De Graaf' END as regio,
'Warenbereitstellung' as regio_sub,
0 as vl,
0 as rm,
bf3.pallets_store_distribution,
bf3.pallets_non_store_distribution,
bf3.hours_gross,
bf3.hours_extra,
bf3.hours_sick,
bf3.hours_leave,
bf3.hours_external,
bf3.hours_total,
bf3.productivity_pallets_per_hour,
bf3.amount_of_trucks_per_day,
bf3.count_trucks,
bf3.days_in_month,
bf3.amount_of_shifts,
bf3.use_time,
bf3.kilometers,
bf3.amount_of_trips,
bf3.trips_per_shift,
bf3.pallets_per_shift,
bf3.load_factor,
bf3.cost_per_pallet,
bf3.kilometer_per_pallet
FROM
(SELECT DISTINCT cost_center as cost_center
FROM s_conl_workbench.v_g_po_lager_2 where cost_center is not null) as cct
CROSS JOIN
		(SELECT DISTINCT cy_month as cy_month
FROM s_conl_workbench.v_g_po_lager_2) as cal

LEFT JOIN s_conl_workbench.v_g_bf3_gesamt_2 as bf3
ON cct.cost_center = bf3.cost_center
AND cal.cy_month = bf3.cy_month

);


