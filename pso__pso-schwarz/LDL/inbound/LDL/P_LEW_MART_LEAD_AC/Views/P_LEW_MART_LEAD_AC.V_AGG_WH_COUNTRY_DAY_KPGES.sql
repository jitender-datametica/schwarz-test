create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD_AC.V_AGG_WH_COUNTRY_DAY_KPGES(
	CLIENT_ID,
	WH_ID,
	INDICATOR_ID,
	DAT_FORMDATE,
	CY_WEEK,
	CY_MONTH,
	BYR,
	VAL_INDICATOR,
	CURRENCY_ISO_CD,
	CURR_TOT_ID
) as
SELECT
     client_id
    ,wh_id
    ,indicator_id
    ,dat_formdate
    ,cy_week
    ,cy_month
    ,byr
    ,val_indicator
    ,currency_iso_cd
    ,curr_tot_id
FROM P_LEW_MART_LEAD.V_AGG_WH_COUNTRY_DAY_KPGES
;
