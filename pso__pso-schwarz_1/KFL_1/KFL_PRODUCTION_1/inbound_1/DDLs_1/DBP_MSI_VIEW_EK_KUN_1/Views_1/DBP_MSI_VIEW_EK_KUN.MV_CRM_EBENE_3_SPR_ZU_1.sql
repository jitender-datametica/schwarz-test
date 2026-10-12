create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_EBENE_3_SPR_ZU_1(
	EBENE_3_ID,
	EBENE_3_BEZ,
	EBENE_3_BEZ_CZ,
	EBENE_3_BEZ_PL,
	EBENE_3_BEZ_SK,
	EBENE_3_BEZ_HR,
	EBENE_3_BEZ_RO,
	EBENE_3_BEZ_BG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.ebene_3_id
   ,MAX(CASE WHEN v01.spr_id =  22 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_cz
   ,MAX(CASE WHEN v01.spr_id =  90 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_sk
   ,MAX(CASE WHEN v01.spr_id =  65 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_hr
   ,MAX(CASE WHEN v01.spr_id =  95 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_ro
   ,MAX(CASE WHEN v01.spr_id =  18 THEN v01.ebene_3_bez ELSE NULL END)  AS ebene_3_bez_bg

   FROM DBP_DATA.CRM_THEMENBAUM_LV2_SPR_ZU_1 v01
   GROUP BY v01.ebene_3_id;
