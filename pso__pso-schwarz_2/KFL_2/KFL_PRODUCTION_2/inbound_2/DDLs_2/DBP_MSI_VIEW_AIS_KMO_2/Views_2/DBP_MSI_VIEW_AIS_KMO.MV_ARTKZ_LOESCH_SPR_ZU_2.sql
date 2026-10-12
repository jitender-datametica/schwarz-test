CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTKZ_LOESCH_SPR_ZU_2
 AS
 SELECT DISTINCT
 mandant_id
,loesch_id
,COALESCE(MAX(CASE WHEN v01.spr_id =  22 THEN v01.loesch_bez END), 'N/A') AS loesch_bez
,COALESCE(MAX(CASE WHEN v01.spr_id =  22 THEN v01.loesch_bez END), 'N/A') AS loesch_bez_de
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.loesch_bez END), loesch_bez_de) AS loesch_bez_cz
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.loesch_bez END), loesch_bez_de) AS loesch_bez_sk
,COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN v01.loesch_bez END), loesch_bez_de) AS loesch_bez_hr
,COALESCE(MAX(CASE WHEN v01.spr_id = 90 THEN v01.loesch_bez END), loesch_bez_de) AS loesch_bez_pl
,COALESCE(MAX(CASE WHEN v01.spr_id = 95 THEN v01.loesch_bez END), loesch_bez_de) AS loesch_bez_ro
,COALESCE(MAX(CASE WHEN v01.spr_id = 18 THEN v01.loesch_bez END), loesch_bez_de) AS loesch_bez_bg
 
FROM (
SELECT DISTINCT
 v02.mandant_id
,v01.loesch_id
,CASE 
 WHEN v01.loesch_bez='system generated' 
 THEN 'ZEK_2 Status_2 aktiv'
 ELSE v01.loesch_bez 
 END AS loesch_bez
,spr_id
FROM dbp_view.v_artkz_loesch_2 v01
CROSS JOIN dbp_view.v_mandant_2 v02
WHERE v01.loesch_id NOT IN ('ZB','ZL','ZR','ZV','01','01','02')
AND v01.mandant_id <> 1
) v01
WHERE v01.mandant_id <> 1
GROUP BY 1,2;