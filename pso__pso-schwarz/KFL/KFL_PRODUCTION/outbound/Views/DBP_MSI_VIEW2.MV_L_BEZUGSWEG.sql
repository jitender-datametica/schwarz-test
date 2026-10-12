CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_bezugsweg (bezugsweg_id, mandant_id) AS SELECT bezugsweg_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_bezugsweg
WHERE mandant_id = 1;