create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_STANDARDLOESUNG_FG_SPR_ZU_1(
	STANDARDLOESUNG_FG,
	STANDARDLOESUNG_FG_BEZ,
	STANDARDLOESUNG_FG_BEZ_CZ,
	STANDARDLOESUNG_FG_BEZ_PL,
	STANDARDLOESUNG_FG_BEZ_SK,
	STANDARDLOESUNG_FG_BEZ_HR,
	STANDARDLOESUNG_FG_BEZ_RO,
	STANDARDLOESUNG_FG_BEZ_BG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.flag AS standardloesung_fg
   ,MAX(CASE WHEN v01.spr_id =  22 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_cz
   ,MAX(CASE WHEN v01.spr_id =  90 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_sk
   ,MAX(CASE WHEN v01.spr_id =  65 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_hr
   ,MAX(CASE WHEN v01.spr_id =  95 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_ro
   ,MAX(CASE WHEN v01.spr_id =  18 THEN v01.flag_bez ELSE NULL END)  AS standardloesung_fg_bez_bg

   FROM DBP_DATA.FLAG_SPR_ZU_1 v01
   WHERE flag_typ_id = 1 --Ja/Nein
   GROUP BY v01.flag;
