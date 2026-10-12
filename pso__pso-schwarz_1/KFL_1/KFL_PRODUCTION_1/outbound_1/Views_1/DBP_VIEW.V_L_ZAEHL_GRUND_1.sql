CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_zaehl_grund_1 AS SELECT mandant_id,
 zaehl_grund_id,
 zaehl_grund_gruppe_id
FROM kfl_production_dbp_data.l_zaehl_grund_1;