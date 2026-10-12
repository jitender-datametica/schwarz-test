CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_wg_int AS SELECT DISTINCT arthiertyp_id,
 wg_id,
 owg_id
FROM kfl_production_dbp_view.v_wg_per AS WG
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';