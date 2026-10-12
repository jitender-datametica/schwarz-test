CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_BQ_FINDUNG_SPR_ZU_1
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_1 / ssch1303 02.02.2022
(
 mandant_id
,bq_findung_id
,bq_findung_bez
,bq_findung_bez_de
,bq_findung_bez_cz
,bq_findung_bez_sk
,bq_findung_bez_hr
,bq_findung_bez_pl
,bq_findung_bez_ro
,bq_findung_bez_bg
,bq_findung_id_bez
,bq_findung_id_bez_de
,bq_findung_id_bez_cz
,bq_findung_id_bez_sk
,bq_findung_id_bez_hr
,bq_findung_id_bez_pl
,bq_findung_id_bez_ro
,bq_findung_id_bez_bg
)

AS
SELECT
 v01.mandant_id
,v01.bq_findung_id
,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.bq_findung_bez END),'N/A') AS bq_findung_bez                                                             
,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.bq_findung_bez END),'N/A') AS bq_findung_bez_de                                                     
,Coalesce(Max(CASE WHEN v01.spr_id = 124  THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_cz  
,Coalesce(Max(CASE WHEN v01.spr_id = 108  THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_sk 
,Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_hr    
,Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_pl    
,Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_ro 
,Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.bq_findung_bez END), bq_findung_bez_de) AS bq_findung_bez_bg  
,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.bq_findung_id || ' ' || v01.bq_findung_bez END),'N/A') AS bq_findung_id_bez                                                             
,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.bq_findung_id || ' ' || v01.bq_findung_bez END),'N/A') bq_findung_id_bez_de                                                     
,Coalesce(Max(CASE WHEN v01.spr_id = 124  THEN v01.bq_findung_id || ' ' || v01.bq_findung_bez END), bq_findung_id_bez_de) AS bq_findung_id_bez_cz  
,Coalesce(Max(CASE WHEN v01.spr_id = 108  THEN v01.bq_findung_id || ' ' || v01.bq_findung_bez END), bq_findung_id_bez_de) AS bq_findung_id_bez_sk 
,Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.bq_findung_id || ' ' || v01.bq_findung_bez END), bq_findung_id_bez_de) AS bq_findung_id_bez_hr    
,Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.bq_findung_id || ' ' || v01.bq_findung_bez END), bq_findung_id_bez_de) AS bq_findung_id_bez_pl    
,Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.bq_findung_id || ' ' || v01.bq_findung_bez END), bq_findung_id_bez_de) AS bq_findung_id_bez_ro 
,Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.bq_findung_id || ' ' || v01.bq_findung_bez END), bq_findung_id_bez_de) AS bq_findung_id_bez_bg  

FROM dbp_view.v_bq_findung_spr_zu_1 v01

GROUP BY
 v01.mandant_id
,v01.bq_findung_id
;