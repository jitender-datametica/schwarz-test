CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_bf3_gesamt_export_2 AS SELECT -- metadata
 CAL.booking_periode || CASE
    WHEN BF3.regio = 'De Graaf Non Food'
    THEN 'De Graaf'
    ELSE BF3.regio
    END || 'Warenbereitstellung' AS maand_dc_proces,
  CASE
  WHEN BF3.regio = 'Totaal'
  THEN 1
  WHEN BF3.regio = 'Heerenveen'
  THEN 2
  WHEN BF3.regio = 'Etten-Leur'
  THEN 3
  WHEN BF3.regio = 'Oosterhout'
  THEN 4
  WHEN BF3.regio = 'Zwaag'
  THEN 5
  WHEN BF3.regio = 'Weert'
  THEN 6
  WHEN BF3.regio = 'De Graaf Non Food'
  THEN 7
  WHEN BF3.regio = 'Waddinxveen'
  THEN 8
  ELSE NULL
  END AS sorting,
 CAL.booking_periode AS maand,
  CASE
  WHEN BF3.regio = 'De Graaf Non Food'
  THEN 'De Graaf'
  ELSE BF3.regio
  END AS dc,
 RIGHT(CAST(BF3.cy_month AS STRING), 4) AS year_month,
 /* bf3 gesamt */ BF3.pallets_store_distribution,
 BF3.pallets_non_store_distribution,
 BF3.hours_gross,
 BF3.hours_extra,
 BF3.hours_sick,
 BF3.hours_leave,
 BF3.hours_external,
 BF3.hours_total,
 BF3.productivity_pallets_per_hour,
 BF3.count_trucks,
 BF3.amount_of_shifts,
 BF3.use_time,
 BF3.kilometers,
 BF3.amount_of_trips,
 BF3.trips_per_shift,
 BF3.pallets_per_shift,
 BF3.load_factor,
 BF3.cost_per_pallet,
 BF3.kilometer_per_pallet
FROM ldl_s_conl_workbench.v_g_bf3_gesamt_2 AS BF3
 LEFT JOIN ldl_s_conl_workbench.t_m_month_periode_2 AS CAL ON BF3.cy_month = CAST(CAL.cy_month AS FLOAT64);