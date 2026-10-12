create or replace view LDL_PRODUCTION.P_LEW_BIL_AC.V_STORE_TO_WAREHOUSE_LASTKNOWN(
	CLIENT_ID,
	LOC_SID_STORE,
	LOC_SID_WH,
	SRC_WH_ID,
	SRC_ORIG_STORE_NR,
	DWH_VALID_FROM,
	DWH_VALID_TO,
	DWH_ACTUAL_FG,
	ACTIVE_FG,
	FUTURE_ACTIVE_FG
) as
   SELECT
       client_id,
   loc_sid_store,
   loc_sid_wh,
   src_wh_id,
   src_orig_store_nr,
   dwh_valid_from,
   dwh_valid_to,
   dwh_actual_fg,
   active_fg,
   future_active_fg
  FROM p_lew_bil.v_store_to_warehouse_lastknown
;
