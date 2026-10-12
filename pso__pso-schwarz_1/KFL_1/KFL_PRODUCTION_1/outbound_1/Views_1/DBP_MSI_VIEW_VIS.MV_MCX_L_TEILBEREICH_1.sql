CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_l_teilbereich_1 (teilbereich_id, ber_id) AS SELECT
 teilbereich_id,
 ber_id
FROM kfl_production_dbp_view.v_mcx_l_teilbereich_1;