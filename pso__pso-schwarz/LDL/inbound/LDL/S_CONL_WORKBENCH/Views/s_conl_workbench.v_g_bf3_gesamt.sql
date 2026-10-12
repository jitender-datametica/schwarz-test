CREATE OR REPLACE VIEW s_conl_workbench.v_g_bf3_gesamt
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
WHEN warehouse_id= 9 THEN 909648 END AS VARCHAR(15)) as cost_center,
TO_NUMBER(cal.cy_month) as cy_month,
'Gesellschaft' as gesell_DL,
'Lager' as fil_lag_fix,
CASE
WHEN warehouse_description is null THEN 'Totaal'
ELSE warehouse_description END as regio,
'Warenbereitstellung' as regio_sub,
0 as vl,
0 as rm,
/* process data*/
pallet_stores as pallets_store_distribution,
pallet_non_stores as pallets_non_store_distribution,
hours_net_processes as hours_gross,
hours_over as hours_extra,
hours_sick_processes as hours_sick,
hours_leave_processes as hours_leave,
hours_external as hours_external,
hours_total_processes as hours_total,
CASE
WHEN hours_total_processes = 0 THEN 0
ELSE coalesce(pallet_stores/hours_total_processes, 0) END as productivity_pallets_per_hour,
CAST(CAST(count_trucks AS Number(38,5)) / CAST(mon.days_in_month as Number(38,5)) AS Number(38,5)) as amount_of_trucks_per_day,
count_trucks as count_trucks,
mon.days_in_month as days_in_month,
count_shifts as amount_of_shifts,
use_time as use_time,
kilometer as kilometers,
count_tours as amount_of_trips,
tours_per_shift as trips_per_shift,
pallets_per_shift as pallets_per_shift,
utilization_percentage as load_factor,
cost_per_pallet as cost_per_pallet,
km_per_pallet as kilometer_per_pallet
FROM s_conl_workbench.t_i_g_elke_processes as grietje

LEFT JOIN s_conl_workbench.t_m_month_periode as cal
ON grietje.business_year = cal.booking_year
AND grietje.report_month = cal.month_id

LEFT JOIN (SELECT
cy_month as cy_month,
max(day_of_month) as days_in_month
FROM s_conl.v_cal_calendarday group by cy_month) as mon
	ON cal.cy_month = mon.cy_month

);


