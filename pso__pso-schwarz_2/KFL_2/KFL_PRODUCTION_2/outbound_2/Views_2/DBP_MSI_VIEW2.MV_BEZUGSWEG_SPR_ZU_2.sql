CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_bezugsweg_spr_zu_2 (mandant_id, bezugsweg_id, spr_id, bezugsweg_bez
) AS SELECT mandant_id,
 bezugsweg_id,
 spr_id,
 bezugsweg_bez
FROM kfl_production_dbp_view.v_bezugsweg_spr_zu_2 AS V01
WHERE mandant_id = 1
 AND spr_id = 22;