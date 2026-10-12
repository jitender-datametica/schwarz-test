create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_EMOTION_SPR_ZU_2(
	CRM_EMOTION_ID,
	EMOTION_BEZ,
	EMOTION_BEZ_CZ,
	EMOTION_BEZ_PL,
	EMOTION_BEZ_SK,
	EMOTION_BEZ_HR,
	EMOTION_BEZ_RO,
	EMOTION_BEZ_BG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.crm_emotion_id
   ,MAX(CASE WHEN v01.spr_id =   22 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 THEN v01.emotion_bez ELSE NULL END)  AS emotion_bez_bg
   FROM DBP_DATA.CRM_EMOTION_SPR_ZU_2 v01
   GROUP BY v01.crm_emotion_id;
