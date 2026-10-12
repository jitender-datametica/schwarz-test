create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_TOUCHPOINT_SPR_ZU_2(
	TOUCHPOINT_ID,
	TOUCHPOINT_BEZ,
	TOUCHPOINT_BEZ_CZ,
	TOUCHPOINT_BEZ_PL,
	TOUCHPOINT_BEZ_SK,
	TOUCHPOINT_BEZ_HR,
	TOUCHPOINT_BEZ_RO,
	TOUCHPOINT_BEZ_BG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.touchpoint_id
   ,MAX(CASE WHEN v01.spr_id =  22 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_cz
   ,MAX(CASE WHEN v01.spr_id =  90 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_sk
   ,MAX(CASE WHEN v01.spr_id =  65 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_hr
   ,MAX(CASE WHEN v01.spr_id =  95 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_ro
   ,MAX(CASE WHEN v01.spr_id =  18 THEN v01.touchpoint_bez ELSE NULL END)  AS touchpoint_bez_bg

   FROM DBP_DATA.CRM_TOUCHPOINT_SPR_ZU_2 v01
   GROUP BY v01.touchpoint_id;
