-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_WUG_SPR_ZU_1 source

CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_WUG_SPR_ZU_1
AS
SELECT
 v01.arthiertyp_id
,v01.wg_id
,v01.wug_id
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.wug_bez END) AS wug_bez                         
,MAX(CASE WHEN v01.spr_id =  22 THEN v01.wug_bez END) AS wug_bez_de                      
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN wug_bez END), wug_bez_de) AS wug_bez_cz    
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN wug_bez END), wug_bez_de) AS wug_bez_sk    
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN wug_bez END), wug_bez_de) AS wug_bez_hr    
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN wug_bez END), wug_bez_de) AS wug_bez_pl    
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN wug_bez END), wug_bez_de) AS wug_bez_ro    
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN wug_bez END), wug_bez_de) AS wug_bez_bg    
FROM dbp_view.v_wug_spr_zu_1 v01
WHERE v01.arthiertyp_id = 2
GROUP BY v01.arthiertyp_id
        ,v01.wg_id
        ,v01.wug_id;

