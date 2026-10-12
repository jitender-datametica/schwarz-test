create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_KATEGORIE_SPR_ZU_1(
	KATEGORIE_ID,
	KATEGORIE_BEZ,
	KATEGORIE_BEZ_CZ,
	KATEGORIE_BEZ_PL,
	KATEGORIE_BEZ_SK,
	KATEGORIE_BEZ_HR,
	KATEGORIE_BEZ_RO,
	KATEGORIE_BEZ_BG
) as
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

FROM dbp_view.v_mdl_kategorie_spr_zu_1 v01

GROUP BY kategorie_id;
