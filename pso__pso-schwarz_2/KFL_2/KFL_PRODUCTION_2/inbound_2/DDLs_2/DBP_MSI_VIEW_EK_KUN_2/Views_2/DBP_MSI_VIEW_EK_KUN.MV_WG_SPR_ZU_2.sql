create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_WG_SPR_ZU_2(
	WG_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	WG_BEZ,
	WG_BEZ_CZ,
	WG_BEZ_PL,
	WG_BEZ_SK,
	WG_BEZ_HR,
	WG_BEZ_RO,
	WG_BEZ_BG
) as
  SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.wg_id
   ,v01.arthiertyp_id
   ,v01.mandant_id
   ,MAX(CASE WHEN v01.spr_id =   22 THEN v01.wg_bez ELSE NULL END)  AS wg_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id =  124 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_pl
   ,MAX(CASE WHEN v01.spr_id =  108 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 THEN v01.wg_bez ELSE NULL END)  AS wg_bez_bg

FROM DBP_DATA.WG_SPR_ZU_2 v01
WHERE v01.arthiertyp_id = 2
AND v01.wg_id >= -3

GROUP BY 
 v01.wg_id
,v01.arthiertyp_id
,v01.mandant_id;
