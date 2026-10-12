/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_WAWI_ITEM_PRICEGROUP_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_ITEM_PRICEGROUP_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-12-09 Nikolai Toknov		Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001; -- new Clone
USE SCHEMA 		P_LEW_MART_PIT_1;
 */
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_WAWI_ITEM_PRICEGROUP_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_WAWI_ITEM_PRICEGROUP_1
AS
SELECT 				  
	  CLIENT_ID

    
    , PRICEGROUP_ID									AS PRICEGROUP_ID
    , COALESCE( TRIM(PRICEGROUP_DESC), 'n/A')		AS PRICEGROUP_DESC
    , COALESCE( PRIORITY, -1)						AS PRICEGROUP_PRIORITY

    , COALESCE( ST_LOC_SID, -2) 					AS STORE_SID
    , COALESCE( WH_LOC_SID, -2) 					AS WAREHOUSE_SID

	, DAT_VALID_FROM
	, DAT_VALID_UNTIL
	--, PRIORITY
	, LANGUAGE_ID
	, LOAD_ID			
 FROM P_LEW_CORE.T_WAWI_ITM_PRICEGROUP_1 
	WHERE TRUE
;