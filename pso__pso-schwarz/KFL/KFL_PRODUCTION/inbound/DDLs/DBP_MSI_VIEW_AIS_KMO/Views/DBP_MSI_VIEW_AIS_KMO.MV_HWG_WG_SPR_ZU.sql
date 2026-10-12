CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_HWG_WG_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 01.02.2022
(
 hwg_id
,hwg_bez
,hwg_bez_de
,hwg_bez_cz
,hwg_bez_sk
,hwg_bez_hr
,hwg_bez_pl
,hwg_bez_ro
,hwg_bez_bg
,owg_id
,owg_bez
,owg_bez_de
,owg_bez_cz
,owg_bez_sk
,owg_bez_hr
,owg_bez_pl
,owg_bez_ro
,owg_bez_bg
,wg_id
,wg_bez
,wg_bez_de
,wg_bez_cz
,wg_bez_sk
,wg_bez_hr
,wg_bez_pl
,wg_bez_ro
,wg_bez_bg
,mandant_id
,arthiertyp_id
)
AS

SELECT
 v01.hwg_id
,COALESCE(Max(CASE WHEN v02.spr_id =  22 THEN v02.hwg_bez END), 'N/A') AS hwg_bez
,COALESCE(Max(CASE WHEN v02.spr_id =  22 THEN v02.hwg_bez END), 'N/A') AS hwg_bez_de
,COALESCE(Max(CASE WHEN v02.spr_id = 124 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_cz
,COALESCE(Max(CASE WHEN v02.spr_id = 108 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_sk
,COALESCE(Max(CASE WHEN v02.spr_id =  65 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_hr
,COALESCE(Max(CASE WHEN v02.spr_id =  90 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_pl
,COALESCE(Max(CASE WHEN v02.spr_id =  95 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_ro
,COALESCE(Max(CASE WHEN v02.spr_id =  18 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_bg
,v03.owg_id
,COALESCE(Max(CASE WHEN v04.spr_id =  22 THEN v04.owg_bez END), 'N/A') AS owg_bez
,COALESCE(Max(CASE WHEN v04.spr_id =  22 THEN v04.owg_bez END), 'N/A') AS owg_bez_de
,COALESCE(Max(CASE WHEN v04.spr_id = 124 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_cz
,COALESCE(Max(CASE WHEN v04.spr_id = 108 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_sk
,COALESCE(Max(CASE WHEN v04.spr_id =  65 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_hr
,COALESCE(Max(CASE WHEN v04.spr_id =  90 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_pl
,COALESCE(Max(CASE WHEN v04.spr_id =  95 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_ro
,COALESCE(Max(CASE WHEN v04.spr_id =  18 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_bg
,v05.wg_id
,COALESCE(Max(CASE WHEN v06.spr_id =  22 THEN v06.wg_bez END), 'N/A') AS wg_bez
,COALESCE(Max(CASE WHEN v06.spr_id =  22 THEN v06.wg_bez END), 'N/A') AS wg_bez_de
,COALESCE(Max(CASE WHEN v06.spr_id = 124 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_cz
,COALESCE(Max(CASE WHEN v06.spr_id = 108 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_sk
,COALESCE(Max(CASE WHEN v06.spr_id =  65 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_hr
,COALESCE(Max(CASE WHEN v06.spr_id =  90 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_pl
,COALESCE(Max(CASE WHEN v06.spr_id =  95 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_ro
,COALESCE(Max(CASE WHEN v06.spr_id =  18 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_bg
,v01.mandant_id
,v01.arthiertyp_id

FROM
dbp_view.v_hwg_per v01
JOIN dbp_view.v_hwg_spr_zu v02
ON v02.mandant_id = v01.mandant_id
AND v02.hwg_id = v01.hwg_id
JOIN dbp_view.v_owg_per v03
ON v03.mandant_id = v01.mandant_id
AND v03.hwg_id = v01.hwg_id
JOIN dbp_view.v_owg_spr_zu v04
ON v04.mandant_id = v03.mandant_id
AND v04.owg_id = v03.owg_id
JOIN dbp_view.v_wg_per v05
ON v05.mandant_id = v03.mandant_id
AND v05.owg_id = v03.owg_id
JOIN dbp_view.v_wg_spr_zu v06
ON v06.mandant_id = v05.mandant_id
AND v06.wg_id = v05.wg_id

WHERE v01.mandant_id <> 1
AND v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31'

GROUP BY
 v01.hwg_id
,v03.owg_id
,v05.wg_id
,v01.mandant_id
,v01.arthiertyp_id
;