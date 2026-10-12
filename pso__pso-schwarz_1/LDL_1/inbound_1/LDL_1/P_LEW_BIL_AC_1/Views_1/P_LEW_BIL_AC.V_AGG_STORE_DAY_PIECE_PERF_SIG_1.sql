create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_BIL_AC.V_AGG_STORE_DAY_PIECE_PERF_SIG_1(
	CLIENT_ID,
	SRC_ORIG_STORE_NR,
	LOC_SID_STORE,
	DWH_CAL_DT,
	CURRENCY_ISO_CD,
	ITEM_GRP_INT_NR,
	SUB_ITEM_GRP_NR,
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
	SALES_PIECES_FA_WO_MULTIPACK_FACTOR,
	SALES_PIECES_FA_TOTAL_WO_MULTIPACK_FACTOR,
	DWH_LOAD_ID,
	DWH_CREATED
) as
SELECT
  client_id
, src_orig_store_nr
, loc_sid_store
, dwh_cal_dt
, currency_iso_cd
, item_grp_int_nr
, sub_item_grp_nr
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
, sales_pieces_fa_wo_multipack_factor 
, sales_pieces_fa_total_wo_multipack_factor 
, dwh_load_id
, dwh_created
FROM P_LEW_BIL.V_AGG_STORE_DAY_PIECE_PERF_SIG_1
;
