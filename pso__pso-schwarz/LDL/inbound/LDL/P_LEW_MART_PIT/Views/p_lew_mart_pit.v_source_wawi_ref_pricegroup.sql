/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for P_LEW_MART_PIT.V_SOURCE_WAWI_REF_PRICEGROUP
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_WAWI_REF_PRICEGROUP
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
USE SCHEMA 		P_LEW_MART_PIT;
 */
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_WAWI_REF_PRICEGROUP
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_WAWI_REF_PRICEGROUP
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
FROM P_LEW_CORE.T_WAWI_REF_PRICEGRP
	WHERE TRUE
;