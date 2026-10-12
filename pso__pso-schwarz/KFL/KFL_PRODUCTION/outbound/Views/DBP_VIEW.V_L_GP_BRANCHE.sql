CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_gp_branche AS SELECT system_id,
 mandant_id,
 gp_branche_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_gp_branche;