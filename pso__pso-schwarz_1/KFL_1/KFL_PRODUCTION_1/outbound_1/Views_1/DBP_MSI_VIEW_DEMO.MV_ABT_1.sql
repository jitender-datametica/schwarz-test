-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_ABT_1 source


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_abt_1 AS SELECT DISTINCT abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_abt_1 AS V01
WHERE arthiertyp_id = 2;