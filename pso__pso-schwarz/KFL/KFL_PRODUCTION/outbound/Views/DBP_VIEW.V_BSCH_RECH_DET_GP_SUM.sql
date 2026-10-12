CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bsch_rech_det_gp_sum AS SELECT mandant_id,
 dat,
 gp_id,
 vw_id,
 ek_n,
 wrg_id
FROM kfl_production_dbp_data.bsch_rech_det_gp_sum;