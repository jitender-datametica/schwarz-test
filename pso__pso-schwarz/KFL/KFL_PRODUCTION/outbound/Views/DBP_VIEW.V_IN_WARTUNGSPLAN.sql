CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_wartungsplan AS SELECT mandant_id,
 wart_plan_id,
 wart_plan_bez,
 wart_plan_sort_id
FROM kfl_production_dbp_data.in_wartungsplan;