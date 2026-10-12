CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_BEFRAGUNG_SPR_ZU_2
(
 befragung_id
,befragung_bez
,befragung_bez_cz
,befragung_bez_pl
,befragung_bez_sk
,befragung_bez_hr
,befragung_bez_ro
,befragung_bez_bg
)
AS
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 
-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify issue with data

SELECT 

  befragung_id
 ,MAX(CASE WHEN spr_id =   22 THEN befragung_bez ELSE NULL END)  AS befragung_bez   --standard=deutsch
 ,MAX(CASE WHEN spr_id = 124 THEN befragung_bez ELSE NULL END)  AS befragung_bez_cz
 ,MAX(CASE WHEN spr_id =   90 THEN befragung_bez ELSE NULL END)  AS befragung_bez_pl
 ,MAX(CASE WHEN spr_id = 108 THEN befragung_bez ELSE NULL END)  AS befragung_bez_sk
 ,MAX(CASE WHEN spr_id =   65 THEN befragung_bez ELSE NULL END)  AS befragung_bez_hr
 ,MAX(CASE WHEN spr_id =   95 THEN befragung_bez ELSE NULL END)  AS befragung_bez_ro
 ,MAX(CASE WHEN spr_id =   18 THEN befragung_bez ELSE NULL END)  AS befragung_bez_bg

FROM dbp_view.v_mdl_befragung_spr_zu_2 v01

GROUP BY befragung_id;