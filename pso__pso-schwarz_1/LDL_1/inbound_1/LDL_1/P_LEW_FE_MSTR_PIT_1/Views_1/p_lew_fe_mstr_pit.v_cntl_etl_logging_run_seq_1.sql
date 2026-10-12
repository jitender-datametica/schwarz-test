/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_CNTL_ETL_LOGGING_RUN_SEQ_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_CNTL_ETL_LOGGING_RUN_SEQ_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-04-18 Nikolai Toknov	   Initial version. Task DDLvsGIT. Created the file based on the object in PROD.
#  1.1  2025-02-04 Nikolai Toknov	   Drop VC columns MULTI_CLIENT_RUN_LST_NR, MULTI_CLIENT_RUN_LST_DESCR, MULTI_CLIENT_RUN_FG, ADV_WEEK_MSTR_ID
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_CNTL_ETL_LOGGING_RUN_SEQ_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_ETL_LOGGING_RUN_SEQ_1(
	RUN_ID_SEQ,
	RUN_TS_CHAR,
	RUN_DAY_ID_CHAR,
	RUN_TS,
	RUN_DAY_ID,
	RUN_CLUSTERING_DESC,
	CLIENT_ID,
	COUNTRY_DESCR,
	COUNTRY_ISO_CD,
	CURR_CD,
	MULTI_CLIENT_RUN_LST,
--	MULTI_CLIENT_RUN_LST_NR,
--	MULTI_CLIENT_RUN_LST_DESCR,
--	MULTI_CLIENT_RUN_FG,
	APPLICATION_NAME,
	START_DT_PIT_DATA,
	START_ADV_WEEK_PIT_DATA,
	START_DT_PIT_DAY_OF_WEEK_ISO_ID,
	START_DT_PIT_DAY_OF_WEEK_SDESC,
	START_DT_PIT_DAY_OF_WEEK_LDESC,
	END_DT_PIT_DATA,
	END_ADV_WEEK_PIT_DATA,
	END_DT_PIT_DAY_OF_WEEK_ISO_ID,
	END_DT_PIT_DAY_OF_WEEK_SDESC,
	END_DT_PIT_DAY_OF_WEEK_LDESC,
	PIT_DATA_DATE_RANGE_SDESC,
	NEXT_RUN_DT_REAGG,
	CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS,
	CNT_DATA_HISTORY_PIT_IN_DAYS,
	CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS,
	CNT_INTERMEDIATE_PERIOD_IN_DAYS,
	START_DT_INTERMEDIATE,
	END_DT_INTERMEDIATE,
	START_ADV_WEEK_INTERMEDIATE,
	END_ADV_WEEK_INTERMEDIATE,
	CNT_REAGG_PERIOD_IN_ADV_WEEKS,
	CNT_REAGG_PERIOD_IN_DAYS,
	START_DT_REAGG,
	END_DT_REAGG,
	START_ADV_WEEK_REAGG,
	END_ADV_WEEK_REAGG,
	CNT_BASELINE_ADV_WEEK,
	LOC_TIME_GAPS_OPENING_DAYS,
	LOC_TIME_GAPS_CLOSING_DAYS,
	WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS,
	LOC_STORE_SALES_NET_VAL_GT,
	LOC_STORE_SALES_QTY_GT,
	ADP_TIME_GAP_IN_DAYS,
	CTR_ADV_WEEK_START_WEEKDAY_ID,
	CTR_STORE_NBR,
	CTR_EX_ELVIS_COUNTRY_FG,
	START_DT_BASE_METRIC_NF_FA,
	END_DT_BASE_METRIC_NF_FA,
	START_DT_DELIV_QTY,
	END_DT_DELIV_QTY,
	START_DT_STC_REAL_QTY,
	END_DT_STC_REAL_QTY,
	EXEC_PIT_DAILY_RUN_FG,
	EXEC_PIT_WEEKLY_RUN_FG,
	EXEC_PIT_DQ_RUN_FG,
	EXEC_PIT_MANUAL_RUN_FG,
	EXEC_PIT_MANUAL_COUNTRY_LST,
	EXEC_PIT_RUN_WEEKLY_WEEKDAY,
	EXEC_PIT_CNT_INITIAL_ADV_WEEKS,
	EXEC_PIT_AB_PARALLEL_EXECUTION,
	EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS,
	DEFAULT_PIT_MANUAL_RUN_FG,
	PIT_MAX_DATA_HISTORY_IN_DAYS,
	PIT_MAX_DATA_HISTORY_IN_ADV_WEEK,
	EXEC_CLIENT_FG,
	DELETED_FG,
	DWH_CREATED_TS,
	DWH_UPDATED_TS,
	LOAD_ID,
	EXEC_PIT_RUN_TYPE_DESCR,
	MOVING_RUN_ID_FROM_CURRENT
) COMMENT='Access View Kontroll ETL Logging Running Sequence'
 AS
