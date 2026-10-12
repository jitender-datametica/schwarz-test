/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_COUPON_TO_STORE_HIST
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_COUPON_TO_STORE_HIST
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-22 Nikolai Toknov	   Initial version
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_COUPON_TO_STORE_HIST
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_COUPON_TO_STORE_HIST
COMMENT = 'Source View Lidl Plus COUPON_TO_STORE_HIST'
AS
SELECT
      c_store.CLIENT_ID                                     									AS CLIENT_ID   
    , c_store.COUPON_SID 																		AS COUPON_SID
	, c_store.LOC_SID_STORE 																	AS STORE_SID
	, c_store.COUPON_RELATION_TYPE_CD 															AS COUPON_RELATION_TYPE_CD
    																				
   -- Version                                                                              
	, COALESCE(c_store.DWH_VALID_FROM,TO_DATE('1900-01-01','YYYY-MM-DD'))  						AS VALID_FROM_DT														
	, COALESCE(c_store.DWH_VALID_TO,TO_DATE('9999-12-31','YYYY-MM-DD'))  						AS VALID_TO_DT													
	, COALESCE(c_store.DELETED_FG::SMALLINT, 0::SMALLINT)										AS DELETED_FG
	, c_store.DWH_UPDATED::TIMESTAMP      				  										AS DWH_UPDATED_TS															
	
FROM P_LEW_CORE.T_COUPON_TO_STORE_HIST c_store
	
WHERE TRUE
;