CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kjmo_sort_1 AS SELECT mandant_id,
 kjmo,
 kjwo_update,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_kjmo_sort_1;