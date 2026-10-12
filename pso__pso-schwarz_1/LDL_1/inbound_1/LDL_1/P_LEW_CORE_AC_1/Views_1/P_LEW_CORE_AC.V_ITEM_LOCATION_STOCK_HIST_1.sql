create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_ITEM_LOCATION_STOCK_HIST_1(
	CLIENT_ID,
	ITEM_SID,
	LOC_SID,
	SRC_SPACE_SWITCH,
	PRICE,
	PRICE_NET,
	CALC_QTY,
	INV_QTY,
	DIFF_QTY_INV_CALC,
	DELETED_FG,
	STORE_STORAGE_QTY,
	DWH_VALID_FROM,
	DWH_VALID_TO,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
   client_id
   ,item_sid
   ,loc_sid
   ,src_space_switch
   ,price
   ,price_net
   ,calc_qty
   ,inv_qty
   ,diff_qty_inv_calc
   ,deleted_fg
   ,store_storage_qty
   ,dwh_valid_from
   ,dwh_valid_to
   ,dwh_load_id
   ,dwh_created
   ,dwh_updated
  FROM P_LEW_CORE.T_ITEM_LOCATION_STOCK_HIST_1
;
