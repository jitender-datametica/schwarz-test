create or replace view LDL_PRODUCTION.P_LEW_BIL_AC.V_STOCK_LOCATION_ITEM_1(
	CLIENT_ID,
	LOC_SID,
	ITEM_SID,
	DWH_CAL_DT,
	STOCK_CALC_QTY,
	STOCK_INV_QTY,
	STOCK_REAL_QTY,
	STOCK_INV_DIFF_CALC,
	PRICE,
	PRICE_NET,
	SRC_SPACE_SWITCH,
	STORE_STORAGE_QTY,
	DWH_VALID_FROM,
	DWH_VALID_TO
) as
   SELECT
     client_id
   , loc_sid
   , item_sid
   , dwh_cal_dt
   , stock_calc_qty
   , stock_inv_qty
   , stock_real_qty
   , stock_inv_diff_calc
   , price
   , price_net
   , src_space_switch
   , store_storage_qty
   , dwh_valid_from
   , dwh_valid_to
  FROM p_lew_bil.v_stock_location_item_1;
