CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_bf4_gesamt AS SELECT CAST(CASE
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
  WHEN GRIETJE.warehouse_description = 'De Graaf Non Food'
  THEN 'De Graaf'
  ELSE GRIETJE.warehouse_description
  END AS regio,
 'Warenbereitstellung' AS regio_sub,
 NULL AS vl,
 NULL AS rm,
 GRIETJE.warehouse_turnover,
 GRIETJE.returns_value,
 GRIETJE.warehouse_vat_rate,
 GRIETJE.warehouse_turnover_net,
 GRIETJE.returns_value_net,
  CASE
  WHEN GRIETJE.warehouse_turnover_net = 0 OR GRIETJE.returns_value_net = 0
  THEN 0
  ELSE GRIETJE.returns_value_net / GRIETJE.warehouse_turnover_net * 100
  END AS returns_quote,
 GRIETJE.gross_cases_picking AS netto_cases_picking,
 GRIETJE.euro_per_case,
 GRIETJE.pallets_in,
 GRIETJE.pallets_out,
  CASE
  WHEN GRIETJE.gross_cases_picking = 0 OR GRIETJE.pallets_out = 0
  THEN 0
  ELSE GRIETJE.gross_cases_picking / GRIETJE.pallets_out
  END AS cases_per_pallet,
 0 AS we_hours_gross,
 GRIETJE.warehouse_hours_overtime AS we_hours_overtime,
 0 AS we_hours_sick,
 0 AS we_hours_holiday,
 GRIETJE.hours_external_organisation AS we_hours_external,
 GRIETJE.hours_total_wh_organisation AS we_hours_total,
 0 AS hours_excise,
 0 AS hours_stickering,
  CASE
  WHEN GRIETJE.pallets_out = 0 OR GRIETJE.hours_total_wh_organisation = 0
  THEN 0
  ELSE GRIETJE.pallets_out / GRIETJE.hours_total_wh_organisation
  END AS we_pallets_per_hour,
 GRIETJE.hours_gross_operations AS wb_hours_gross,
 GRIETJE.hours_overtime_operations AS wb_hours_overtime,
 GRIETJE.hours_sick_operations AS wb_hours_sick,
 GRIETJE.hours_leave_operations AS wb_hours_holiday,
 GRIETJE.hours_external_operations AS wb_hours_external,
 GRIETJE.hours_total_operations AS wb_hours_total,
 GRIETJE.hours_returns,
 GRIETJE.hours_picking AS hours_wamas,
  GRIETJE.hours_total_operations - GRIETJE.hours_picking AS difference_total_wamas,
  CASE
  WHEN GRIETJE.returns_value_net = 0 OR GRIETJE.hours_returns = 0
  THEN 0
  ELSE GRIETJE.returns_value_net / GRIETJE.hours_returns
  END AS returns_euro_per_hour,
  CASE
  WHEN GRIETJE.gross_cases_picking = 0 OR GRIETJE.hours_total_operations = 0
  THEN 0
  ELSE GRIETJE.gross_cases_picking / GRIETJE.hours_total_operations
  END AS cases_per_hour,
  CASE
  WHEN GRIETJE.pallets_out = 0 OR GRIETJE.hours_total_operations = 0
  THEN 0
  ELSE GRIETJE.pallets_out / GRIETJE.hours_total_operations
  END AS wb_pallets_per_hour,
 GRIETJE.hours_netto_process AS wa_hours_gross,
 GRIETJE.pr_hours_overtime AS wa_hours_overtime,
 GRIETJE.hours_sick_process AS wa_hours_sick,
 GRIETJE.hours_leave_process AS wa_hours_holiday,
 GRIETJE.hours_external_process AS wa_hours_external,
 GRIETJE.hours_total_process AS wa_hours_total,
  CASE
  WHEN GRIETJE.pallets_out = 0 OR GRIETJE.hours_total_process = 0
  THEN 0
  ELSE GRIETJE.pallets_out / GRIETJE.hours_total_process
  END AS wa_pallets_per_hour,
  GRIETJE.hours_total_house_tech + GRIETJE.hours_total_wh_organisation AS hours_bt_and_house_tech,
  GRIETJE.hours_total - GRIETJE.hours_total_external AS hours_total_dc,
 GRIETJE.hours_total_external,
 GRIETJE.hours_total,
  CASE
  WHEN GRIETJE.gross_cases_picking = 0 OR GRIETJE.hours_total = 0
  THEN 0
  ELSE GRIETJE.gross_cases_picking / GRIETJE.hours_total
  END AS productivity_cases_per_hour_total,
  CASE
  WHEN GRIETJE.pallets_out = 0 OR GRIETJE.hours_total = 0
  THEN 0
  ELSE GRIETJE.pallets_out / GRIETJE.hours_total
  END AS productivity_pallets_per_hour_total,
 GRIETJE.cost_per_pallet
FROM ldl_s_conl_workbench.t_i_g_elke_business AS GRIETJE
 LEFT JOIN ldl_s_conl_workbench.t_m_month_periode AS CAL ON GRIETJE.business_year = CAST(CAL.booking_year AS FLOAT64)
  AND GRIETJE.report_month = CAST(CAL.month_id AS FLOAT64);