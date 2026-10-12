/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2022-02-23 Nikolai Toknov  Initial version
# 1.1 2022-03-03 Nikolai Toknov  Add f_CleanValidToDate and T_CNTL_PROCESSING_PARAM_NORMALIZED_1
# 1.2 2022-03-24 Mike Davis      Add MEDIUM_SID and MEDIUM_DISPLAY_NAME
# 1.3 2022-06-08 Andreas Kurz	 Changed MEDIUM_SID
# 1.4 2022-06-30 Nikolai Toknov  Drop "eph.DELETED_FG = 0". This is WA for NSR3021858
# 1.5 2023-05-25 Nikolai Toknov	 Change DWH_VALID_FROM -> VALID_FROM_DT and DWH_VALID_TO -> VALID_TO_DT 
# 1.6 2024-09-23 Nikolai Toknov	 Add schema name for f_CleanString
# 1.7 2024-09-23 Nikolai Toknov	 Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_1; 
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST_1
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_ADP_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST_1  
AS 
	SELECT 
			  eph.CLIENT_ID
			, eph.CAMPAIGN_ELEM_PLAN_SID
			, COALESCE(eph.CAMPAIGN_ELEM_SID, -1)::INTEGER                                                          AS CAMPAIGN_ELEM_SID
			, eph.CAMPAIGN_ACTIVITY_TYPE_CD                                                                         
			, eph.PLAN_STATUS_CD                                                                                    
			, COALESCE(eph.PRICE_ACTIVE_FROM_DT	, TO_DATE('1900-01-01','YYYY-MM_1-DD') )                              AS PRICE_ACTIVE_FROM_DT
			, COALESCE(eph.PRICE_ACTIVE_TO_DT	, TO_DATE('9999-12-31','YYYY-MM_1-DD') )                              AS REAL_PRICE_ACTIVE_TO_DT
			, COALESCE(eph.SALES_CHANNEL_SID, -1000)::INTEGER                                                       AS SALES_CHANNEL_SID
			                                                                                                        
			, eph.ADV_DT                                                                                            AS ADV_DT
        	, COALESCE(eph.ADV_CHANNEL_SID, -1000)::INTEGER                                                         AS ADV_CHANNEL_SID  -- obsolete, really, but just for cross-checking
            , P_LEW_MART_PIT.f_CleanString(med.ADV_CHANNEL_NAME)::VARCHAR                                                          AS MEDIUM_DISPLAY_NAME  --  useful whilst available
            
			--, MD5_NUMBER_LOWER64(TO_CHAR(eph.CLIENT_ID) || COALESCE(UPPER(MEDIUM_DISPLAY_NAME), ''))::NUMBER(38,0)  AS MEDIUM_SID
			, COALESCE(eph.ADV_CHANNEL_SID, -1000)::INTEGER															AS MEDIUM_SID
			, eph.DELETED_FG                                                                                        AS DELETED_FG
			, eph.DWH_VALID_FROM                                                                                    AS VALID_FROM_DT 
			, P_LEW_MART_PIT.f_CleanValidToDate(eph.dwh_valid_to)                                  	                            AS VALID_TO_DT			
			-- Calculated end dates			
		   -- , dateadd('day', +6 , PRICE_ACTIVE_FROM_DT)  	AS CALC_PRICE_ACTIVE_TO_DT
			---- WHEN PRICE_ACTIVE_TO_DT IS MORE THAN 7 DAYS OR NULL THEN PRICE_ACTIVE_FROM_DT+6		  
			--, iff(PRICE_ACTIVE_TO_DT <= CALC_PRICE_ACTIVE_TO_DT,PRICE_ACTIVE_TO_DT,CALC_PRICE_ACTIVE_TO_DT)::DATE 
			--												AS PRICE_ACTIVE_TO_DT 
			--, iff(REAL_PRICE_ACTIVE_TO_DT > CALC_PRICE_ACTIVE_TO_DT,1::SMALLINT,0::SMALLINT)
			--												AS CALC_PRICE_ACTIVE_TO_DT_FG
															
		FROM P_LEW_CORE.T_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST_1 eph
	    LEFT JOIN 
	    -- Get data for MEDIUM_SID
	    (
              SELECT
                    CLIENT_ID
                  , ADV_CHANNEL_SID
                  , ADV_CHANNEL_NAME                
              FROM P_LEW_CORE.T_ADVERTISEMENT_CHANNEL_1
	          WHERE TRUE
              -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
              QUALIFY ROW_NUMBER() OVER(PARTITION BY ADV_CHANNEL_SID ORDER BY DWH_UPDATED DESC) = 1
        ) med
	    ON TRUE 
	    	AND eph.CLIENT_ID		= med.CLIENT_ID
	    	AND eph.ADV_CHANNEL_SID	= med.ADV_CHANNEL_SID
        
		WHERE TRUE 
			AND eph.CAMPAIGN_ACTIVITY_TYPE_CD IN ('ADV','PRC','SPL') -- PRC := Price SPL := Special ADV := ADVERTISING
			-- AND eph.DELETED_FG = 0 -- v.1.4
			AND eph.CLIENT_ID IN   
			(
				-- PIT Country_1
				SELECT
					CLIENT_ID
				FROM p_lew_mart_pit.T_DIM_CLIENT_1
				WHERE TRUE
					AND PIT_COUNTRY_FG 	= 1
					AND DELETED_FG 		= 0
					AND REJECT_FG 		= 0
					AND CURRENT_FG 		= 1
				GROUP BY 1
			)
			-- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)	
		QUALIFY ROW_NUMBER() OVER(PARTITION BY eph.CAMPAIGN_ELEM_PLAN_SID, eph.DWH_VALID_FROM 
		                              ORDER BY eph.DWH_UPDATED DESC) = 1	
;