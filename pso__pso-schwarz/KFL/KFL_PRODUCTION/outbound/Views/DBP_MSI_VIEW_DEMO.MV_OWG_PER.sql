-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_OWG_PER source


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_owg_per AS SELECT DISTINCT owg_id,
 arthiertyp_id,
 hwg_id
FROM kfl_production_dbp_view.v_owg_per AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';