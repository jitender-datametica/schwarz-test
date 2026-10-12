CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_hwg_per AS SELECT DISTINCT mandant_id,
 hwg_id,
 abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';