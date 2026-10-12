create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_ORG_CLIENT_SKEY_1(
	CLIENT_ID,
	COUNTRY_GROUP_ID,
	LOAD_ID
) as
   SELECT
   client_id,
   country_group_id,
   load_id
   FROM p_lew_core.t_wawi_org_client_skey_1;
