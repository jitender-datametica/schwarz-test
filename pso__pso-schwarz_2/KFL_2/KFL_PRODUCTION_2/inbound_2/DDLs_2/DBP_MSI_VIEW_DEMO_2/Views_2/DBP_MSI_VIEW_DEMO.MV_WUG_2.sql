-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_WUG_2 source

CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_WUG_2
AS
SELECT DISTINCT
 v01.arthiertyp_id
,v01.wug_id
,v01.wg_id
FROM dbp_view.v_wug_2 v01
WHERE arthiertyp_id = 2;      
