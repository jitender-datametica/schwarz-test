create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_ZEITSPANNE_EINKAUF_SPR_ZU_1(
	ZEITSPANNE_EINKAUF_ID,
	ZEITSPANNE_EINKAUF_BEZ,
	ZEITSPANNE_EINKAUF_BEZ_CZ,
	ZEITSPANNE_EINKAUF_BEZ_PL,
	ZEITSPANNE_EINKAUF_BEZ_SK,
	ZEITSPANNE_EINKAUF_BEZ_HR,
	ZEITSPANNE_EINKAUF_BEZ_RO,
	ZEITSPANNE_EINKAUF_BEZ_BG
) as
-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 
-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify issue with data

SELECT 

  zeitspanne_einkauf_id
 ,MAX(CASE WHEN spr_id =   22 THEN zeitspanne_einkauf_bez ELSE NULL END)  AS zeitspanne_einkauf_bez   --standard=deutsch
 ,MAX(CASE WHEN spr_id = 124 THEN zeitspanne_einkauf_bez ELSE NULL END)  AS zeitspanne_einkauf_bez_cz
 ,MAX(CASE WHEN spr_id =   90 THEN zeitspanne_einkauf_bez ELSE NULL END)  AS zeitspanne_einkauf_bez_pl
 ,MAX(CASE WHEN spr_id = 108 THEN zeitspanne_einkauf_bez ELSE NULL END)  AS zeitspanne_einkauf_bez_sk
 ,MAX(CASE WHEN spr_id =   65 THEN zeitspanne_einkauf_bez ELSE NULL END)  AS zeitspanne_einkauf_bez_hr
 ,MAX(CASE WHEN spr_id =   95 THEN zeitspanne_einkauf_bez ELSE NULL END)  AS zeitspanne_einkauf_bez_ro
 ,MAX(CASE WHEN spr_id =   18 THEN zeitspanne_einkauf_bez ELSE NULL END)  AS zeitspanne_einkauf_bez_bg

FROM dbp_view.v_mdl_zeitspanne_einkauf_spr_zu_1 v01

GROUP BY v01.zeitspanne_einkauf_id;