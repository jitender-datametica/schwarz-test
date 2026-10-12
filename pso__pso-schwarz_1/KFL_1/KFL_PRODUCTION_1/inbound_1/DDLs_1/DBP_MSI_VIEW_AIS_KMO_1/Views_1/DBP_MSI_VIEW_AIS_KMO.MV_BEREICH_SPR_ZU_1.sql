CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_BEREICH_SPR_ZU_1
   -- AP0021792 WG Refresh arthiertyp_id auf 10 umgestellt / sschuecke 16.04.2018
   --AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_1 / ssch1303 02.02.2022
(
 ber_id
,ber_bez
,ber_bez_de
,ber_bez_cz
,ber_bez_sk
,ber_bez_hr
,ber_bez_pl
,ber_bez_ro
,ber_bez_bg
,mandant_id
,arthiertyp_id
)

AS
SELECT
 v01.wg_hierarchie_id AS ber_id
,Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v02.wg_hierarchie_bez END),'N/A') AS ber_bez                                                             
,Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v02.wg_hierarchie_bez END),'N/A') AS ber_bez_de                                                     
,Coalesce(Max(CASE WHEN v02.spr_id = 124  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_cz  
,Coalesce(Max(CASE WHEN v02.spr_id = 108  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_sk 
,Coalesce(Max(CASE WHEN v02.spr_id =  65  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_hr    
,Coalesce(Max(CASE WHEN v02.spr_id =  90  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_pl    
,Coalesce(Max(CASE WHEN v02.spr_id =  95  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_ro   
,Coalesce(Max(CASE WHEN v02.spr_id =  18  THEN v02.wg_hierarchie_bez END), ber_bez_de) AS ber_bez_bg  
,v01.mandant_id
,v01.arthiertyp_id
FROM dbp_view.v_wg_hierarchie_zu_per_1 v01
INNER JOIN dbp_view.v_wg_hierarchie_spr_zu_1 v02
ON v02.mandant_id = v01.mandant_id
AND v02.wg_hierarchie_ebene_id = v01.wg_hierarchie_ebene_id
AND v02.wg_hierarchie_id = v01.wg_hierarchie_id
AND v02.arthiertyp_id = v01.arthiertyp_id

WHERE v01.arthiertyp_id = 10
AND v01.wg_hierarchie_ebene_id = 1
AND v01.mandant_id <> 1
AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis
GROUP BY
 v01.wg_hierarchie_id
,v01.mandant_id
,v01.arthiertyp_id;