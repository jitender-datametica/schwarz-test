CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_bf3_gesamt_cross_join AS SELECT cct.cost_center,
 cal.cy_month,
 'Gesellschaft' AS gesell_dl,
 'Lager' AS fil_lag_fix,
  CASE
  WHEN CAST(LEFT(cct.cost_center, 1) AS FLOAT64) = 1
  THEN 'Heerenveen'
  WHEN CAST(LEFT(cct.cost_center, 1) AS FLOAT64) = 2
  THEN 'Etten-Leur'
  WHEN CAST(LEFT(cct.cost_center, 1) AS FLOAT64) = 3
  THEN 'Oosterhout'
  WHEN CAST(LEFT(cct.cost_center, 1) AS FLOAT64) = 4
  THEN 'Zwaag'
  WHEN CAST(LEFT(cct.cost_center, 1) AS FLOAT64) = 5
  THEN 'Weert'
  WHEN CAST(LEFT(cct.cost_center, 1) AS FLOAT64) = 6
  THEN 'Waddinxveen'
  WHEN CAST(LEFT(cct.cost_center, 1) AS FLOAT64) = 9
  THEN 'De Graaf'
  ELSE NULL
  END AS regio,
 'Warenbereitstellung' AS regio_sub,
 0 AS vl,
 0 AS rm,
 BF3.pallets_store_distribution,
 BF3.pallets_non_store_distribution,
 BF3.hours_gross,
 BF3.hours_extra,
 BF3.hours_sick,
 BF3.hours_leave,
 BF3.hours_external,
 BF3.hours_total,
 BF3.productivity_pallets_per_hour,
 BF3.amount_of_trucks_per_day,
 BF3.count_trucks,
 BF3.days_in_month,
 BF3.amount_of_shifts,
 BF3.use_time,
 BF3.kilometers,
 BF3.amount_of_trips,
 BF3.trips_per_shift,
 BF3.pallets_per_shift,
 BF3.load_factor,
 BF3.cost_per_pallet,
 BF3.kilometer_per_pallet
FROM (SELECT DISTINCT cost_center
  FROM ldl_s_conl_workbench.v_g_po_lager
  WHERE cost_center IS NOT NULL) AS cct
 INNER JOIN (SELECT DISTINCT cy_month
  FROM ldl_s_conl_workbench.v_g_po_lager) AS cal ON TRUE
 LEFT JOIN ldl_s_conl_workbench.v_g_bf3_gesamt AS BF3 ON cct.cost_center = BF3.cost_center AND cal.cy_month = BF3.cy_month;