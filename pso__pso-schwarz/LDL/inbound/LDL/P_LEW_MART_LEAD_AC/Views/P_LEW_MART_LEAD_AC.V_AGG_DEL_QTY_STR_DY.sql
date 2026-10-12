create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD_AC.V_AGG_DEL_QTY_STR_DY(
	CLIENT_ID,
	ITEM_SID,
	LOC_SID_STORE,
	DAT_FORMDATE,
	CY_MONTH,
	BUSYEAR,
	CURRENCY_ISO_CD,
	DEL_QTY_NFV_VAL,
	DEL_QTY_FV_VAL,
	DEL_QTY_BRK_ALC_VAL
) as
   SELECT
     client_id
   ,item_sid
   ,loc_sid_store
   ,dat_formdate
   ,cy_month
   ,busyear
   ,currency_iso_cd
   ,del_qty_nfv_val
   ,del_qty_fv_val
   ,del_qty_brk_alc_val
  FROM p_lew_mart_lead.v_agg_del_qty_str_dy
;
