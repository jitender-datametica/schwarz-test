create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_REF_CLIENT_COUNTRY(
	CLIENT_ID,
	COUNTRY_ID,
	LOAD_ID
) as
   SELECT
       client_id,
   country_id,
   load_id
   FROM p_lew_core.t_wawi_ref_client_country;
