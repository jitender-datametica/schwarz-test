create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD_AC.V_AGG_PLAN_WH_COUNTRY_KPGES_2(
	CLIENT_ID,
	WH_ID,
	ASPECT_ID,
	INDICATOR_ID,
	BYR,
	CY_MONTH,
	VAL_INDICATOR,
	CURRENCY_ISO_CD,
	CURR_TOT_ID
) as
SELECT
	client_id
	,wh_id
	,aspect_id
	,indicator_id
	,byr
	,cy_month
	,val_indicator
	,currency_iso_cd
	,curr_tot_id
FROM p_lew_mart_lead.V_AGG_PLAN_WH_COUNTRY_KPGES_2
;
