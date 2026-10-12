
CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_STC_STORE_ITEM_1(
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
     client_id
   , store_id
   , wh_id
   , item_id
   , dat_formdate
   , qty_stc_calc
   , qty_stc_inv
   , qty_stc_real
   , diff_stc_inv_calc
   , store_storage_qty
   , price_retail
   , price_retail_net
   , currency_iso_cd
   , loc_sid_wh
  FROM p_lew_mart_msi.v_stc_store_item_1;