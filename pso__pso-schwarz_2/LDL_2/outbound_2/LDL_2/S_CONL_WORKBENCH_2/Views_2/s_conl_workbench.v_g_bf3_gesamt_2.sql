CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_bf3_gesamt_2 AS -- metadata
 SELECT CAST(CASE
   WHEN GRIETJE.warehouse_id = 1
   THEN 109648
   WHEN GRIETJE.warehouse_id = 2
   THEN 209648
   WHEN GRIETJE.warehouse_id = 3
   THEN 319648
   WHEN GRIETJE.warehouse_id = 4
   THEN 409648
   WHEN GRIETJE.warehouse_id = 5
   THEN 509648
   WHEN GRIETJE.warehouse_id = 6
   THEN 609648
   WHEN GRIETJE.warehouse_id = 9
   THEN 909648
   ELSE NULL
   END AS STRING) AS cost_center,
 ROUND(CAST(CAL.cy_month AS BIGNUMERIC), 0) AS cy_month,
 'Gesellschaft' AS gesell_dl,
 'Lager' AS fil_lag_fix,
  CASE
  WHEN GRIETJE.warehouse_description IS NULL
  THEN 'Totaal'
  ELSE GRIETJE.warehouse_description
  END AS regio,
 'Warenbereitstellung' AS regio_sub,
 0 AS vl,
 0 AS rm,
 /* process data */ GRIETJE.pallet_stores AS pallets_store_distribution,
 GRIETJE.pallet_non_stores AS pallets_non_store_distribution,
 GRIETJE.hours_net_processes AS hours_gross,
 GRIETJE.hours_over AS hours_extra,
 GRIETJE.hours_sick_processes AS hours_sick,
 GRIETJE.hours_leave_processes AS hours_leave,
 GRIETJE.hours_external,
 GRIETJE.hours_total_processes AS hours_total,
  CASE
  WHEN GRIETJE.hours_total_processes = 0
  THEN 0
  ELSE COALESCE(GRIETJE.pallet_stores / GRIETJE.hours_total_processes, 0)
  END AS productivity_pallets_per_hour,
 CAST(CAST(GRIETJE.count_trucks AS BIGNUMERIC) / CAST(mon.days_in_month AS BIGNUMERIC) AS BIGNUMERIC) AS
 amount_of_trucks_per_day,
 GRIETJE.count_trucks,
 mon.days_in_month,
 GRIETJE.count_shifts AS amount_of_shifts,
 GRIETJE.use_time,
 GRIETJE.kilometer AS kilometers,
 GRIETJE.count_tours AS amount_of_trips,
 GRIETJE.tours_per_shift AS trips_per_shift,
 GRIETJE.pallets_per_shift,
 GRIETJE.utilization_percentage AS load_factor,
 GRIETJE.cost_per_pallet,
 GRIETJE.km_per_pallet AS kilometer_per_pallet
FROM ldl_s_conl_workbench.t_i_g_elke_processes_2 AS GRIETJE
 LEFT JOIN ldl_s_conl_workbench.t_m_month_periode_2 AS CAL ON GRIETJE.business_year = CAST(CAL.booking_year AS FLOAT64)
  AND GRIETJE.report_month = CAST(CAL.month_id AS FLOAT64)
 LEFT JOIN (SELECT cy_month,
   MAX(day_of_month) AS days_in_month
  FROM ldl_s_conl.v_cal_calendarday_2
  GROUP BY cy_month) AS mon ON CAST(CAL.cy_month AS FLOAT64) = mon.cy_month;