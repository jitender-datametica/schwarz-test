CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_bezugsweg_spr_zu_2 (mandant_id, bwscl, spr_id, bezugsweg_bez) AS
SELECT mandant_id,
 bezugsweg_id AS bwscl,
 spr_id,
 bezugsweg_bez
FROM kfl_production_dbp_view.v_bezugsweg_spr_zu_2
WHERE spr_id = 22
 AND mandant_id <> 1;