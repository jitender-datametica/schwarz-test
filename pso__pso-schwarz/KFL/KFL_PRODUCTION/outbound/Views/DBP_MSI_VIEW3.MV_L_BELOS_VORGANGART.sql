CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_belos_vorgangart (mandant_id, belos_vorgangart_id) AS SELECT
 mandant_id,
 belos_vorgangart_id
FROM kfl_production_dbp_view.v_l_belos_vorgangart;