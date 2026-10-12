/*
#-----------------------------------------------------------------------------
# Description:
# This view provides SortimentModularitat context into P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_SALES_PIECE_PERF_ITEM_1 view.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     11.06.2025		Malgorzata Cyganska             Initial Version.

#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_SALES_PIECE_PERF_ITEM_SOMO_1(
	CLIENT_ID,
	SRC_ORIG_STORE_NR,
	LOC_SID_STORE,
	DWH_CAL_DT,
	CURRENCY_ISO_CD,
	ITEM_ID,
	ORIG_ITEM_NR,
	CONTAINER_ID,
	CONTAINER_HIST_ID,
	SALES_PIECES,
	SALES_PIECES_TOTAL,
	SALES_PIECES_FA,
	SALES_PIECES_FA_TOTAL,
	VAL_RTL_NET_EJR,
	AVERAGE_PRICE,
	PIECE_RECEIPT,
	CNT_CUSTOMER,
	TIME_WORKING_NETTO_FG,
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
) AS
SELECT
  client_id
, src_orig_store_nr
, loc_sid_store
, dwh_cal_dt
, currency_iso_cd
, item_id
, orig_item_nr
, container_id
, container_hist_id
, sales_pieces
, sales_pieces_total
, sales_pieces_fa
, sales_pieces_fa_total
, val_rtl_net_ejr
, average_price
, piece_receipt
, cnt_customer
, time_working_netto_fg
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
FROM P_LEW_MART_LEAD.V_AGG_STORE_DAY_SALES_PIECE_PERF_ITEM_SOMO_1
;