create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_EBENE_1_SPR_ZU_1(
	EBENE_1_ID,
	EBENE_1_BEZ,
	EBENE_1_BEZ_CZ,
	EBENE_1_BEZ_PL,
	EBENE_1_BEZ_SK,
	EBENE_1_BEZ_HR,
	EBENE_1_BEZ_RO,
	EBENE_1_BEZ_BG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.ebene_1_id
   ,MAX(CASE WHEN v01.spr_id =  22 THEN v01.ebene_1_bez ELSE NULL END)  AS ebene_1_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.ebene_1_bez ELSE NULL END)  AS ebene_1_bez_cz
   ,MAX(CASE WHEN v01.spr_id =  90 THEN v01.ebene_1_bez ELSE NULL END)  AS ebene_1_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.ebene_1_bez ELSE NULL END)  AS ebene_1_bez_sk
   ,MAX(CASE WHEN v01.spr_id =  65 THEN v01.ebene_1_bez ELSE NULL END)  AS ebene_1_bez_hr
   ,MAX(CASE WHEN v01.spr_id =  95 THEN v01.ebene_1_bez ELSE NULL END)  AS ebene_1_bez_ro
   ,MAX(CASE WHEN v01.spr_id =  18 THEN v01.ebene_1_bez ELSE NULL END)  AS ebene_1_bez_bg

   FROM DBP_DATA.CRM_THEMENBAUM_LV2_SPR_ZU_1 v01
   GROUP BY v01.ebene_1_id;
