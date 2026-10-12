create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_COUNTRY_POLITICAL_DESCR_2(
	CLIENT_ID,
	COUNTRY_POL_SID,
	LANG_SID,
	LANG_CD,
	COUNTRY_POL_DESCR,
	NATIONALITY,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   country_pol_sid,
   lang_sid,
   lang_cd,
   country_pol_descr,
   nationality,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_country_political_descr_2
;