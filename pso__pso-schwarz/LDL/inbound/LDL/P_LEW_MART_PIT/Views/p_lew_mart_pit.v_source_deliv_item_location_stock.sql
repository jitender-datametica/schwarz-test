/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_DELIV_ITEM_LOCATION_STOCK
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_DELIV_ITEM_LOCATION_STOCK
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli	   Initial version
#  1.1  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.2	2024-09-23 Nikolai Toknov	   Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_DELIV_ITEM_LOCATION_STOCK
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_DELIV_ITEM_LOCATION_STOCK
COMMENT = 'v_source_deliv_item_location_stock'
AS
SELECT

      stc.client_id::INTEGER    													AS CLIENT_ID
    , stc.item_sid::INTEGER															AS ITEM_SID
    , stc.loc_sid::INTEGER															AS STORE_SID

    , stc.diff_qty_inv_calc::NUMBER(38,5)               							AS DIFF_QTY_INV_CALC
    , stc.calc_qty::NUMBER(38,5)                        							AS CALC_QTY
    , stc.inv_qty::NUMBER(38,5)                         							AS INV_QTY 

	, stc.price::NUMBER(38,5)														AS STC_PRICE_GROSS_VAL
	
	, iff(ZEROIFNULL(stc.diff_qty_inv_calc) = 0,stc.calc_qty,stc.inv_qty)::NUMBER(38,5)
																					AS ITEM_STOCK_REAL_QTY

	, COALESCE(TO_DATE(stc.dwh_valid_from),TO_DATE('1900-01-01','YYYY-MM-DD'))		AS VALID_FROM_DT
	, P_LEW_MART_PIT.f_CleanValidToDate(stc.dwh_valid_to)::DATE  									AS VALID_TO_DT
	
--	, DWH_LAST_CONFIRM_DT															AS DWH_LAST_CONFIRM_DT
	
	, COALESCE(stc.deleted_fg::SMALLINT,0::SMALLINT)			 					AS DELETED_FG
	, DWH_UPDATED::TIMESTAMP  					  								    AS DWH_UPDATED_TS
	
--	, LOAD_ID																		AS LOAD_ID
	
FROM    P_LEW_CORE.T_ITEM_LOCATION_STOCK_HIST stc
        -- no deduplication because of high row count
        
WHERE TRUE
;