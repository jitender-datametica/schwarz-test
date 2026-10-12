CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artkz_eigenmarke_1 AS SELECT mandant_id,
 eigenmarke_id,
 eigenmarke_bez,
 spr_id
FROM kfl_production_dbp_view.v_artkz_eigenmarke_1 AS V01
WHERE mandant_id <> 1;