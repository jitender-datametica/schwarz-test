CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_owg_per_2 AS SELECT DISTINCT mandant_id,
 owg_id,
 arthiertyp_id,
 hwg_id
FROM kfl_production_dbp_view.v_owg_per_2
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';