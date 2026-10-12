create or replace dynamic table LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_DEL_QTY_STR_MTH(
	CLIENT_ID,
	ITEM_SID,
	LOC_SID_STORE,
	CY_MONTH,
	BUSYEAR,
	CURRENCY_ISO_CD,
	DEL_QTY_NFV_VAL,
	DEL_QTY_FV_VAL,
	DEL_QTY_BRK_ALC_VAL
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_D_DYNAMIC_TABLE_P_LEW_MART_LEAD
 as
   SELECT
     mth.client_id
     ,mth.item_sid
     ,mth.loc_sid_store
     ,mth.cy_month
     ,mth.busyear
     ,cry.currency_iso_cd
     ,mth.del_qty_nfv_val
     ,mth.del_qty_fv_val
     ,mth.del_qty_brk_alc_val
  FROM p_lew_mart_lead.t_agg_del_qty_str_mth mth
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
   ON mth.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
