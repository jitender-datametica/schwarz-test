CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_altersteilzeit_spr_zu_cz_1 (mandant_id, atz_phase_id, atz_bez)
AS SELECT mandant_id,
 atz_phase_id,
 atz_bez
FROM kfl_production_dbp_view.v_altersteilzeit_spr_zu_1 AS V01
WHERE spr_id = 124;