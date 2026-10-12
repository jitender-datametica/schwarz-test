create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_BEFRAGUNG_SPR_ZU_1(
	BEFRAGUNG_ID,
	BEFRAGUNG_BEZ,
	BEFRAGUNG_BEZ_CZ,
	BEFRAGUNG_BEZ_PL,
	BEFRAGUNG_BEZ_SK,
	BEFRAGUNG_BEZ_HR,
	BEFRAGUNG_BEZ_RO,
	BEFRAGUNG_BEZ_BG
) as
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

FROM dbp_view.v_mdl_befragung_spr_zu_1 v01

GROUP BY befragung_id;
