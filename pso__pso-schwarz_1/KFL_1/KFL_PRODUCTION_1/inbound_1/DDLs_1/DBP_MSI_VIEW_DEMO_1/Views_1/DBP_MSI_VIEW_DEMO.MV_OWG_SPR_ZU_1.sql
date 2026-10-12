-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_OWG_SPR_ZU_1 source

CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_OWG_SPR_ZU_1
AS
SELECT
 v01.arthiertyp_id
,v01.owg_id
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.owg_bez END) AS owg_bez
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.owg_bez END) AS owg_bez_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_cz    
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_sk    
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_hr    
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_pl    
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_ro    
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.owg_bez END), owg_bez_de) AS owg_bez_bg    
FROM dbp_view.v_owg_spr_zu_1 v01
WHERE v01.arthiertyp_id = 2
GROUP BY v01.arthiertyp_id
         ,v01.owg_id;

