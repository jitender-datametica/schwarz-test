-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_HWG_PER_2 source


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_hwg_per_2 AS SELECT DISTINCT hwg_id,
 abt_id,
 arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per_2 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';