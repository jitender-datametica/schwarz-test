CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_bereich_spr_zu_1 (bereich_id, spr_id, bereich_bez) AS SELECT
 bereich_id,
 spr_id,
 bereich_bez
FROM kfl_production_dbp_data.mdl_bereich_spr_zu_1;