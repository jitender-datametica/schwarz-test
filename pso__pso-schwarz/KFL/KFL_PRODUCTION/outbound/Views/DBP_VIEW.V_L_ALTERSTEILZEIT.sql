CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_altersteilzeit AS SELECT mandant_id,
 atz_phase_id
FROM kfl_production_dbp_data.l_altersteilzeit;