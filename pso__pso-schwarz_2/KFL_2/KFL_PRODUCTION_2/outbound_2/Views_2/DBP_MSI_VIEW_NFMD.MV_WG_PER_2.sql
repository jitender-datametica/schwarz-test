CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_wg_per_2 AS SELECT DISTINCT mandant_id,
 wg_id,
 arthiertyp_id,
 abt_id,
 owg_id
FROM kfl_production_dbp_view.v_wg_per_2 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';