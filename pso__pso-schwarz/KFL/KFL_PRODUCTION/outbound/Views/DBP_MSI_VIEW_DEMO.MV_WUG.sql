-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_WUG source


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_wug AS SELECT DISTINCT arthiertyp_id,
 wug_id,
 wg_id
FROM kfl_production_dbp_view.v_wug AS V01
WHERE arthiertyp_id = 2;