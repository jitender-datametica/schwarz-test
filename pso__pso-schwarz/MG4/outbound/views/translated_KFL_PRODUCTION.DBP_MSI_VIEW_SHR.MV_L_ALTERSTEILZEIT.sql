CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_altersteilzeit (mandant_id, atz_phase_id) AS SELECT *
FROM kfl_production_dbp_view.v_l_altersteilzeit AS v01;