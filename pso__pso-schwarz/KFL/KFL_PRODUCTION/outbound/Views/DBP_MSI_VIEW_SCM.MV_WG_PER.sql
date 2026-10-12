CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wg_per AS SELECT DISTINCT wg_id,
 arthiertyp_id,
 abt_id,
 owg_id
FROM kfl_production_dbp_view.v_wg_per
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
 AND abt_id <> 0;