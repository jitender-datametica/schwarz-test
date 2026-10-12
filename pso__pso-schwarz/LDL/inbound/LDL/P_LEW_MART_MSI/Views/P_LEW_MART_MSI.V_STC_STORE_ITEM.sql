
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_STC_STORE_ITEM(
	 CLIENT_ID
	,STORE_ID
	,WH_ID
	,ITEM_ID
	,DAT_FORMDATE
	,QTY_STC_CALC
	,QTY_STC_INV
	,QTY_STC_REAL
	,DIFF_STC_INV_CALC
	,STORE_STORAGE_QTY
	,PRICE_RETAIL
	,PRICE_RETAIL_NET
	,CURRENCY_ISO_CD
	,LOC_SID_WH
) AS
   SELECT	
     sli.client_id                                             AS client_id
   , sli.loc_sid                                               AS store_id
   , stw_h.src_wh_id                                           AS wh_id
   , sli.item_sid                                              AS item_id
   , sli.dwh_cal_dt                                            AS dat_formdate
   , sli.stock_calc_qty                                        AS qty_stc_calc
   , sli.stock_inv_qty                                         AS qty_stc_inv
   , sli.stock_real_qty                                        AS qty_stc_real
   , sli.stock_inv_diff_calc                                   AS diff_stc_inv_calc	
   , sli.store_storage_qty                                     AS store_storage_qty
   , sli.price / cry.exchange_rate::DECIMAL(18,4)              AS price_retail
   , sli.price_net  / cry.exchange_rate::DECIMAL(19,5)         AS price_retail_net
   , cry.curr_cd_from                                          AS currency_iso_cd
   , stw_h.loc_sid_wh                                          AS loc_sid_wh

  FROM p_lew_bil_ac.v_stock_location_item sli
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown AS stw_h
   ON  sli.client_id = stw_h.client_id
   AND sli.loc_sid   = stw_h.loc_sid_store
   /*	
   # exclude the dummy stores for warehouse	
   */	
   AND sli.loc_sid  <> stw_h.loc_sid_wh
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS cry
   ON  sli.client_id = cry.client_id
   /*	
   # latest rate (point in history)	
   */	
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt	
   /*	
   # latest history (version)
   */	
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to	
   INNER JOIN p_lew_core_ac.v_exchange_rate_type AS ert	
   ON  cry.client_id       = ert.client_id
   AND cry.x_rate_type_sid = ert.x_rate_type_sid
   /*	
   # reporting rate (slow moving)	
   */	
   AND ert.src_kurst       = '@BEWE'
   /*	
   # selection of partitions	
   */	
   WHERE sli.dwh_cal_dt <= CURRENT_DATE	
   AND sli.client_id < 41;