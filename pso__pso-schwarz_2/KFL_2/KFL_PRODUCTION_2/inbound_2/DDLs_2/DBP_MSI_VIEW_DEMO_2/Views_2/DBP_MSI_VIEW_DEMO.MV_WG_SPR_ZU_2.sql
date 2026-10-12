-- KFL_PRODUCTION_CLONE_DEMO.DBP_MSI_VIEW_DEMO.MV_WG_SPR_ZU_2 source

CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_WG_SPR_ZU_2
AS
SELECT
 v01.arthiertyp_id
,v01.wg_id
,MAX(CASE WHEN spr_id =  22 THEN wg_bez END) AS wg_bez                
,MAX(CASE WHEN spr_id =  22 THEN wg_bez END) AS wg_bez_de                         
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN wg_bez END), wg_bez_de) AS wg_bez_cz    
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN wg_bez END), wg_bez_de) AS wg_bez_sk    
,COALESCE(MAX(CASE WHEN spr_id =  65 THEN wg_bez END), wg_bez_de) AS wg_bez_hr    
,COALESCE(MAX(CASE WHEN spr_id =  90 THEN wg_bez END), wg_bez_de) AS wg_bez_pl    
,COALESCE(MAX(CASE WHEN spr_id =  95 THEN wg_bez END), wg_bez_de) AS wg_bez_ro    
,COALESCE(MAX(CASE WHEN spr_id =  18 THEN wg_bez END), wg_bez_de) AS wg_bez_bg    
FROM dbp_view.v_wg_spr_zu_2 v01
WHERE v01.arthiertyp_id = 2
AND v01.wg_id >= -3
GROUP BY v01.arthiertyp_id
        ,v01.wg_id;

