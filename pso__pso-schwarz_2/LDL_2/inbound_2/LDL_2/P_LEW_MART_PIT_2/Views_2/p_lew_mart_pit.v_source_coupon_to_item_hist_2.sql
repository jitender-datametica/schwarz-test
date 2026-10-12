/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_COUPON_TO_ITEM_HIST_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_COUPON_TO_ITEM_HIST_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-01-22 Nikolai Toknov	   Initial version
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_COUPON_TO_ITEM_HIST_2
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_COUPON_TO_ITEM_HIST_2
COMMENT = 'Source View Lidl Plus COUPON_TO_ITEM_HIST'
AS
SELECT
      c_itm.CLIENT_ID                                     									AS CLIENT_ID   
    , c_itm.COUPON_SID 																		AS COUPON_SID
	, c_itm.ITEM_SID 																		AS ITEM_SID

    																				
   -- Version                                                                              
	, COALESCE(c_itm.DWH_VALID_FROM,TO_DATE('1900-01-01','YYYY-MM_2-DD'))  					AS VALID_FROM_DT														
	, COALESCE(c_itm.DWH_VALID_TO,TO_DATE('9999-12-31','YYYY-MM_2-DD'))  						AS VALID_TO_DT													
	, COALESCE(c_itm.DELETED_FG::SMALLINT, 0::SMALLINT)										AS DELETED_FG
	, c_itm.DWH_UPDATED::TIMESTAMP      				  									AS DWH_UPDATED_TS															
	
FROM P_LEW_CORE.T_COUPON_TO_ITEM_HIST_2 c_itm
	
WHERE TRUE
;