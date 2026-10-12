CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_belegart_spr_zu_bg (system_id, mandant_id, spr_id, blart,
belegart_bez) AS SELECT system_id,
 mandant_id,
 spr_id,
 belegart_id AS blart,
 belegart_bez
FROM kfl_production_dbp_view.v_belegart_spr_zu AS V01
WHERE spr_id = 18;