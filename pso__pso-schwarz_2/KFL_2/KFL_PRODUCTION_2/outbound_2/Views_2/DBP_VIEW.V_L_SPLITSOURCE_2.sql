CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_splitsource_2 AS SELECT mandant_id,
 splitsource_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_splitsource_2;