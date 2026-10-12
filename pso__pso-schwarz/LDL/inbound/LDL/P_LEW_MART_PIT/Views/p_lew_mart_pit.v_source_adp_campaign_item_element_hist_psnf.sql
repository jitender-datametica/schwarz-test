/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_PSNF
#-------------------------------------------------------------------------------
# Describtion: Create View for V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_PSNF
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2022-02-23 Nikolai Toknov 	Initial version
# 1.1 2022-03-03 Nikolai Toknov  	Add f_CleanValidToDate and T_CNTL_PROCESSING_PARAM_NORMALIZED
# 1.2 2022-03-29 Nikolai Toknov		Change join with t_item_hist 
# 1.3 2022-06-30 Nikolai Toknov		Drop "AND DELETED_FG = 0". This is WA for NSR3021858
# 1.4 2023-08-28 Nikolai Toknov		WA: Include all status for psnf
# 1.5 2024-09-23 Nikolai Toknov		Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_PSNF
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_ADP_CAMPAIGN_ITEM_ELEMENT_HIST_PSNF  
AS 
SELECT 
          cp.CLIENT_ID                                                                                                                              AS CLIENT_ID
        , cp.CAMPAIGN_ELEM_SID                                                                                                                      AS CAMPAIGN_ELEM_SID
        , COALESCE(cp.CAMPAIGN_SID, -1)::INTEGER                                                                                                    AS THEME_SID
        
        , CP.ITEM_SID                                                                                                                               AS ITEM_SID
        , COALESCE(TRY_TO_NUMBER(itm.SRC_ORIG_ITEM_NR), TRY_TO_NUMBER(itm.CONFIG_ITEM_CD), TRY_TO_NUMBER(itm.SRC_MATNR),-1)::NUMBER(38,0)           AS ORIG_ITEM_NR
        
        
        -- for information only 
        , cp.CAMPAIGN_ELEM_STATUS_CD                                                                                                                AS CAMPAIGN_ELEM_STATUS_CD 
                                        
        , COALESCE(cp.CAMPAIGN_ELEM_START_DT , TO_DATE('1900-01-01','YYYY-MM-DD'))   															 	AS CAMPAIGN_ELEM_START_DT
        , COALESCE(cp.CAMPAIGN_ELEM_END_DT , TO_DATE('9999-12-31','YYYY-MM-DD'))   											 						AS REAL_CAMPAIGN_ELEM_END_DT
 
        , cp.DELETED_FG 																															AS DELETED_FG
        
        , cp.DWH_VALID_FROM 																														AS DWH_VALID_FROM
        , COALESCE(P_LEW_MART_PIT.f_CleanValidToDate(cp.dwh_valid_to),'9999-12-31'::DATE)                                                							AS DWH_VALID_TO
                                                                                                                                                                                                                                                                                                                                    
FROM 
       
		(
         SELECT 
			*
         FROM P_LEW_CORE.T_CAMPAIGN_ELEMENT_HIST 
         WHERE TRUE 
                         -- AND CAMPAIGN_ELEM_STATUS_CD 	<> 'DRAFT' 
                         -- AND DELETED_FG					= 	0 -- v1.3
                         AND CLIENT_ID 				IN   (
															 -- PIT Country
															 SELECT
																			 CLIENT_ID
															 FROM P_LEW_MART_PIT.T_DIM_CLIENT
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
       
       -- Join to item 
       INNER JOIN 
       (
                       SELECT 
						*
                       FROM P_LEW_CORE.T_ITEM
                       WHERE TRUE
                       AND CLIENT_ID IN (
                                         -- PIT Country
                                         SELECT
                                               CLIENT_ID
                                         FROM P_LEW_MART_PIT.T_DIM_CLIENT
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
                                         FROM P_LEW_CORE.T_ITEM_HIST
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
