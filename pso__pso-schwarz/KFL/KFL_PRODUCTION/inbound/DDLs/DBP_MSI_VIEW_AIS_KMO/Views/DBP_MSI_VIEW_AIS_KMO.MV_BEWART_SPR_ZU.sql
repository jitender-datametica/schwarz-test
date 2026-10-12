CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_BEWART_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 02.02.2022
(
 bewart_id
,bewart_bez
,bewart_bez_de
,bewart_bez_cz
,bewart_bez_sk
,bewart_bez_hr
,bewart_bez_pl
,bewart_bez_ro
,bewart_bez_bg
,mandant_id
)

AS
SELECT
 v01.bewart_id
,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.bewart_bez END),'N/A') AS bewart_bez                                                             
,Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.bewart_bez END),'N/A') AS bewart_bez_de                                                     
,Coalesce(Max(CASE WHEN v01.spr_id = 124  THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_cz  
,Coalesce(Max(CASE WHEN v01.spr_id = 108  THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_sk 
,Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_hr    
,Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_pl    
,Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_ro 
,Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.bewart_bez END), bewart_bez_de) AS bewart_bez_bg  
,v01.mandant_id

FROM dbp_view.v_bewart_spr_zu v01

WHERE mandant_id <> 1
GROUP BY
 v01.bewart_id
,v01.mandant_id
;