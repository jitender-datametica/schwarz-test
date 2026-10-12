create or replace dynamic table LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_DEL_QTY_STR_DY_2(
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
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_D_DYNAMIC_TABLE_P_LEW_MART_LEAD
 as
   SELECT
     dy.client_id
	 ,dy.item_sid
	 ,dy.loc_sid_store
	 ,dy.dat_formdate
	 ,dy.cy_month
	 ,dy.busyear
	 ,cry.currency_iso_cd
	 ,dy.del_qty_nfv_val
	 ,dy.del_qty_fv_val
	 ,dy.del_qty_brk_alc_val
  FROM p_lew_mart_lead.t_agg_del_qty_str_dy_2 dy
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
   ON dy.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
