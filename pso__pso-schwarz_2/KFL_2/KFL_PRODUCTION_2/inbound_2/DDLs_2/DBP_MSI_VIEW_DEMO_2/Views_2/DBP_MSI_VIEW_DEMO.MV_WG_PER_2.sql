-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_WG_PER_2 source

CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_WG_PER_2
AS
SELECT DISTINCT
 v01.wg_id
,v01.arthiertyp_id
,v01.abt_id
,v01.owg_id
FROM dbp_view.v_wg_per_2 v01
WHERE v01.arthiertyp_id = 2
AND v01.dat_bis = '9999-12-31'
AND v01.abt_id <> 0;

