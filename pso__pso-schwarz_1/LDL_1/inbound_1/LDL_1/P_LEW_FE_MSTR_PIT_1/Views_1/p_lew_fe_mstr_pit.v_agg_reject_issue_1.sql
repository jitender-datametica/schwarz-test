/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for V_AGG_REJECT_ISSUE_1
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for V_AGG_REJECT_ISSUE_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-07-27 Nikolai Toknov	    Initial version
#  1.1  2025-01-15 Nikolai Toknov		Change for T_AGG_REGION_CENTRAL_NAN_1
#-------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_AGG_REJECT_ISSUE_1 
COMMENT = 'View V_AGG_REJECT_ISSUE.Analysis of the number of rejections in t_agg-*tables'
 (
	TABLE_NAME
  , CLIENT_ID
  , ADV_WEEK_ID
  , CNT_REJECT_FG 
 
 )
AS
SELECT 	 'T_AGG_REGION_CENTRAL_NAN_1' TABLE_NAME
		, CLIENT_ID
		, ADV_WEEK_ID
		, SUM(REJECT_FG) CNT_REJECT_FG 
	FROM P_LEW_FE_MSTR_PIT.T_AGG_REGION_CENTRAL_NAN_1
	GROUP BY CLIENT_ID, ADV_WEEK_ID
	HAVING CNT_REJECT_FG>0
UNION ALL
SELECT 	 'T_AGG_REGION_CATEGORY_ALL_1' TABLE_NAME
		, CLIENT_ID
		, ADV_WEEK_ID
		, SUM(REJECT_FG) CNT_REJECT_FG 
	FROM P_LEW_FE_MSTR_PIT.T_AGG_REGION_CATEGORY_ALL_1
	GROUP BY CLIENT_ID, ADV_WEEK_ID
	HAVING CNT_REJECT_FG>0
UNION ALL
SELECT 	 'T_AGG_REGION_MEDIUM_ALL_1' TABLE_NAME
		, CLIENT_ID
		, ADV_WEEK_ID
		, SUM(REJECT_FG) CNT_REJECT_FG 
	FROM P_LEW_FE_MSTR_PIT.T_AGG_REGION_MEDIUM_ALL_1
	GROUP BY CLIENT_ID, ADV_WEEK_ID
	HAVING CNT_REJECT_FG>0
UNION ALL
SELECT 	 'T_AGG_REGION_PERIOD_ALL_1' TABLE_NAME
		, CLIENT_ID
		, ADV_WEEK_ID
		, SUM(REJECT_FG) CNT_REJECT_FG 
	FROM P_LEW_FE_MSTR_PIT.T_AGG_REGION_PERIOD_ALL_1
	GROUP BY CLIENT_ID, ADV_WEEK_ID
	HAVING CNT_REJECT_FG>0
UNION ALL
SELECT 	 'T_AGG_REGION_THEME_ALL_1' TABLE_NAME
		, CLIENT_ID
		, ADV_WEEK_ID
		, SUM(REJECT_FG) CNT_REJECT_FG 
	FROM P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL_1
	GROUP BY CLIENT_ID, ADV_WEEK_ID
	HAVING CNT_REJECT_FG>0;