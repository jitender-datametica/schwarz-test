CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WTAG_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert, Entfall Join AKT_MSI_USER_SPR_ZU_2 / ssch1303 01.02.2022
(
 wtag_id
,wtag_bez
,wtag_bez_de
,wtag_bez_cz
,wtag_bez_sk
,wtag_bez_hr
,wtag_bez_pl
,wtag_bez_ro
,wtag_bez_bg
)

AS
SELECT
 v01.wtag_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wtag_bez END), 'N/A') AS wtag_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.wtag_bez END), 'N/A') AS wtag_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.wtag_bez END), wtag_bez_de) AS wtag_bez_bg
FROM dbp_view.v_wtag_spr_zu_2 v01
GROUP BY
 v01.wtag_id
;