/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_WAWI_REF_PRICEGROUP_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_REF_PRICEGROUP_1
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
0. Create View Table in V_SOURCE_WAWI_REF_PRICEGROUP_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_WAWI_REF_PRICEGROUP_1
AS
SELECT 
	  CLIENT_ID
	, POSITION_ARTICLE_SALES_REP AS PRICEGROUP_PRIORITY
	, PRICEGROUP_ID
	, PRICEGROUP_DESC
	, ARTICLE_SALES_REP_DESC
	, DAT_VALID_FROM
	, DAT_VALID_UNTIL
	, LOAD_ID 
FROM P_LEW_CORE.T_WAWI_REF_PRICEGRP_1
	WHERE TRUE
;