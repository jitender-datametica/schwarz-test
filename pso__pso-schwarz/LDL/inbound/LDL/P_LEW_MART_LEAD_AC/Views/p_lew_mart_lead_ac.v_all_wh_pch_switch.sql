create or replace view LDL_PRODUCTION.P_LEW_MART_LEAD_AC.V_ALL_WH_PCH_SWITCH(
	CLIENT_ID,
	WH_ID,
	ASPECT_ID,
	PCH_BNL_SWITCH_FG,
	SWITCH_DATE,
	DWH_UPDATED
) COMMENT='Steering Table for all wh incl. VGES'
 as
SELECT
  v.client_id
, v.wh_id
, v.aspect_id
, v.pch_bnl_switch_fg
, v.switch_date
, v.dwh_updated
FROM P_LEW_MART_LEAD.v_all_wh_pch_switch AS v
;
