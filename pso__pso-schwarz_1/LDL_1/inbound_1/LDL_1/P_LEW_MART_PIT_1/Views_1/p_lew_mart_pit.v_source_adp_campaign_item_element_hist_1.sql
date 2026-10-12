/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2022-02-23 Nikolai Toknov 	Initial version
# 1.1 2022-03-03 Nikolai Toknov  	Add f_CleanValidToDate and T_CNTL_PROCESSING_PARAM_NORMALIZED_1
# 1.2 2022-03-29 Nikolai Toknov		Change join with t_item_hist_1 
# 1.3 2022-06-30 Nikolai Toknov		Drop "AND DELETED_FG = 0". This is WA for NSR3021858
# 1.4 2023-03-16 Nikolai Toknov		INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
# 1.5 2023-05-25 Nikolai Toknov	 	Change DWH_VALID_FROM -> VALID_FROM_DT and DWH_VALID_TO -> VALID_TO_DT 
# 1.6 2023-06-09 Nikolai Toknov		Change column name to NAT_THEME_TXT
# 1.7 2023-09-06 Andreas Kurz 		Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Changed logic for N/A
# 1.8 2024-09-23 Nikolai Toknov		Add schema name for f_CleanString
# 1.9 2024-09-23 Nikolai Toknov		Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51503;
USE SCHEMA 		P_LEW_MART_PIT_1;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/
/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1  
AS 
SELECT 
          cp.CLIENT_ID                                                                                                                              AS CLIENT_ID
        , cp.CAMPAIGN_ELEM_SID                                                                                                                      AS CAMPAIGN_ELEM_SID
        , COALESCE(cp.CAMPAIGN_SID, -1)::INTEGER                                                                                                    AS CAMPAIGN_SID
        
		-- APT Core Interface is setting NULL or empty string to N/A
		, Iff(cp.NAT_THEME_TXT IS NULL OR LENGTH(P_LEW_MART_PIT.f_CleanString(cp.NAT_THEME_TXT)) = 0 OR P_LEW_MART_PIT.f_CleanString(cp.NAT_THEME_TXT) = 'N/A'
				, 'Kein Werbethema Kategorie definiert (NAT)'
				, P_LEW_MART_PIT.f_CleanString(cp.NAT_THEME_TXT)
					)::VARCHAR                                         																				AS NAT_THEME_TXT
		-- APT Core Interface is setting NULL or empty string to N/A
		, UPPER(Iff(cp.NAT_THEME_TXT IS NULL OR LENGTH(P_LEW_MART_PIT.f_CleanString(cp.NAT_THEME_TXT)) = 0 OR P_LEW_MART_PIT.f_CleanString(cp.NAT_THEME_TXT) = 'N/A'
				, 'Kein Werbethema Kategorie definiert (NAT)'
				, P_LEW_MART_PIT.f_CleanString(cp.NAT_THEME_TXT)
					))::VARCHAR                                                   																	AS NAT_THEME_TXT_UPPER
		
        , CP.ITEM_SID                                                                                                                               AS ITEM_SID
        , COALESCE(TRY_TO_NUMBER(itm.SRC_ORIG_ITEM_NR), TRY_TO_NUMBER(itm.CONFIG_ITEM_CD), TRY_TO_NUMBER(itm.SRC_MATNR),-1)::NUMBER(38,0)           AS ORIG_ITEM_NR
        
        
        -- for information only 
        , cp.CAMPAIGN_ELEM_STATUS_CD                                                                                                                AS CAMPAIGN_ELEM_STATUS_CD 
                                        
        , COALESCE(cp.CAMPAIGN_ELEM_START_DT , TO_DATE('1900-01-01','YYYY-MM_1-DD'))   															 	AS CAMPAIGN_ELEM_START_DT
        , COALESCE(cp.CAMPAIGN_ELEM_END_DT , TO_DATE('9999-12-31','YYYY-MM_1-DD'))   											 						AS REAL_CAMPAIGN_ELEM_END_DT
 
        , cp.DELETED_FG 																															AS DELETED_FG
        
        , cp.DWH_VALID_FROM 																														AS VALID_FROM_DT
        , COALESCE(P_LEW_MART_PIT.f_CleanValidToDate(cp.dwh_valid_to),'9999-12-31'::DATE)                                                							AS VALID_TO_DT
                                                                                                                                                                                                                                                                                                                                    
FROM 
       
		(
         SELECT 
			*
         FROM P_LEW_CORE.T_CAMPAIGN_ELEMENT_HIST_1 
         WHERE TRUE 
                         AND CAMPAIGN_ELEM_STATUS_CD 	<> 'DRAFT' 
                         -- AND DELETED_FG					= 	0 -- v1.3
                         AND CLIENT_ID 				IN   (
															 -- PIT Country_1
															 SELECT
																			 CLIENT_ID
															 FROM P_LEW_MART_PIT.T_DIM_CLIENT_1
															 WHERE TRUE
																			 AND PIT_COUNTRY_FG 	= 1
																			 AND DELETED_FG 		= 0
																			 AND REJECT_FG          = 0
																			 AND CURRENT_FG         = 1
															 GROUP BY 1
                                                           )
         -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just AS a precaution here.)
         QUALIFY ROW_NUMBER() OVER(PARTITION BY CAMPAIGN_ELEM_SID , DWH_VALID_FROM  ORDER BY DWH_UPDATED DESC) = 1
       ) cp 
       
       -- Join to item_1 
       INNER JOIN 
       (
                       SELECT 
						*
                       FROM P_LEW_CORE.T_ITEM_1
                       WHERE TRUE
                       AND CLIENT_ID IN (
                                         -- PIT Country_1
                                         SELECT
                                               CLIENT_ID
                                         FROM P_LEW_MART_PIT.T_DIM_CLIENT_1
                                         WHERE TRUE
                                           AND PIT_COUNTRY_FG 	= 1
                                           AND DELETED_FG		= 0
                                           AND REJECT_FG  		= 0
                                           AND CURRENT_FG       = 1
                                         GROUP BY 1
                                         )                              
						AND (CLIENT_ID, ITEM_SID) IN
                                       (
                                         SELECT
                                               CLIENT_ID, ITEM_SID
                                         FROM P_LEW_CORE.T_ITEM_HIST_1
                                         WHERE TRUE
                                          -- QUALIFY ROW_NUMBER() OVER(PARTITION BY ITEM_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
                                         GROUP BY 1,2
                                       )
                       -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
                       QUALIFY ROW_NUMBER() OVER(PARTITION BY ITEM_SID ORDER BY DWH_UPDATED DESC) = 1

       ) itm
       ON TRUE
                       AND cp.CLIENT_ID = itm.CLIENT_ID
                       AND cp.ITEM_SID  = itm.ITEM_SID


		-- lookup item_sid orig_item_nr
		-- based on SRC_MATNR 
;

-- SELECT * FROM P_LEW_MART_PIT.V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1 WHERE TRUE AND CLIENT_ID = 10 AND NAT_THEME_TXT_UPPER != UPPER('Kein Werbethema Kategorie definiert (NAT)') LIMIT 100;
-- SELECT * FROM P_LEW_MART_PIT.V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_1 WHERE TRUE AND CLIENT_ID = 10 AND ORIG_ITEM_NR = 385752
