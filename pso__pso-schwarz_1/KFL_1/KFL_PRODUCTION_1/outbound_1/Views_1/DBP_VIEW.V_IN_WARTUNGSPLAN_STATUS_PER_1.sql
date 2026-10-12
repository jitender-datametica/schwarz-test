CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_wartungsplan_status_per_1 AS SELECT mandant_id,
 wart_plan_id,
 wart_plan_status_id,
 status_fg,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.in_wartungsplan_status_per_1;