SELECT
      lg.RUN_ID_SEQ 
    , TO_CHAR(lg.RUN_TS, 'YYYY-MM_1-DD HH24:MI:SS.FF3')  AS RUN_TS_CHAR
    , TO_CHAR(lg.RUN_DAY_ID, 'YYYY-MM_1-DD')             AS RUN_DAY_ID_CHAR    
    , lg.RUN_TS
    , lg.RUN_DAY_ID
    , lg.RUN_CLUSTERING_DESC
    , lg.CLIENT_ID
	
	-- Additional columns for Country_1
    , COALESCE( cl.COUNTRY_DESCR	, iff( lg.CLIENT_ID = -2, 'Alle Länder','n/A' )) 	AS COUNTRY_DESCR
    , COALESCE( cl.COUNTRY_ISO_CD	, iff( lg.CLIENT_ID = -2, 'TOT','n/A' ))			AS COUNTRY_ISO_CD -- TOT ::= Total, Alle
    , COALESCE( cl.CURR_CD			, 'n/A')											AS CURR_CD
	
    , lg.MULTI_CLIENT_RUN_LST                                                  
--    , lg.MULTI_CLIENT_RUN_LST_NR                                                                                                                    
--    , lg.MULTI_CLIENT_RUN_LST_DESCR
--    , lg.MULTI_CLIENT_RUN_FG
    , lg.APPLICATION_NAME
	
    -- Execution Params
	-- Parameters pivoted only current view per client
	, lg.START_DT_PIT_DATA 																AS START_DT_PIT_DATA	
	, COALESCE(adw_s.ADV_WEEK_ID,888853::INTEGER)										AS START_ADV_WEEK_PIT_DATA -- unknownAdv. Week YYYYWW 8888-12-31 | 888853
	
    , date_part('dayofweekiso', lg.START_DT_PIT_DATA::DATE)								AS START_DT_PIT_DAY_OF_WEEK_ISO_ID

	-- Format Mo. Di.
 	, CASE 
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 1 THEN 'Mo.'
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 2 THEN 'Di.'
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 3 THEN 'Mi.'	
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 4 THEN 'Do.'
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 5 THEN 'Fr.'	
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 6 THEN 'Sa.'	
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 7 THEN 'So.' END 							AS START_DT_PIT_DAY_OF_WEEK_SDESC

	-- Format Montag Dienstag, etc.
   	, CASE 
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 1 THEN 'Montag'
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 2 THEN 'Dienstag'
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 3 THEN 'Mittwoch'	
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 4 THEN 'Donnerstag'
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 5 THEN 'Freitag'	
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 6 THEN 'Samstag'	
	   WHEN START_DT_PIT_DAY_OF_WEEK_ISO_ID = 7 THEN 'Sonntag' END 						AS START_DT_PIT_DAY_OF_WEEK_LDESC	
	
	, lg.END_DT_PIT_DATA 
	, COALESCE(adw_e.ADV_WEEK_ID,888853::INTEGER)										AS END_ADV_WEEK_PIT_DATA

    --, date_part('dayofweekiso', dateadd('days', (-1) , lg.END_DT_PIT_DATA::DATE))								AS END_DT_PIT_DAY_OF_WEEK_ISO_ID
	, date_part('dayofweekiso',  lg.END_DT_PIT_DATA::DATE)								AS END_DT_PIT_DAY_OF_WEEK_ISO_ID

	-- Format Mo. Di.
 	, CASE 
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 1 THEN 'Mo.'
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 2 THEN 'Di.'
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 3 THEN 'Mi.'	
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 4 THEN 'Do.'
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 5 THEN 'Fr.'	
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 6 THEN 'Sa.'	
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 7 THEN 'So.' END 							AS END_DT_PIT_DAY_OF_WEEK_SDESC

	-- Format Montag Dienstag, etc.
   	, CASE 
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 1 THEN 'Montag'
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 2 THEN 'Dienstag'
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 3 THEN 'Mittwoch'	
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 4 THEN 'Donnerstag'
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 5 THEN 'Freitag'	
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 6 THEN 'Samstag'	
	   WHEN END_DT_PIT_DAY_OF_WEEK_ISO_ID = 7 THEN 'Sonntag' END 						AS END_DT_PIT_DAY_OF_WEEK_LDESC	

	
	, START_DT_PIT_DAY_OF_WEEK_SDESC || '-' || END_DT_PIT_DAY_OF_WEEK_SDESC				AS PIT_DATA_DATE_RANGE_SDESC
	
    , lg.NEXT_RUN_DT_REAGG                                                                                   
    , lg.CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS                  
    , lg.CNT_DATA_HISTORY_PIT_IN_DAYS                                
    , lg.CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS          
    , lg.CNT_INTERMEDIATE_PERIOD_IN_DAYS                        
    , lg.START_DT_INTERMEDIATE                                                              
    , lg.END_DT_INTERMEDIATE                                                                  
    , lg.START_ADV_WEEK_INTERMEDIATE                               
    , lg.END_ADV_WEEK_INTERMEDIATE                                                 
    , lg.CNT_REAGG_PERIOD_IN_ADV_WEEKS                                        
    , lg.CNT_REAGG_PERIOD_IN_DAYS                                                      
    , lg.START_DT_REAGG                                                                                            
    , lg.END_DT_REAGG                                                                                               
    , lg.START_ADV_WEEK_REAGG                                                             
    , lg.END_ADV_WEEK_REAGG                                                                               
    , lg.CNT_BASELINE_ADV_WEEK                                                            
    , lg.LOC_TIME_GAPS_OPENING_DAYS                                                
    , lg.LOC_TIME_GAPS_CLOSING_DAYS                                                 
    , lg.WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS                             
    , lg.LOC_STORE_SALES_NET_VAL_GT                                                  
    , lg.LOC_STORE_SALES_QTY_GT                                                                          
    , lg.ADP_TIME_GAP_IN_DAYS                                                               
    , lg.CTR_ADV_WEEK_START_WEEKDAY_ID                                        
    , lg.CTR_STORE_NBR                                                                                              
    , lg.CTR_EX_ELVIS_COUNTRY_FG                                                         
    , lg.START_DT_BASE_METRIC_NF_FA                                                  
    , lg.END_DT_BASE_METRIC_NF_FA                                                     
    , lg.START_DT_DELIV_QTY                                                                                    
    , lg.END_DT_DELIV_QTY                                                                                        
    , lg.START_DT_STC_REAL_QTY                                                              
    , lg.END_DT_STC_REAL_QTY                                                                  
    , lg.EXEC_PIT_DAILY_RUN_FG                                                               
    , lg.EXEC_PIT_WEEKLY_RUN_FG                                                                          
    , lg.EXEC_PIT_DQ_RUN_FG                                                                                   
    , lg.EXEC_PIT_MANUAL_RUN_FG                                                                        
    , lg.EXEC_PIT_MANUAL_COUNTRY_LST                               
    , lg.EXEC_PIT_RUN_WEEKLY_WEEKDAY                                             
    , lg.EXEC_PIT_CNT_INITIAL_ADV_WEEKS                                           
    , lg.EXEC_PIT_AB_PARALLEL_EXECUTION                                          
    , lg.EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS              
    , lg.DEFAULT_PIT_MANUAL_RUN_FG                                                  
    , lg.PIT_MAX_DATA_HISTORY_IN_DAYS                                             
    , lg.PIT_MAX_DATA_HISTORY_IN_ADV_WEEK                   
    , lg.EXEC_CLIENT_FG
    
    -- technical fields
    , lg.DELETED_FG                                            
    , lg.DWH_CREATED_TS                 
    , lg.DWH_UPDATED_TS                
    , lg.LOAD_ID   
    
    -- Type of Loading regular Run | Manual Runs
    , iff( lg.LOAD_ID > 0 ,'Reguläre_1 Ausführung', 'Manulle Ausführung' )		AS EXEC_PIT_RUN_TYPE_DESCR
    
    , (DENSE_RANK () OVER (ORDER BY lg.RUN_ID_SEQ DESC) -1 ) * (-1) 			AS MOVING_RUN_ID_FROM_CURRENT
