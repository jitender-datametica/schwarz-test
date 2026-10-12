create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD_AC.V_AGG_REV_TOPSELL_ITEM_HR_BGESVGES_1(
	CLIENT_ID,
	DAT_FORMDATE,
	ITEM_SID,
	LOC_SID_STORE_MOVE_TO,
	WH_LOC_SID,
	ASPECT_ID,
	WH_ID,
	CY_WEEK,
	CURRENCY_ISO_CD,
	TIME_HOUR_ID,
	QTY_PIECE_EJR,
	QTY_WEIGHT_EJR,
	QTY_SOLD,
	VAL_RETAIL_NET_EJR
) as
SELECT
hrl.client_id
,hrl.dat_formdate
,hrl.item_sid
,hrl.loc_sid_store_move_to
,hrl.wh_loc_sid
,hrl.aspect_id
,hrl.wh_id
,hrl.cy_week
,hrl.currency_iso_cd
,hrl.time_hour_id
,hrl.qty_piece_ejr
,hrl.qty_weight_ejr
,hrl.qty_sold
,hrl.val_retail_net_ejr
FROM p_lew_mart_lead.v_agg_rev_topsell_item_hr_bgesvges_1 hrl
;
