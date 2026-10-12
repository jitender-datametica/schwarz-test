create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_SALES_PIECE_PERF_SIG_1(
	CLIENT_ID,
	SRC_ORIG_STORE_NR,
	LOC_SID_STORE,
	DWH_CAL_DT,
	CURRENCY_ISO_CD,
	ITEMGROUP_INT_ID,
	SUBITEMGROUP_ID,
	SUB_ITEM_GRP_SID,
	SALES_PIECES,
	SALES_PIECES_TOTAL,
	SALES_PIECES_FA,
	SALES_PIECES_FA_TOTAL,
	VAL_RTL_NET_WGI_UWG,
	VAL_RTL_NET_WGI_UWG_FA,
	AVERAGE_PRICE,
	PIECE_RECEIPT,
	CNT_CUSTOMER,
	TIME_WORKING_NETTO_FG,
	TRAINING_TIME_HR,
	SALES_PIECES_WO_MULTIPACK_FACTOR,
	SALES_PIECES_TOTAL_WO_MULTIPACK_FACTOR,
	WH_ID,
	MOVE_TO_STORE_ID,
	CY_MONTH,
	OPEN_STORE_FG COMMENT 'Open store flag',
	BEREINIGT_FG COMMENT 'Bereinigt flag',
	BEREINIGT_VJW_FG COMMENT 'Bereinigt VJ same week day flag',
	BEREINIGT_VJM_FG COMMENT 'Bereinigt VJ same calendar_1 day flag',
	BEREINIGT_VVJ_FG COMMENT 'Bereinigt VVJ flag',
	BEREINIGT_VVJW_FG COMMENT 'Bereinigt VVJ same week day flag',
	BEREINIGT_VVJM_FG COMMENT 'Bereinigt VVJ same calendar_1 day flag',
	BEREINIGT_VVVJ_FG COMMENT 'Bereinigt VVVJ flag',
	BEREINIGT_VVVJW_FG COMMENT 'Bereinigt VVVJ same week day flag',
	BEREINIGT_VVVJM_FG COMMENT 'Bereinigt VVVJ same calendar_1 day flag'
) as
SELECT
  client_id
, src_orig_store_nr
, loc_sid_store
, dwh_cal_dt
, currency_iso_cd
, itemgroup_int_id
, subitemgroup_id
, sub_item_grp_sid
, sales_pieces
, sales_pieces_total
, sales_pieces_fa
, sales_pieces_fa_total
, val_rtl_net_wgi_uwg
, val_rtl_net_wgi_uwg_fa
, average_price
, piece_receipt
, cnt_customer
, time_working_netto_fg
, training_time_hr
, sales_pieces_wo_multipack_factor
, sales_pieces_total_wo_multipack_factor
, wh_id
, move_to_store_id
, cy_month
, open_store_fg
, bereinigt_fg
, bereinigt_VJW_fg
, bereinigt_VJM_fg
, bereinigt_VVJ_fg
, bereinigt_VVJW_fg
, bereinigt_VVJM_fg
, bereinigt_VVVJ_fg
, bereinigt_VVVJW_fg
, bereinigt_VVVJM_fg
FROM P_LEW_MART_LEAD.V_AGG_STORE_DAY_SALES_PIECE_PERF_SIG_1
;
