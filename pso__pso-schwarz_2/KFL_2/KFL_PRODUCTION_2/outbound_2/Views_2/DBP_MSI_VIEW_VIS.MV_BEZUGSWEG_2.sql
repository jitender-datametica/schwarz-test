CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_bezugsweg_2 AS SELECT mandant_id,
 bezugsweg_id
FROM kfl_production_dbp_view.v_l_bezugsweg_2 AS V01;