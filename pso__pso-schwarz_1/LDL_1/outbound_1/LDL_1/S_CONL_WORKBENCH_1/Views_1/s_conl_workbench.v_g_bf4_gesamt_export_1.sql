CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_bf4_gesamt_export_1 AS SELECT -- metadata
 CAL.booking_periode || CASE
    WHEN BF4.regio = 'De Graaf Non Food'
    THEN 'De Graaf'
    ELSE BF4.regio
    END || 'Warenbereitstellung' AS maand_dc_proces,
  CASE
  WHEN BF4.regio = 'Totaal'
  THEN 1
  WHEN BF4.regio = 'Heerenveen'
  THEN 2
  WHEN BF4.regio = 'Etten-Leur'
  THEN 3
  WHEN BF4.regio = 'Oosterhout'
  THEN 4
  WHEN BF4.regio = 'Zwaag'
  THEN 5
  WHEN BF4.regio = 'Weert'
  THEN 6
  WHEN BF4.regio = 'De Graaf Non Food'
  THEN 7
  WHEN BF4.regio = 'Waddinxveen'
  THEN 8
  ELSE NULL
  END AS sorting,
 CAL.booking_periode AS maand,
  CASE
  WHEN BF4.regio = 'De Graaf Non Food'
  THEN 'De Graaf'
  ELSE BF4.regio
  END AS dc,
 RIGHT(CAST(BF4.cy_month AS STRING), 4) AS year_month,
 /* bf4 gesamt */ BF4.warehouse_turnover,
 BF4.returns_value,
 BF4.warehouse_vat_rate,
 BF4.warehouse_turnover_net,
 BF4.returns_value_net,
 BF4.returns_quote,
 BF4.netto_cases_picking,
 BF4.euro_per_case,
 BF4.pallets_in,
 BF4.pallets_out,
 BF4.cases_per_pallet,
 BF4.we_hours_gross,
 BF4.we_hours_overtime,
 BF4.we_hours_sick,
 BF4.we_hours_holiday,
 BF4.we_hours_external,
 BF4.we_hours_total,
 BF4.hours_excise,
 BF4.hours_stickering,
 BF4.we_pallets_per_hour,
 BF4.wb_hours_gross,
 BF4.wb_hours_overtime,
 BF4.wb_hours_sick,
 BF4.wb_hours_holiday,
 BF4.wb_hours_external,
 BF4.wb_hours_total,
 BF4.hours_returns,
 BF4.hours_wamas,
 BF4.difference_total_wamas,
 BF4.returns_euro_per_hour,
 BF4.cases_per_hour,
 BF4.wb_pallets_per_hour,
 BF4.wa_hours_gross,
 BF4.wa_hours_overtime,
 BF4.wa_hours_sick,
 BF4.wa_hours_holiday,
 BF4.wa_hours_external,
 BF4.wa_hours_total,
 BF4.wa_pallets_per_hour,
 BF4.hours_bt_and_house_tech,
 BF4.hours_total_dc,
 BF4.hours_total_external,
 BF4.hours_total,
 BF4.productivity_cases_per_hour_total,
 BF4.productivity_pallets_per_hour_total,
 BF4.cost_per_pallet
FROM ldl_s_conl_workbench.v_g_bf4_gesamt_1 AS BF4
 LEFT JOIN ldl_s_conl_workbench.t_m_month_periode_1 AS CAL ON BF4.cy_month = CAST(CAL.cy_month AS FLOAT64);