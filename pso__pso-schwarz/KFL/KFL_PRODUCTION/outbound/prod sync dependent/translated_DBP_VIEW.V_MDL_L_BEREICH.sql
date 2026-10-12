CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_l_bereich (bereich_id, hauptbereich_fg) AS SELECT bereich_id,
 hauptbereich_fg
FROM kfl_production_dbp_data.mdl_l_bereich;