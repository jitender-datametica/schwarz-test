CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_LAYOUT_SPR_ZU_2
--2019-10-30 ssch0611 - update in data model
--2022-01-13 snik1809 - updated due to malfunction in SF
AS

SELECT DISTINCT
layout_kz
,Max(CASE WHEN spr_id = 22 THEN layout_bez END) AS layout_bez
,Max(CASE WHEN spr_id = 124 THEN layout_bez END) AS layout_bez_cz
,Max(CASE WHEN spr_id = 108 THEN layout_bez END) AS layout_bez_sk
,Max(CASE WHEN spr_id = 65 THEN layout_bez END) AS layout_bez_hr
,Max(CASE WHEN spr_id = 90 THEN layout_bez END) AS layout_bez_pl
,Max(CASE WHEN spr_id = 95 THEN layout_bez END) AS layout_bez_ro
,Max(CASE WHEN spr_id = 18 THEN layout_bez END) AS layout_bez_bg
,Max(CASE WHEN spr_id = 22 THEN layout_bez END) AS layout_bez_de

FROM dbp_view.v_eps_layout_spr_zu_2

GROUP BY layout_kz ;