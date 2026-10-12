-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_OWG_PER_1 source

CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_OWG_PER_1
AS
SELECT DISTINCT
 v01.owg_id
,v01.arthiertyp_id
,v01.hwg_id
FROM dbp_view.v_owg_per_1 v01
WHERE v01.arthiertyp_id = 2
AND v01.dat_bis = '9999-12-31';


