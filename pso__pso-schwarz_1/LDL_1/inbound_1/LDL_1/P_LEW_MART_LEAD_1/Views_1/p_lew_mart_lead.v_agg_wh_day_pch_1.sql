create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_WH_DAY_PCH_1(
	CLIENT_ID,
	LOC_SID_WH,
	WH_ID,
	ASPECT_ID,
	PCWO_REASON_ID,
	SFOTYPE_ID,
	PCH_BNL_SWITCH_FG,
	CURRENCY_ISO_CD,
	DWH_CAL_DT,
	VAL_PRICE_CHANGE
) as
SELECT
  v.client_id
, v.loc_sid_wh
, v.wh_id
, v.aspect_id
, v.pcwo_reason_id
, v.sfotype_id
, v.pch_bnl_switch_fg
, v.currency_iso_cd
, v.dwh_cal_dt
, v.val_price_change
FROM p_lew_mart_lead.t_agg_wh_day_pch_1 AS v
UNION ALL
SELECT
  client_id
, loc_sid_wh
, wh_id
, aspect_id
, 41 AS pcwo_reason_id
, 134 AS sfotype_id
, 1 AS pch_bnl_switch_fg
, currency_iso_cd
, dwh_cal_dt
, discount_val_net*-1
FROM P_LEW_MART_LEAD.T_AGG_WH_DAY_PCH_LDLPL_LOYALTY_1
WHERE pcwo_reason_id = 41 
UNION ALL
SELECT
  client_id
, loc_sid_wh
, wh_id
, aspect_id
, CASE WHEN  pcwo_reason_id = 41 THEN 46 
	 ELSE pcwo_reason_id 
	 END AS pcwo_reason_id
,  134 AS sfotype_id
,  1 AS pch_bnl_switch_fg
, currency_iso_cd
, dwh_cal_dt
, discount_val_net
FROM P_LEW_MART_LEAD.T_AGG_WH_DAY_PCH_LDLPL_LOYALTY_1
;
