create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_REF_COUNTRY_ACT_2(
	INT_ID,
	COUNTRY_ID,
	COUNTRY_ISO_CD,
	CLUSTER_ID,
	SORTING_ORDER,
	COUNTRY_DESC,
	LANGUAGE_ID,
	DASHBOARD_RELEVANT_FG
) as
   SELECT
   int_id,
   country_id,
   country_iso_cd,
   cluster_id,
   sorting_order,
   country_desc,
   language_id,
   dashboard_relevant_fg
   FROM p_lew_core.t_wawi_ref_country_act_2;
