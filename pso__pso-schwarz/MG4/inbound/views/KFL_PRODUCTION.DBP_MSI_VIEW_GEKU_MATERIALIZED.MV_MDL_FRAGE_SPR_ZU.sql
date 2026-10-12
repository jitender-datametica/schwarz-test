create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_FRAGE_SPR_ZU(
	FRAGE_ID,
	FRAGE_BEZ,
	FRAGE_BEZ_CZ,
	FRAGE_BEZ_PL,
	FRAGE_BEZ_SK,
	FRAGE_BEZ_HR,
	FRAGE_BEZ_RO,
	FRAGE_BEZ_BG
) as
-- 21.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 
-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify issue with data

SELECT 

  frage_id
 ,MAX(CASE WHEN spr_id =   22 THEN frage_bez ELSE NULL END)  AS frage_bez   --standard=deutsch
 ,MAX(CASE WHEN spr_id = 124 THEN frage_bez ELSE NULL END)  AS frage_bez_cz
 ,MAX(CASE WHEN spr_id =   90 THEN frage_bez ELSE NULL END)  AS frage_bez_pl
 ,MAX(CASE WHEN spr_id = 108 THEN frage_bez ELSE NULL END)  AS frage_bez_sk
 ,MAX(CASE WHEN spr_id =   65 THEN frage_bez ELSE NULL END)  AS frage_bez_hr
 ,MAX(CASE WHEN spr_id =   95 THEN frage_bez ELSE NULL END)  AS frage_bez_ro
 ,MAX(CASE WHEN spr_id =   18 THEN frage_bez ELSE NULL END)  AS frage_bez_bg

FROM dbp_view.v_mdl_frage_spr_zu v01

GROUP BY frage_id;