FROM 

	P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_RUN_SEQ_1 lg
	
	-- include country_1 Information 
	-- debugging information only
	LEFT JOIN
	(
		SELECT
			  CLIENT_ID
			, COUNTRY_DESCR
			, COUNTRY_ISO_CD
			, CURR_CD
		FROM P_LEW_MART_PIT.T_DIM_CLIENT_1
		WHERE TRUE
			AND DELETED_FG                  = 0
			AND REJECT_FG                   = 0
			AND CURRENT_FG                  = 1
			
			-- Only PIT countries
			AND PIT_COUNTRY_FG              = 1
			
		QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID)
	) cl
	ON TRUE
		AND cl.CLIENT_ID = lg.CLIENT_ID
		
	-- include adv_week_id for PIT_START_DT 
    LEFT JOIN 
    (
        SELECT
              CLIENT_ID 	
			, ADV_WEEK_ID
--			, ADV_WEEK_MSTR_ID
			, ADV_WEEK_START_DT 				
			, ADV_WEEK_END_DT
        FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK_1
        WHERE TRUE     
            AND DELETED_FG  	= 0::SMALLINT
            AND REJECT_FG   	= 0::SMALLINT
    ) adw_s
    ON TRUE
        AND adw_s.CLIENT_ID    = lg.CLIENT_ID
        AND lg.START_DT_PIT_DATA BETWEEN adw_s.ADV_WEEK_START_DT AND adw_s.ADV_WEEK_END_DT

   	-- include adv_week_id for PIT_END_DT 
    LEFT JOIN 
    (
        SELECT
              CLIENT_ID 	
			, ADV_WEEK_ID
--			, ADV_WEEK_MSTR_ID
			, ADV_WEEK_START_DT 				
			, ADV_WEEK_END_DT
        FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK_1
        WHERE TRUE     
            AND DELETED_FG  	= 0::SMALLINT
            AND REJECT_FG   	= 0::SMALLINT
    ) adw_e
    ON TRUE
        AND adw_e.CLIENT_ID    = lg.CLIENT_ID
        AND lg.END_DT_PIT_DATA BETWEEN adw_e.ADV_WEEK_START_DT AND adw_e.ADV_WEEK_END_DT
		
WHERE TRUE     
	AND lg.DELETED_FG       = 0
;