CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_bezugsweg (bezugsweg_id) AS SELECT bezugsweg_id
FROM kfl_production_dbp_view.v_l_bezugsweg
GROUP BY bezugsweg_id;