create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_SALES_PIECE_PERF_2(
	CLIENT_ID,
	SRC_ORIG_STORE_NR,
	LOC_SID_STORE,
	DWH_CAL_DT,
	CURRENCY_ISO_CD,
	SALES_PIECES,
	SALES_PIECES_TOTAL,
	SALES_PIECES_EXTRAPOL,
	SALES_PIECES_FA,
	SALES_PIECES_FA_TOTAL,
	VAL_RTL_NET,
	VAL_RTL_NET_FA,
	AVG_SALES_PRICE,
	PIECE_RECEIPT,
	CNT_CUSTOMER,
	WORK_TIME_TOTAL_HR,
	PIECE_PERFORMANCE,
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
	BEREINIGT_VJM_FG COMMENT 'Bereinigt VJ same calendar_2 day flag',
	BEREINIGT_VVJ_FG COMMENT 'Bereinigt VVJ flag',
	BEREINIGT_VVJW_FG COMMENT 'Bereinigt VVJ same week day flag',
	BEREINIGT_VVJM_FG COMMENT 'Bereinigt VVJ same calendar_2 day flag',
	BEREINIGT_VVVJ_FG COMMENT 'Bereinigt VVVJ flag',
	BEREINIGT_VVVJW_FG COMMENT 'Bereinigt VVVJ same week day flag',
	BEREINIGT_VVVJM_FG COMMENT 'Bereinigt VVVJ same calendar_2 day flag'
) as
SELECT
  client_id
, src_orig_store_nr
, loc_sid_store
, dwh_cal_dt
, currency_iso_cd
, sales_pieces
, sales_pieces_total
, sales_pieces_extrapol
, sales_pieces_fa
, sales_pieces_fa_total
, val_rtl_net
, val_rtl_net_fa
, avg_sales_price
, piece_receipt
, cnt_customer
, work_time_total_hr
, piece_performance
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
FROM P_LEW_MART_LEAD.V_AGG_STORE_DAY_SALES_PIECE_PERF_2
;
