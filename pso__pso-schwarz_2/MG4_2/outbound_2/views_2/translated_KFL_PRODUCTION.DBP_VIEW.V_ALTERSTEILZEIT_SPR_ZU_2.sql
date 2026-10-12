CREATE OR REPLACE VIEW kfl_production_dbp_view.v_altersteilzeit_spr_zu_2 (mandant_id, atz_phase_id, spr_id, atz_bez) AS
SELECT mandant_id,
 atz_phase_id,
 spr_id,
 atz_bez
FROM kfl_production_dbp_data.altersteilzeit_spr_zu_2;