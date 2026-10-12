CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_in_l_wg AS SELECT in_wg_id,
 mandant_id
FROM kfl_production_dbp_view.v_in_l_wg AS V01;