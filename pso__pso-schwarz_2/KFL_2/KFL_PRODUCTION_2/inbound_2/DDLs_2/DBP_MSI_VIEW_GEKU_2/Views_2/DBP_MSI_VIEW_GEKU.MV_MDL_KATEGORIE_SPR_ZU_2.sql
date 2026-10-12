CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_KATEGORIE_SPR_ZU_2
(
 kategorie_id
,kategorie_bez
,kategorie_bez_cz
,kategorie_bez_pl
,kategorie_bez_sk
,kategorie_bez_hr
,kategorie_bez_ro
,kategorie_bez_bg
)
AS
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 
-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify the view because of the issues

SELECT 

  kategorie_id
 ,MAX(CASE WHEN spr_id =   22 THEN kategorie_bez ELSE NULL END)  AS kategorie_bez   --standard=deutsch
 ,MAX(CASE WHEN spr_id = 124 THEN kategorie_bez ELSE NULL END)  AS kategorie_bez_cz
 ,MAX(CASE WHEN spr_id =   90 THEN kategorie_bez ELSE NULL END)  AS kategorie_bez_pl
 ,MAX(CASE WHEN spr_id = 108 THEN kategorie_bez ELSE NULL END)  AS kategorie_bez_sk
 ,MAX(CASE WHEN spr_id =   65 THEN kategorie_bez ELSE NULL END)  AS kategorie_bez_hr
 ,MAX(CASE WHEN spr_id =   95 THEN kategorie_bez ELSE NULL END)  AS kategorie_bez_ro
 ,MAX(CASE WHEN spr_id =   18 THEN kategorie_bez ELSE NULL END)  AS kategorie_bez_bg

FROM dbp_view.v_mdl_kategorie_spr_zu_2 v01

GROUP BY kategorie_id;