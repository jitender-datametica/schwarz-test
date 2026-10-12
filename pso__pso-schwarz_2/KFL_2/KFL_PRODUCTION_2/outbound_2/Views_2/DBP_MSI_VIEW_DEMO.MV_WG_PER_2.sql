-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_WG_PER_2 source


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_demo.mv_wg_per_2 AS SELECT DISTINCT wg_id,
 arthiertyp_id,
 abt_id,
 owg_id
FROM kfl_production_dbp_view.v_wg_per_2 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
 AND abt_id <> 0;