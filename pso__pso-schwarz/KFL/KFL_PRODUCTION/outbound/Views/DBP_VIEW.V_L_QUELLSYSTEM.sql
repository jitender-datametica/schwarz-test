CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_quellsystem AS SELECT mandant_id,
 quellsystem_id,
 quellsystem_bez
FROM kfl_production_dbp_data.l_quellsystem;