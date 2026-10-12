/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for V_CNTL_PROCESSING_PARAM_NORMALIZED_2
#-------------------------------------------------------------------------------
# Describtion: Create View for Processing Param Normalized
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-15 Andreas Kurz	    Initial version
#  1.1	2023-01-27 Andreas Kurz		Typecast 888853::INTEGER for PIT Start/End DT
#  1.2  2025-02-05 Andreas Kurz		Changed structure and Added new columns for possible cube load restrictions
#										START_ADV_WEEK_ID_CUBE_LOAD
#										END_ADV_WEEK_ID_CUBE_LOAD
#  1.3 2025-09-13 Andreas Kurz		Changes to refere only (ADV_WEEK_ID * 100) + CLIENT_ID 	AS ADV_WEEK_MSTR_ID	
#									and P_LEW_MART_PIT.T_DIM_ADV_WEEK_2
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--Between(Werbewoche@ID,   [Start Adv Week Id Increment Cube Load],[End Adv Week Id Increment Cube Load])
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_PROCESSING_PARAM_NORMALIZED_2
COMMENT = 'View Processing Param Normalize'
AS
SELECT
	  pa.CLIENT_ID 	
    , cl.COUNTRY_ISO_CD
    , cl.COUNTRY_DESCR  	  
	, cl.CURR_CD 											
	, cl.EXCHANGE_RATE_TO_EUR 								

		-- Parameters pivoted only current view per client
	, pa.START_DT_PIT_DATA 	
	, COALESCE(adw_s.ADV_WEEK_ID,888853::INTEGER)				AS START_ADV_WEEK_PIT_DATA
	
	, pa.END_DT_PIT_DATA 
	, COALESCE(adw_e.ADV_WEEK_ID,888853::INTEGER)				AS END_ADV_WEEK_PIT_DATA
	
	-- Based on Manual Run FG decide which period should be refreshed in MSTR Cubes
	, CASE
		WHEN pa.EXEC_PIT_MANUAL_RUN_FG = 3 THEN
			adw_scube.ADV_WEEK_ID
		ELSE
			COALESCE(adw_scube.ADV_WEEK_ID,888853)				
	  END 												AS START_ADV_WEEK_ID_CUBE_LOAD 	

	, CASE
		WHEN pa.EXEC_PIT_MANUAL_RUN_FG = 3 THEN
			adw_scube.ADV_WEEK_MSTR_ID
		ELSE
			COALESCE(adw_scube.ADV_WEEK_MSTR_ID,888853*100 + pa.CLIENT_ID)				
	  END 												AS START_ADV_WEEK_MSTR_ID_CUBE_LOAD 		  

	, CASE
		WHEN pa.EXEC_PIT_MANUAL_RUN_FG = 3 THEN
			pa.END_ADV_WEEK_INTERMEDIATE
		ELSE
			COALESCE(adw_e.ADV_WEEK_ID,888853)				
	  END 												AS END_ADV_WEEK_ID_CUBE_LOAD 	

	, CASE
		WHEN pa.EXEC_PIT_MANUAL_RUN_FG = 3 THEN
			(pa.END_ADV_WEEK_INTERMEDIATE * 100 ) + pa.CLIENT_ID
		ELSE
			COALESCE(adw_e.ADV_WEEK_MSTR_ID,888853*100 + pa.CLIENT_ID)				
	  END 												AS END_ADV_WEEK_MSTR_ID_CUBE_LOAD 		  
	  		
	
	, pa.NEXT_RUN_DT_REAGG 						
	, pa.CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS 		
	, pa.CNT_DATA_HISTORY_PIT_IN_DAYS 			
	, pa.CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS 	
	, pa.CNT_INTERMEDIATE_PERIOD_IN_DAYS 		
	, pa.START_DT_INTERMEDIATE 					
	, pa.END_DT_INTERMEDIATE 					
	, pa.START_ADV_WEEK_INTERMEDIATE 			
	, pa.END_ADV_WEEK_INTERMEDIATE 				
	, pa.CNT_REAGG_PERIOD_IN_ADV_WEEKS 			
	, pa.CNT_REAGG_PERIOD_IN_DAYS 				
	, pa.START_DT_REAGG 							
	, pa.END_DT_REAGG 							
	, pa.START_ADV_WEEK_REAGG 					
	, pa.END_ADV_WEEK_REAGG 						
	, pa.CNT_BASELINE_ADV_WEEK 					
	, pa.LOC_TIME_GAPS_OPENING_DAYS 				
	, pa.LOC_TIME_GAPS_CLOSING_DAYS 				
	, pa.WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS 		
	, pa.LOC_STORE_SALES_NET_VAL_GT 				
	, pa.LOC_STORE_SALES_QTY_GT 					
	, pa.ADP_TIME_GAP_IN_DAYS 					
	, pa.CTR_ADV_WEEK_START_WEEKDAY_ID 			
	, pa.CTR_STORE_NBR 							
	, pa.CTR_EX_ELVIS_COUNTRY_FG 
	
	, cl.CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_FROM			
	, cl.CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO 
	
	, pa.START_DT_BASE_METRIC_NF_FA 				
	, pa.END_DT_BASE_METRIC_NF_FA 				
	, pa.START_DT_DELIV_QTY 						
	, pa.END_DT_DELIV_QTY 						
	, pa.START_DT_STC_REAL_QTY 					
	, pa.END_DT_STC_REAL_QTY 					
	, pa.EXEC_PIT_DAILY_RUN_FG 					
	, pa.EXEC_PIT_WEEKLY_RUN_FG 					
	, pa.EXEC_PIT_DQ_RUN_FG 						
	, pa.EXEC_PIT_MANUAL_RUN_FG 					
	, pa.EXEC_PIT_MANUAL_COUNTRY_LST 			
	, pa.EXEC_PIT_RUN_WEEKLY_WEEKDAY 			
	, pa.EXEC_PIT_CNT_INITIAL_ADV_WEEKS 			
	, pa.EXEC_PIT_AB_PARALLEL_EXECUTION 			
	, pa.EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS 	
	, pa.DEFAULT_PIT_MANUAL_RUN_FG				
	, pa.PIT_MAX_DATA_HISTORY_IN_DAYS 			
	, pa.PIT_MAX_DATA_HISTORY_IN_ADV_WEEK
	
	, pa.PV_PERIOD_LENGTH_MAX
	, pa.PV_PERIOD_GAP_SPLITTING_DAYS
	, pa.LP_ORIG_COUPON_TYPE_SID
	, pa.LP_COUPON_PROMO_TYPE_SID
	, pa.FA_OVERLAP_PERIOD_ACTION_TYPE_CONDITION
	, pa.WAWI_PRICE_CHANGE_GAP_IN_DAYS
	, pa.REJECT_PERIOD
	, pa.LP_SHIFT_PERIOD_START_DT
	, pa.REJECT_WAWI_PV_LONG_PERIOD	
