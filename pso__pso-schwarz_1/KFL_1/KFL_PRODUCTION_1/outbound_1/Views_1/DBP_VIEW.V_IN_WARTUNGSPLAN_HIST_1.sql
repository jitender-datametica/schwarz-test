CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_wartungsplan_hist_1 AS SELECT mandant_id,
 wart_plan_id,
 wart_plan_abruf_id,
 wart_plan_abruf_zaehler,
 dat_plan,
 wart_plan_terminierungsart,
 dat_start,
 dat_erledigung,
 dat_abruf
FROM kfl_production_dbp_data.in_wartungsplan_hist_1;