CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_nb AS SELECT nb_id,
 nb_bez
FROM kfl_production_dbp_view.v_nb AS V01
WHERE nb_id IN (- 2, - 1, 0, 2, 7);