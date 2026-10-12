CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_bezugsweg_1 (bezugsweg_id, mandant_id) AS SELECT
 bezugsweg_id,
 mandant_id
FROM kfl_production_dbp_view.v_l_bezugsweg_1
WHERE mandant_id = 1;