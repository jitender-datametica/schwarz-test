create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_ART_SPR_ZU(
	ART_ID,
	MANDANT_ID,
	ART_BEZ,
	ART_BEZ_CZ,
	ART_BEZ_PL,
	ART_BEZ_SK,
	ART_BEZ_HR,
	ART_BEZ_RO,
	ART_BEZ_BG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
   v01.art_id
   ,mandant_id
   ,MAX(CASE WHEN v01.spr_id =   22 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124  AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108  AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 AND v01.art_id <> 0 THEN v01.art_bez ELSE NULL END)  AS art_bez_bg

   FROM DBP_DATA.ART_SPR_ZU v01
   GROUP BY v01.art_id, mandant_id;
