/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_LOC_STORE_TO_WAREHOUSE_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_LOC_STORE_TO_WAREHOUSE_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-02-10 Nikolai Toknov	   Initial version
#  1.1	2024-09-23 Nikolai Toknov	   Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/


/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_LOC_STORE_TO_WAREHOUSE_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_LOC_STORE_TO_WAREHOUSE_1
COMMENT = 'Source View STORE_TO_WAREHOUSE'
AS
SELECT
      CLIENT_ID::INTEGER                            									AS CLIENT_ID   
	, LOC_SID_STORE							 											AS STORE_SID
	, LOC_SID_WH							 											AS WAREHOUSE_SID
	, COALESCE(ACTIVE_FROM_DT,TO_DATE('1900-01-01','YYYY-MM_1-DD')) 						AS ACTIVE_FROM_DT
	, COALESCE(ACTIVE_TO_DT,TO_DATE('9999-12-31','YYYY-MM_1-DD')) 						AS ACTIVE_TO_DT
   
   -- Version                                                                              
	, COALESCE(DWH_VALID_FROM,TO_DATE('1900-01-01','YYYY-MM_1-DD'))  						AS VALID_FROM_DT														
	, COALESCE(P_LEW_MART_PIT.f_CleanValidToDate(DWH_VALID_TO),'9999-12-31'::DATE) 		AS VALID_TO_DT	
	, COALESCE(DELETED_FG::SMALLINT, 0::SMALLINT)										AS DELETED_FG
	, DWH_UPDATED::TIMESTAMP      				  										AS DWH_UPDATED_TS															
	
FROM
     P_LEW_CORE.T_STORE_TO_WH_DELIVERY_HIST_1
	 
WHERE TRUE
	AND DELETED_FG		= 	0 
	AND ITEM_GRP_SID	=	-1::INTEGER*CLIENT_ID

-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
QUALIFY ROW_NUMBER() OVER (PARTITION BY LOC_SID_STORE, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
;