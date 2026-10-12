create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_REF_COUNTRY_DESC(
	COUNTRY_ID,
	LANGUAGE_ID,
	COUNTRY_DESC,
	LOAD_ID
) as
   SELECT
       country_id,
   language_id,
   country_desc,
   load_id
   FROM p_lew_core.t_wawi_ref_country_desc;
