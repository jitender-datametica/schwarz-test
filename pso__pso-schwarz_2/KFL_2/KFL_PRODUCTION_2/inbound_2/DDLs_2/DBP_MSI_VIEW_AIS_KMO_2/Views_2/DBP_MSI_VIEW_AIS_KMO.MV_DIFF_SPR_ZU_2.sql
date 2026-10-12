CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_DIFF_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 02.02.2022
(
 mandant_id
,diff_id
,diff_bez
,diff_bez_de
,diff_bez_cz
,diff_bez_sk
,diff_bez_hr
,diff_bez_pl
,diff_bez_ro
,diff_bez_bg

)

AS
SELECT
 v01.mandant_id
,v01.diff_id
,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.diff_bez END),'N/A') AS diff_bez                                                             
,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.diff_bez END),'N/A') diff_bez_de                                                     
,Coalesce(Max(CASE WHEN v01.spr_id = 124  THEN v01.diff_bez END), diff_bez_de) AS diff_bez_cz  
,Coalesce(Max(CASE WHEN v01.spr_id = 108  THEN v01.diff_bez END), diff_bez_de) AS diff_bez_sk 
,Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.diff_bez END), diff_bez_de) AS diff_bez_hr    
,Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.diff_bez END), diff_bez_de) AS diff_bez_pl    
,Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.diff_bez END), diff_bez_de) AS diff_bez_ro 
,Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.diff_bez END), diff_bez_de) AS diff_bez_bg  

FROM dbp_view.v_diff_spr_zu_2 v01
WHERE v01.mandant_id <> 1

GROUP BY
 v01.mandant_id
,v01.diff_id
;