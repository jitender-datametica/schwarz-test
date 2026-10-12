CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_eigenmarke_ro (mandant_id, eigenmarke_id, spr_id,
eigenmarke_bez) AS SELECT mandant_id,
 eigenmarke_id,
 spr_id,
 eigenmarke_bez
FROM kfl_production_dbp_view.v_artkz_eigenmarke AS V01
WHERE spr_id = 95;