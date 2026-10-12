CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_BEZUGSWEG_SPR_ZU_2
--AP0114176/SPEC0139840 Umstellung auf Columnbasiert / ssch1303 24.01.2022
(
 bezugsweg_id
,bezugsweg_bez
,bezugsweg_bez_de
,bezugsweg_bez_cz
,bezugsweg_bez_sk
,bezugsweg_bez_hr
,bezugsweg_bez_pl
,bezugsweg_bez_ro
,bezugsweg_bez_bg
)
AS
SELECT
 v01.bezugsweg_id
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.bezugsweg_bez END), 'N/A') AS bezugsweg_bez
,COALESCE(Max(CASE WHEN v01.spr_id =  22 THEN v01.bezugsweg_bez END), 'N/A') AS bezugsweg_bez_de
,COALESCE(Max(CASE WHEN v01.spr_id = 124 THEN v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_cz
,COALESCE(Max(CASE WHEN v01.spr_id = 108 THEN v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_sk
,COALESCE(Max(CASE WHEN v01.spr_id =  65 THEN v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_hr
,COALESCE(Max(CASE WHEN v01.spr_id =  90 THEN v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_pl
,COALESCE(Max(CASE WHEN v01.spr_id =  95 THEN v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_ro
,COALESCE(Max(CASE WHEN v01.spr_id =  18 THEN v01.bezugsweg_bez END), bezugsweg_bez_de) AS bezugsweg_bez_bg
FROM dbp_view.v_bezugsweg_spr_zu_2 v01
GROUP BY
v01.bezugsweg_id;