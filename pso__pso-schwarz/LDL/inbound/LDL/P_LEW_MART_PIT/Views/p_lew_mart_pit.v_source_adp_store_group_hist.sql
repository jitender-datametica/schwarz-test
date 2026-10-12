/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_STORE_GROUP_HIST
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_STORE_GROUP_HIST
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2022-02-23 Nikolai Toknov Initial version
# 1.1 2022-03-03 Nikolai Toknov  Add f_CleanValidToDate and T_CNTL_PROCESSING_PARAM_NORMALIZED
# 1.2 2022-03-29 Nikolai Toknov	 CR fix. View doesn't use now.
# 1.3 2023-05-25 Nikolai Toknov	 Change DWH_VALID_FROM -> VALID_FROM_DT and DWH_VALID_TO -> VALID_TO_DT
# 1.4 2024-09-23 Nikolai Toknov	 Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_STORE_GROUP_HIST
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_ADP_STORE_GROUP_HIST  
COMMENT = 'Source View ADP Store Group History'
AS
SELECT
		  CLIENT_ID
		, STORE_GRP_SID
		, DWH_VALID_FROM AS VALID_FROM_DT
		, COALESCE(P_LEW_MART_PIT.f_CleanValidToDate(dwh_valid_to),'9999-12-31'::DATE) AS VALID_TO_DT

	FROM P_LEW_CORE.T_STORE_GROUP_HIST 
	WHERE TRUE 
		AND UPPER(STORE_GRP_TYPE_CD) = 'CMP'
		AND DELETED_FG = 0
		AND CLIENT_ID IN (
		-- PIT Country
		SELECT
			CLIENT_ID
		FROM p_lew_mart_pit.T_DIM_CLIENT
		WHERE TRUE
			AND PIT_COUNTRY_FG 	= 1
			AND DELETED_FG 		= 0
			AND REJECT_FG 		= 0
			AND CURRENT_FG 		= 1
		GROUP BY 1
							)
			    -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
	QUALIFY ROW_NUMBER() OVER(PARTITION BY STORE_GRP_SID, DWH_VALID_FROM  
	                              ORDER BY DWH_UPDATED DESC) = 1
;