FROM 
	P_LEW_MART_PIT.T_CNTL_PROCESSING_PARAM_NORMALIZED_2 pa

	-- include country_2 Information 
	-- debugging information only 
    INNER JOIN 
    (
        SELECT
              CLIENT_ID 	
			, COUNTRY_ISO_CD
			, COUNTRY_DESCR  
			, CURR_CD 											
			, EXCHANGE_RATE_TO_EUR 															
			, CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_FROM			
			, CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO 				
        FROM P_LEW_MART_PIT.T_DIM_CLIENT_2
        WHERE TRUE     
            AND DELETED_FG  	= 0::SMALLINT
            AND REJECT_FG   	= 0::SMALLINT
            AND CURRENT_FG  	= 1::SMALLINT
			
			-- Only PIT countries
            AND PIT_COUNTRY_FG	= 1::SMALLINT
		
		QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID)
    ) cl
    ON TRUE
        AND cl.CLIENT_ID    = pa.CLIENT_ID

	-- include adv_week_id for PIT_START_DT 
    LEFT JOIN 
    (
        SELECT
              CLIENT_ID 	
			, ADV_WEEK_ID
			, (ADV_WEEK_ID * 100) + CLIENT_ID 	AS ADV_WEEK_MSTR_ID	
			, ADV_WEEK_START_DT 				
			, ADV_WEEK_END_DT
        FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK_2
        WHERE TRUE     
            AND DELETED_FG  	= 0::SMALLINT
            AND REJECT_FG   	= 0::SMALLINT
    ) adw_s
    ON TRUE
        AND adw_s.CLIENT_ID    = pa.CLIENT_ID
        AND pa.START_DT_PIT_DATA BETWEEN adw_s.ADV_WEEK_START_DT AND adw_s.ADV_WEEK_END_DT

   	-- include adv_week_id for PIT_END_DT 
    LEFT JOIN 
    (
        SELECT
              CLIENT_ID 	
			, ADV_WEEK_ID
			, (ADV_WEEK_ID * 100) + CLIENT_ID 	AS ADV_WEEK_MSTR_ID	
			, ADV_WEEK_START_DT 				
			, ADV_WEEK_END_DT
        FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK_2
        WHERE TRUE     
            AND DELETED_FG  	= 0::SMALLINT
            AND REJECT_FG   	= 0::SMALLINT
    ) adw_e
    ON TRUE
        AND adw_e.CLIENT_ID    = pa.CLIENT_ID
        AND pa.END_DT_PIT_DATA BETWEEN adw_e.ADV_WEEK_START_DT AND adw_e.ADV_WEEK_END_DT
 
	-- include adv_week_id for PIT_START_DT - PIT_MAX_DATA_HISTORY_IN_DAYS
    LEFT JOIN 
    (
        SELECT
              CLIENT_ID 	
			, ADV_WEEK_ID
			, (ADV_WEEK_ID * 100) + CLIENT_ID 	AS ADV_WEEK_MSTR_ID	
			, ADV_WEEK_START_DT 				
			, ADV_WEEK_END_DT
        FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK_2
        WHERE TRUE     
            AND DELETED_FG  	= 0::SMALLINT
            AND REJECT_FG   	= 0::SMALLINT
    ) adw_scube
    ON TRUE
        AND adw_scube.CLIENT_ID    = pa.CLIENT_ID
        AND DATEADD('days',pa.PIT_MAX_DATA_HISTORY_IN_DAYS * (-1), pa.END_DT_PIT_DATA) BETWEEN adw_scube.ADV_WEEK_START_DT AND adw_scube.ADV_WEEK_END_DT
        
        
WHERE TRUE
;

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_CNTL_PROCESSING_PARAM_NORMALIZED_2 WHERE TRUE AND CLIENT_ID = 1