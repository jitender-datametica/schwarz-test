create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_FREMDKOERPER_FG_SPR_ZU(
	FREMDKOERPER_FG,
	FREMDKOERPER_FG_BEZ,
	FREMDKOERPER_FG_BEZ_CZ,
	FREMDKOERPER_FG_BEZ_PL,
	FREMDKOERPER_FG_BEZ_SK,
	FREMDKOERPER_FG_BEZ_HR,
	FREMDKOERPER_FG_BEZ_RO,
	FREMDKOERPER_FG_BEZ_BG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.flag AS fremdkoerper_fg
   ,MAX(CASE WHEN v01.spr_id =  22 THEN v01.flag_bez ELSE NULL END)  AS fremdkoerper_fg_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.flag_bez ELSE NULL END)  AS fremdkoerper_fg_bez_cz
   ,MAX(CASE WHEN v01.spr_id =  90 THEN v01.flag_bez ELSE NULL END)  AS fremdkoerper_fg_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.flag_bez ELSE NULL END)  AS fremdkoerper_fg_bez_sk
   ,MAX(CASE WHEN v01.spr_id =  65 THEN v01.flag_bez ELSE NULL END)  AS fremdkoerper_fg_bez_hr
   ,MAX(CASE WHEN v01.spr_id =  95 THEN v01.flag_bez ELSE NULL END)  AS fremdkoerper_fg_bez_ro
   ,MAX(CASE WHEN v01.spr_id =  18 THEN v01.flag_bez ELSE NULL END)  AS fremdkoerper_fg_bez_bg

   FROM DBP_DATA.FLAG_SPR_ZU v01
   WHERE flag_typ_id = 1 --Ja/Nein
   GROUP BY v01.flag;
