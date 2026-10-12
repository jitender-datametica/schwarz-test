create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD_AC.V_AGG_POS_STORE_RECEIPT_DAY_HOUR_LIVE_MTH_2(
	CLIENT_ID,
	STORE_ID,
	MOVE_TO_STORE_ID,
	ASPECT_ID,
	DAT_FORMDATE,
	DAT_CALENDAR,
	RECEIPT_TMSP_HOUR,
	RECEIPT_TMSP_HALF_HOUR,
	IS_CLOSED_HOUR,
	LIDL_PLUS_FG,
	TURNOVER_RELEVANT_FG,
	IS_YEAR_SEQ,
	CNT_RECEIPT_SALES_ASIS,
	TOTAL_NET_VAL_ASIS,
	CURRENCY_ISO_CD,
	LAST_REFRESH
) as
SELECT
   client_id
 , store_id
 , move_to_store_id
 , aspect_id
 , dat_formdate
 , dat_calendar
 , receipt_tmsp_hour
 , receipt_tmsp_half_hour
 , is_closed_hour
 , lidl_plus_fg
 , turnover_relevant_fg
 , is_year_seq
 , cnt_receipt_sales_asis
 , total_net_val_asis
 , currency_iso_cd
 , last_refresh
FROM p_lew_mart_lead.v_agg_pos_store_receipt_day_hour_live_mth_2
;
