create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_COUNTRY_POLITICAL(
	CLIENT_ID,
	COUNTRY_POL_SID,
	SRC_LAND1,
	COUNTRY_POL_NAME,
	CURR_SID,
	LANG_SID,
	CURR_CD,
	LANG_CD,
	ISO_CODE2,
	ISO_CODE3,
	MEMBER_EU_FG,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   country_pol_sid,
   src_land1,
   country_pol_name,
   curr_sid,
   lang_sid,
   curr_cd,
   lang_cd,
   iso_code2,
   iso_code3,
   member_eu_fg,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_country_political
;