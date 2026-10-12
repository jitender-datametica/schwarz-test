/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_LOC_WAREHOUSE_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_LOC_WAREHOUSE_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-02-10 Nikolai Toknov	    Initial version
#  1.1  2023-06-27 Andreas Kurz			Improved Version, specail Formatting for DE (23)
#       								Aligned with APT Warehouse Name Logic
#										WAREHOUSE_NAME_SDESCR
#-------------------------------------------------------------------------------
*/

-- USE DATABASE LDL_PRODUCTION_CLONE_PIT_QS;
-- USE DATABASE LDL_PRODUCTION_CLONE_PIT_R51503;

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_LOC_WAREHOUSE_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_LOC_WAREHOUSE_1
COMMENT = 'Source View Warehiouse'
AS
SELECT
      loc.CLIENT_ID::INTEGER                            									AS CLIENT_ID   
	, loc.LOC_SID							 												AS WAREHOUSE_SID
	, COALESCE(loc.LOC_NAME, 'N/A'::VARCHAR)												AS WAREHOUSE_NAME_DESCR
	, iff(loc.CLIENT_ID= 23
			,iff(
				loc.LOC_NAME::TEXT REGEXP --'^\\d{3}[a-zA-Z]{3}\\s$'
				'^\\d{3}[a-zA-Z]{3}.*'
				AND LENGTH (loc.LOC_NAME) = 6
				,SUBSTRING(UPPER(loc.LOC_NAME),4,3)
				,SUBSTRING(UPPER(loc.LOC_NAME),1,3)
				)
			, COALESCE(loc.LOC_NAME, 'N/A'::VARCHAR)
		) 																					AS WAREHOUSE_NAME_SDESCR
	, WAREHOUSE_NAME_SDESCR																	AS WAREHOUSE_NAME
  
	, loc.SRC_ORIG_WH_NR::INTEGER                    										AS ORIG_WAREHOUSE_NR
	, MD5(
                COALESCE(TO_CHAR(WAREHOUSE_NAME),'')                               
        )										                                            AS SCD_KEY_MD
																						
   -- Version                                                                              
	, COALESCE(loch.DWH_VALID_FROM,TO_DATE('1900-01-01','YYYY-MM_1-DD'))  					AS VALID_FROM_DT														
	, COALESCE(loch.DWH_VALID_TO,TO_DATE('9999-12-31','YYYY-MM_1-DD'))  						AS VALID_TO_DT													
	, COALESCE(loch.DELETED_FG::SMALLINT, 0::SMALLINT)										AS DELETED_FG
	, loch.DWH_UPDATED::TIMESTAMP      				  										AS DWH_UPDATED_TS															
	
FROM
	-- Location_1 
--	-- DESC TABLE P_LEW_CORE.T_LOCATION_1
	(
		SELECT 
			  CLIENT_ID
			, LOC_SID
			, SRC_ORIG_WH_NR
			, LOC_NAME
			, WH_NAME
			, WH_ADD1_NAME
			, WH_TXT
			, LOC_STATUS_CD
			, COUNTRY_POL_SID
			, COUNTRY_POL_CD
			, WH_STORE_MARK
		FROM P_LEW_CORE.T_LOCATION_1
		WHERE TRUE
			-- WAREHOUSE
			AND UPPER(WH_STORE_MARK)	=	'B'
			-- trash filtration
			AND SRC_ORIG_WH_NR 			> 0
			AND COUNTRY_POL_SID 		IS NOT NULL
			AND COUNTRY_POL_CD 			IS NOT NULL
			AND SRC_ORIG_WH_NR 			<> 999
			AND LOC_NAME 				IS NOT NULL
			
			AND CLIENT_ID IN (
				-- PIT Country_1
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT_1 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)	
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY LOC_SID ORDER BY DWH_UPDATED DESC) = 1
	) loc
	
	-- Loc histroy
	INNER JOIN 
	(	
		SELECT 
			  CLIENT_ID
			, LOC_SID
			, DELETED_FG
			, DWH_VALID_FROM
			, DWH_VALID_TO
			, DWH_UPDATED
		FROM P_LEW_CORE.T_LOCATION_HIST_1 
		WHERE TRUE
			AND DELETED_FG=0
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY LOC_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
	) loch
	ON TRUE
		AND loc.LOC_SID		= loch.LOC_SID
		AND loc.CLIENT_ID	= loch.CLIENT_ID

WHERE TRUE 
;
