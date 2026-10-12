CREATE OR REPLACE VIEW s_conl_workbench.v_g_bf3_gesamt_export_1
AS
(SELECT
-- metadata
booking_periode|| CASE
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
right(CAST(bf3.cy_month AS varchar(10)), 4) as year_month,
/* bf3 gesamt*/
pallets_store_distribution,
pallets_non_store_distribution,
hours_gross,
hours_extra,
hours_sick,
hours_leave,
hours_external,
hours_total,
productivity_pallets_per_hour,
count_trucks,
amount_of_shifts,
use_time,
kilometers,
amount_of_trips,
trips_per_shift,
pallets_per_shift,
load_factor,
cost_per_pallet,
kilometer_per_pallet
FROM s_conl_workbench.v_g_bf3_gesamt_1 bf3

LEFT JOIN s_conl_workbench.t_m_month_periode_1 cal
ON bf3.cy_month = cal.cy_month
);


