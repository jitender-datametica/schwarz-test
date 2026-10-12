CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_artkz_eigenmarke AS SELECT eigenmarke_id,
 mandant_id,
 spr_id,
 eigenmarke_bez
FROM kfl_production_dbp_view.v_artkz_eigenmarke AS V01;