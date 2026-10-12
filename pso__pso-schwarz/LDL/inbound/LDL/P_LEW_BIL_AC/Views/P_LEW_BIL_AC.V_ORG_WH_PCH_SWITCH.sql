create or replace view LDL_PRODUCTION.P_LEW_BIL_AC.V_ORG_WH_PCH_SWITCH(
	ASPECT_ID,
	CLIENT_ID,
	WH_ID,
	PCH_BNL_SWITCH_FG,
	SWITCH_DATE,
	DWH_UPDATED
) COMMENT='Steering Table to determine when a country/wh switched to new BNL calculation.'
 as
SELECT
  v.aspect_id
, v.client_id
, v.wh_id
, v.pch_bnl_switch_fg
, v.switch_date
, v.dwh_updated
FROM P_LEW_BIL.v_org_wh_pch_switch AS v
;
