create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_ANTWORT_SPR_ZU_1(
	FRAGE_ID,
	ANTWORT_ID,
	ANTWORT_BEZ,
	ANTWORT_BEZ_CZ,
	ANTWORT_BEZ_PL,
	ANTWORT_BEZ_SK,
	ANTWORT_BEZ_HR,
	ANTWORT_BEZ_RO,
	ANTWORT_BEZ_BG
) as
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 
-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify the view issue with the data

SELECT 
  frage_id
 ,antwort_id
 ,MAX(CASE WHEN spr_id =   22 THEN antwort_bez ELSE NULL END)  AS antwort_bez   --standard=deutsch
 ,MAX(CASE WHEN spr_id = 124 THEN antwort_bez ELSE NULL END)  AS antwort_bez_cz
 ,MAX(CASE WHEN spr_id =   90 THEN antwort_bez ELSE NULL END)  AS antwort_bez_pl
 ,MAX(CASE WHEN spr_id = 108 THEN antwort_bez ELSE NULL END)  AS antwort_bez_sk
 ,MAX(CASE WHEN spr_id =   65 THEN antwort_bez ELSE NULL END)  AS antwort_bez_hr
 ,MAX(CASE WHEN spr_id =   95 THEN antwort_bez ELSE NULL END)  AS antwort_bez_ro
 ,MAX(CASE WHEN spr_id =   18 THEN antwort_bez ELSE NULL END)  AS antwort_bez_bg

FROM dbp_view.v_mdl_antwort_spr_zu_1

GROUP BY antwort_id, frage_id;
