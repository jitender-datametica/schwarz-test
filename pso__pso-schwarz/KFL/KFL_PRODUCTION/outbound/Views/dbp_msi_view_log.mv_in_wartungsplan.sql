CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_wartungsplan (mandant_id, wart_plan_sort_id, wart_plan_bez
, wart_plan_sort_bez, wart_plan_id) AS SELECT mandant_id,
 COALESCE(NULLIF(TRIM(wart_plan_sort_id), ''), '-1') AS wart_plan_sort_id,
 wart_plan_bez,
 wart_plan_sort_id AS wart_plan_sort_bez,
 wart_plan_id
FROM kfl_production_dbp_view.v_in_wartungsplan;