CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_LAGERORT_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 lagerort_bez
,lagerort_bez_de
,lagerort_bez_cz
,lagerort_bez_sk
,lagerort_bez_hr
,lagerort_bez_pl
,lagerort_bez_ro
,lagerort_bez_bg
,lagerort_id
,mandant_id
,nb_id
,wup_id
)

AS
SELECT
 COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wup_id||' '||v01.lagerort_bez END), 'N/A') AS lagerort_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wup_id||' '||v01.lagerort_bez END), 'N/A') AS lagerort_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.wup_id||' '||v01.lagerort_bez END), lagerort_bez_de) AS lagerort_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.wup_id||' '||v01.lagerort_bez END), lagerort_bez_de) AS lagerort_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.wup_id||' '||v01.lagerort_bez END), lagerort_bez_de) AS lagerort_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.wup_id||' '||v01.lagerort_bez END), lagerort_bez_de) AS lagerort_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.wup_id||' '||v01.lagerort_bez END), lagerort_bez_de) AS lagerort_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.wup_id||' '||v01.lagerort_bez END), lagerort_bez_de) AS lagerort_bez_bg
,v01.lagerort_id
,v01.mandant_id
,v01.nb_id
,v01.wup_id

FROM dbp_view.v_lagerort_spr_zu_2 v01

WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3')

GROUP BY
 v01.lagerort_id
,v01.mandant_id
,v01.nb_id
,v01.wup_id;