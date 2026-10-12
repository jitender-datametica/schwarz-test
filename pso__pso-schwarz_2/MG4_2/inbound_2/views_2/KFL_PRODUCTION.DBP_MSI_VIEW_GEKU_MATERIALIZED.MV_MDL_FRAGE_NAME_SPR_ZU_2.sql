create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_FRAGE_NAME_SPR_ZU_2(
	FRAGE_ID,
	FRAGE_NAME_BEZ,
	FRAGE_NAME_BEZ_CZ,
	FRAGE_NAME_BEZ_PL,
	FRAGE_NAME_BEZ_SK,
	FRAGE_NAME_BEZ_HR,
	FRAGE_NAME_BEZ_RO,
	FRAGE_NAME_BEZ_BG
) as
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 
-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify issue with data

SELECT 

  frage_id
 ,MAX(CASE WHEN spr_id =   22 THEN frage_name_bez ELSE NULL END)  AS frage_name_bez   --standard=deutsch
 ,MAX(CASE WHEN spr_id = 124 THEN frage_name_bez ELSE NULL END)  AS frage_name_bez_cz
 ,MAX(CASE WHEN spr_id =   90 THEN frage_name_bez ELSE NULL END)  AS frage_name_bez_pl
 ,MAX(CASE WHEN spr_id = 108 THEN frage_name_bez ELSE NULL END)  AS frage_name_bez_sk
 ,MAX(CASE WHEN spr_id =   65 THEN frage_name_bez ELSE NULL END)  AS frage_name_bez_hr
 ,MAX(CASE WHEN spr_id =   95 THEN frage_name_bez ELSE NULL END)  AS frage_name_bez_ro
 ,MAX(CASE WHEN spr_id =   18 THEN frage_name_bez ELSE NULL END)  AS frage_name_bez_bg

FROM dbp_view.v_mdl_frage_name_spr_zu_2 v01

GROUP BY frage_id;