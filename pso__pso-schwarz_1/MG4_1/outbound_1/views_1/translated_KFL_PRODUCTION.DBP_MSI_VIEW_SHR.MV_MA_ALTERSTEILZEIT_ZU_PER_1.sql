CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_altersteilzeit_zu_per_1 (mandant_id, atz_phase_id,
mitarbeiter_id, kjmo) AS SELECT mandant_id,
 atz_phase_id,
 mitarbeiter_id,
 kjmo
FROM kfl_production_dbp_view.v_ma_altersteilzeit_zu_per_1 AS v01;