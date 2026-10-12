create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MCX_ZEITSPANNE_SPR_ZU_1(
	ZEITSPANNE_ID,
	ZEITSPANNE_BEZ,
	ZEITSPANNE_BEZ_CZ,
	ZEITSPANNE_BEZ_PL,
	ZEITSPANNE_BEZ_SK,
	ZEITSPANNE_BEZ_HR,
	ZEITSPANNE_BEZ_RO,
	ZEITSPANNE_BEZ_BG
) as
--lsvi0303: AP0043627, SPEC0055162 Atributt Einkaufszeit

SELECT 

  zeitspanne_id
 ,MAX(CASE WHEN spr_id =   22 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez   --standard=deutsch
 ,MAX(CASE WHEN spr_id = 124 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_cz
 ,MAX(CASE WHEN spr_id =   90 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_pl
 ,MAX(CASE WHEN spr_id = 108 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_sk
 ,MAX(CASE WHEN spr_id =   65 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_hr
 ,MAX(CASE WHEN spr_id =   95 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_ro
 ,MAX(CASE WHEN spr_id =   18 THEN zeitspanne_bez ELSE NULL END)  AS zeitspanne_bez_bg

FROM dbp_view.v_mcx_zeitspanne_spr_zu_1

GROUP BY zeitspanne_id;