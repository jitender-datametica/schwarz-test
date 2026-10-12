create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_WH_COUNTRY_DAY_KPGES_1(
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
     kpges.client_id
    ,kpges.wh_id
    ,kpges.indicator_id
    ,kpges.dat_formdate
    ,dcd.cy_week
    ,dcd.cy_month
    ,dcd.bus_year AS byr
    ,kpges.val_indicator
    ,kpges.currency_iso_cd
    ,cur.curr_tot_id
FROM P_LEW_MART_MSI.V_KPGES_DAY_WH_MERGE_1 kpges
INNER JOIN p_lew_bil_ac.v_dim_cal_day_1 dcd
ON kpges.dat_formdate = dcd.cal_dt
INNER JOIN p_lew_mart_lead.v_ref_currency_1 cur
ON cur.client_id = kpges.client_id
AND cur.currency_iso_cd = kpges.currency_iso_cd
    UNION
SELECT
     kpges.client_id
    ,-1*kpges.client_id AS wh_id
    ,kpges.indicator_id
    ,kpges.dat_formdate
    ,dcd.cy_week
    ,dcd.cy_month
    ,dcd.bus_year AS byr
    ,kpges.val_indicator
    ,kpges.currency_iso_cd
    ,cur.curr_tot_id
FROM P_LEW_MART_MSI.V_KPGES_DAY_COUNTRY_1 kpges
INNER JOIN p_lew_bil_ac.v_dim_cal_day_1 dcd
ON kpges.dat_formdate = dcd.cal_dt
INNER JOIN p_lew_mart_lead.v_ref_currency_1 cur
ON cur.client_id = kpges.client_id
AND cur.currency_iso_cd = kpges.currency_iso_cd
WHERE kpges.val_indicator <> 0
;
