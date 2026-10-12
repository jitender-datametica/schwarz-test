create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_REF_COUNTRY_GROUP(
	COUNTRY_GROUP_ID,
	COUNTRY_GROUP_DESC,
	LOAD_ID
) as
   SELECT
       country_group_id,
   country_group_desc,
   load_id
   FROM p_lew_core.t_wawi_ref_country_group;