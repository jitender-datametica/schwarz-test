CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_vorgart_best_entw (mandant_id, vorgart_best_entw_id) AS SELECT
 mandant_id,
 vorgart_best_entw_id
FROM kfl_production_dbp_view.v_l_vorgart_best_entw;