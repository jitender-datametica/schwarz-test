create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_BIL_AC.V_AGG_POS_STORE_RECEIPT_DAY_HOUR_LIVE_MTH(
	CLIENT_ID,
	LOC_SID_STORE,
	DWH_CAL_DT,
	RECEIPT_TMSP_HOUR,
	RECEIPT_TMSP_HALF_HOUR,
	LIDL_PLUS_FG,
	TURNOVER_RELEVANT_FG,
	IS_YEAR_SEQ,
	CNT_RECEIPT_SALES,
	TOTAL_NET_VAL,
	DWH_CREATED
) as
SELECT
    client_id
    , loc_sid_store
    , dwh_cal_dt
    , receipt_tmsp_hour
    , receipt_tmsp_half_hour
    , lidl_plus_fg
    , turnover_relevant_fg
    , is_year_seq
    , cnt_receipt_sales
    , total_net_val
    , dwh_created
FROM p_lew_bil.t_agg_pos_store_receipt_day_hour_live_mth;
