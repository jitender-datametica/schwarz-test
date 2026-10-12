/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_LOC_STORE_2
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_LOC_STORE_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-02-10 Nikolai Toknov	   Initial version
#  2.0  2022-07-12 Nikolai Toknov	   Add country_pol_cd
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_LOC_STORE_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_LOC_STORE_2
COMMENT = 'Source View STORE'
AS
SELECT
      loc.CLIENT_ID::INTEGER                            									AS CLIENT_ID   
	, loc.LOC_SID							 												AS STORE_SID
	, loc.LONGITUDE::NUMBER(38,5)															AS STORE_LONGITUDE
	, loc.LATITUDE::NUMBER(38,5)															AS STORE_LATITUDE
	, iff(loc.LONGITUDE IS NOT NULL AND loc.LATITUDE IS NOT NULL,1::SMALLINT,0::SMALLINT)	AS GEO_INFO_FG
	, COALESCE(loc.LOC_NAME, 'N/A'::VARCHAR)        										AS STORE_NAME
    , loc.SRC_ORIG_STORE_NR::INTEGER                    									AS ORIG_STORE_NR
	, COALESCE(loch.CLOSED_FG,         0::SMALLINT)     									AS CLOSED_FG
    , COALESCE(loch.TEST_STORE_FG,     0::SMALLINT)     									AS TEST_STORE_FG
    , COALESCE(loch.DUMMY_STORE_FG,    0::SMALLINT)     									AS DUMMY_STORE_FG
    , COALESCE(loch.TEMPLATE_STORE_FG, 0::SMALLINT)     									AS TEMPLATE_STORE_FG
	, country_pol_cd																		AS COUNTRY_POL_CD
																							
	, COALESCE(loc.REAL_OPENING_DT	,TO_DATE('8888-12-31','YYYY-MM_2-DD'))					AS REAL_OPENING_DT
	, COALESCE(loc.OPENING_DT		,TO_DATE('8888-12-31','YYYY-MM_2-DD')) 					AS OPENING_DT	                                  
	, COALESCE(loc.CLOSING_DT		,TO_DATE('8888-12-31','YYYY-MM_2-DD')) 					AS CLOSING_DT
																							
   -- Version                                                                              
	, COALESCE(loch.DWH_VALID_FROM,TO_DATE('1900-01-01','YYYY-MM_2-DD'))  					AS VALID_FROM_DT														
	, COALESCE(loch.DWH_VALID_TO,TO_DATE('9999-12-31','YYYY-MM_2-DD'))  						AS VALID_TO_DT													
	, COALESCE(loch.DELETED_FG::SMALLINT, 0::SMALLINT)										AS DELETED_FG
	, loch.DWH_UPDATED::TIMESTAMP      				  										AS DWH_UPDATED_TS															
	
FROM
	(
		SELECT 
			* 
		FROM P_LEW_CORE.T_LOCATION_2 
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY LOC_SID ORDER BY DWH_UPDATED DESC) = 1
	) loc
	
	INNER JOIN 
	(	
		SELECT 
			*
		FROM P_LEW_CORE.T_LOCATION_HIST_2 
		WHERE TRUE
		AND DELETED_FG=0
		-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
		QUALIFY ROW_NUMBER() OVER(PARTITION BY LOC_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
	) loch
	ON  loc.LOC_SID 	= loch.LOC_SID

WHERE TRUE
	-- STORE
	AND UPPER(loc.WH_STORE_MARK)='A'
	-- trash filtration
	--and loc.LONGITUDE is not NULL
	--and loc.LATITUDE is not null 
	AND loc.SRC_ORIG_STORE_NR >0
;