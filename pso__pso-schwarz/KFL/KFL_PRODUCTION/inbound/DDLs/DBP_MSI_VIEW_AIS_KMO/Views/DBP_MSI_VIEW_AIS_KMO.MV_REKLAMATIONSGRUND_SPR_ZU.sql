CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_REKLAMATIONSGRUND_SPR_ZU
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU / ssch1303 01.02.2022
(
 reklamationsgrund_id
,reklamationsgrund_bez
,reklamationsgrund_bez_de
,reklamationsgrund_bez_cz
,reklamationsgrund_bez_sk
,reklamationsgrund_bez_hr
,reklamationsgrund_bez_pl
,reklamationsgrund_bez_ro
,reklamationsgrund_bez_bg
,mandant_id

)
AS

SELECT
 v01.reklamationsgrund_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.reklamationsgrund_bez END), 'N/A') AS reklamationsgrund_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.reklamationsgrund_bez END), 'N/A') AS reklamationsgrund_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.reklamationsgrund_bez END), reklamationsgrund_bez_de) AS reklamationsgrund_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.reklamationsgrund_bez END), reklamationsgrund_bez_de) AS reklamationsgrund_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.reklamationsgrund_bez END), reklamationsgrund_bez_de) AS reklamationsgrund_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.reklamationsgrund_bez END), reklamationsgrund_bez_de) AS reklamationsgrund_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.reklamationsgrund_bez END), reklamationsgrund_bez_de) AS reklamationsgrund_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.reklamationsgrund_bez END), reklamationsgrund_bez_de) AS reklamationsgrund_bez_bg
,v01.mandant_id

FROM dbp_view.v_reklamationsgrund_spr_zu v01

WHERE v01.mandant_id <> 1
GROUP BY
 v01.reklamationsgrund_id
,v01.mandant_id
;