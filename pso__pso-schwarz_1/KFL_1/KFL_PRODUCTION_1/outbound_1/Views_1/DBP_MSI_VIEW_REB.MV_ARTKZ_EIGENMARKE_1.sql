CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_artkz_eigenmarke_1 (mandant_id, eigenmarke_id, eigenmarke_bez)
AS SELECT mandant_id,
 eigenmarke_id,
 eigenmarke_bez
FROM kfl_production_dbp_view.v_artkz_eigenmarke_1
WHERE mandant_id = 1
 AND spr_id = 22;