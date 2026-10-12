/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_StartLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1	2023-05-24 Andreas Kurz		Changed return Value to RUNIDSEQ
#									and chenged logic of retrieving RUNIDSEQ upfront
#  1.2  2023-06-28 Andreas Kurz		Changed retrieving RUNSEQID upfront to combine from
#									seq and logging
#  2.0  2023-06-02 Nikolai Toknov  add parameter pPITLogging
#  2.1	2023-08-14 Andreas Kurz	   changed update to insert
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS;
USE SCHEMA 		P_LEW_MART_PIT_1;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

/*
---------------------------------------------------------------------
PROCEDURE	:	sp_StartLogging(pLoadID	STRING, pApplicationName STRING, pRunClusteringDesc STRING, pQueryTag STRING, pSchema STRING)
Input		:   
				pLoadID				STRING --> ETL Load ID YYYYMMDDHHMMSSNNN * 100 + CLIENT_ID [All 99]
				pApplicationName 	STRING 
				pRunClusteringDesc 	STRING --> [0] running in sequence
				pQueryTag 			STRING
				pPITLogging			FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
				
Return		:	Error + Error Msg
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	CALL sp_StartLogging('123','PITonCloud','[0]',f_QueryTag('ETL Logging','PITonCloud',NULL),'P_LEW_MART_PIT_1', 1);
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_StartLogging (
	  pLoadID				STRING      
	, pApplicationName      STRING 
    , pRunClusteringDesc    STRING    
    , pQueryTag             STRING
	, pSchema				STRING
	, pPITLogging			FLOAT
)
  RETURNS STRING
  LANGUAGE javascript
  AS
  $$
		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";
		var strSchema = "P_LEW_MART_PIT_1";
		var strLoadID = "-2";
		var intLoggingLevel = 3;

		// CHECK INPUT pPITLogging 
		if ((PPITLOGGING === "") || (typeof(PPITLOGGING) === "undefined") || (PPITLOGGING.length === 0) || (PPITLOGGING === null)) { 
			PPITLOGGING = intLoggingLevel; 
		} else {
			intLoggingLevel = PPITLOGGING;
		}
			
		//v2.0
		if (intLoggingLevel>=1)
		{
			
			// CHECK INPUT pParamValueChar 
			if ((PLOADID === "") || (typeof(PLOADID) === "undefined")  || (PLOADID.length === 0) || (PLOADID === null)) { 
				PLOADID = strLoadID; 
			} else {
				strLoadID = PLOADID.toUpperCase();
			}			
			
			// CHECK INPUT runcluster 
			if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
				PRUNCLUSTERINGDESC = strRunCluster; 
			} else {
				strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
			}
			
			strRunCluster = strRunCluster.replace(/\[(.*)\]/g,"$1");
			
			// CHECK INPUT pSchema 
			if ((PSCHEMA === "") || (typeof(PSCHEMA) === "undefined") || (PSCHEMA.length === 0) || (PSCHEMA === null)) { 
				PSCHEMA = strSchema; 
			} else {
				strSchema = PSCHEMA.toUpperCase();
			}		
			
			sqlStmt = "";
			sqlStmt = `		
				SELECT
					  TO_CHAR(CURRENT_TIMESTAMP(), 'YYYY-MM_1-DD HH24:MI:SS.FF3' ) 	AS RUN_TS
					, TO_CHAR(CURRENT_DATE(),'YYYY-MM_1-DD') 							AS RUN_DAY_ID
					, GREATEST(logs.RUN_ID_SEQ, log.RUN_ID_SEQ)						AS RUN_ID_SEQ
				FROM
				(
					SELECT
						COALESCE(logs.RUN_ID_SEQ,0)+1								AS RUN_ID_SEQ
					FROM 
					(
						SELECT 
							MAX(RUN_ID_SEQ) AS RUN_ID_SEQ 
						FROM #PSCHEMA#.T_CNTL_ETL_LOGGING_RUN_SEQ_1
						WHERE TRUE	
							--AND RUN_CLUSTERING_DESC 	= '#RUNCLUSTER#' 
							--AND APPLICATION_NAME 		= '#PAPPLICATIONNAME#'
							AND DELETED_FG 				= 0
					) logs
				) logs				
				CROSS JOIN				
				(
					SELECT
						COALESCE(log.RUN_ID_SEQ,0)+1								AS RUN_ID_SEQ
					FROM 
					(
						SELECT 
							MAX(RUN_ID_SEQ) AS RUN_ID_SEQ 
						FROM #PSCHEMA#.T_CNTL_ETL_LOGGING_1
						WHERE TRUE	
							--AND RUN_CLUSTERING_DESC 	= '#RUNCLUSTER#' 
							--AND APPLICATION_NAME 		= '#PAPPLICATIONNAME#'
							AND DELETED_FG 				= 0
					) log	
				) log		
		`;
	
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
			sqlStmt = sqlStmt.replace(/#RUNCLUSTER#/g,strRunCluster.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
			sqlStmt = sqlStmt.replace(/#PLOADID#/g,strLoadID);

			
			
			// Retrieve next Seq RunID
			try{
				snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
				var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
			
				msg = "P_STARTPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;
			}
			res.next();
			// res.getColumnValue(1) = RUN_ID_SEQ

			sqlStmt = "";
			sqlStmt = `
				INSERT INTO #PSCHEMA#.T_CNTL_ETL_LOGGING_1 
					( 
						  RUN_ID_SEQ
						, RUN_TS
						, RUN_DAY_ID
						, RUN_CLUSTERING_DESC
						, APPLICATION_NAME
						, MODULE_NAME
						, COMPONENT_NAME
						, QUERY_TAG
						, START_PROCESSING_FG
						, LOAD_ID
						, MULTI_CLIENT_RUN_LST
						, DWH_CREATED_TS
						, CLIENT_ID
						, START_RUN_TS
					) 
				SELECT 
					  #RUNIDSEQ#
					, TRY_TO_TIMESTAMP('#RUNTS#', 'YYYY-MM_1-DD HH24:MI:SS.FF3')
					, TRY_TO_DATE('#RUNDAYID#', 'YYYY-MM_1-DD')
					, '[' || '#RUNCLUSTER#' || ']' 										AS RUN_CLUSTERING_DESC
					, '#PAPPLICATIONNAME#'
					, '>>>Start Logging<<<'
					, '>>>Start Logging<<<'
					, '#QUERYTAG#'
					, 1::SMALLINT
					, COALESCE(try_to_number('#PLOADID#'),-2)::INTEGER					AS LOAD_ID
					, STRTOK_TO_ARRAY('#RUNCLUSTER#', ',')								AS MULTI_CLIENT_RUN_LST
					, CURRENT_TIMESTAMP() 												AS DWH_CREATED_TS
					, iff(
						ARRAY_POSITION('0'::VARIANT,MULTI_CLIENT_RUN_LST) IS NULL AND ARRAY_SIZE (MULTI_CLIENT_RUN_LST) = 1
						,COALESCE(TRY_TO_NUMBER('#RUNCLUSTER#'),-2::INTEGER)
						,-2::INTEGER
						)																AS CLIENT_ID
					, CURRENT_TIMESTAMP()												AS START_RUN_TS
			`;
			
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#RUNIDSEQ#/g,res.getColumnValue(3));
			sqlStmt = sqlStmt.replace(/#RUNTS#/g,res.getColumnValue(1));
			sqlStmt = sqlStmt.replace(/#RUNDAYID#/g,res.getColumnValue(2));	
			
			sqlStmt = sqlStmt.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
			sqlStmt = sqlStmt.replace(/#RUNCLUSTER#/g,strRunCluster.toUpperCase());
			sqlStmt = sqlStmt.replace(/#QUERYTAG#/g,PQUERYTAG.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
			sqlStmt = sqlStmt.replace(/#PLOADID#/g,strLoadID);		


			try{
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
				msg = "P_STARTPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;			
			}

			sqlStmt = "";
			sqlStmt = `
				INSERT INTO #PSCHEMA#.T_CNTL_ETL_LOGGING_RUN_SEQ_1 
					(
						  RUN_ID_SEQ
						, RUN_TS
						, RUN_DAY_ID
						, RUN_CLUSTERING_DESC
						, APPLICATION_NAME
						, LOAD_ID
						, MULTI_CLIENT_RUN_LST
						, DWH_CREATED_TS
						, CLIENT_ID	
						, START_DT_PIT_DATA 						
						, END_DT_PIT_DATA 						
						, NEXT_RUN_DT_REAGG 						
						, CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS		
						, CNT_DATA_HISTORY_PIT_IN_DAYS			
						, CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS	
						, CNT_INTERMEDIATE_PERIOD_IN_DAYS		
						, START_DT_INTERMEDIATE					
						, END_DT_INTERMEDIATE 					
						, START_ADV_WEEK_INTERMEDIATE			
						, END_ADV_WEEK_INTERMEDIATE				
						, CNT_REAGG_PERIOD_IN_ADV_WEEKS			
						, CNT_REAGG_PERIOD_IN_DAYS				
						, START_DT_REAGG 						
						, END_DT_REAGG 							
						, START_ADV_WEEK_REAGG					
						, END_ADV_WEEK_REAGG						
						, CNT_BASELINE_ADV_WEEK					
						, LOC_TIME_GAPS_OPENING_DAYS				
						, LOC_TIME_GAPS_CLOSING_DAYS				
						, WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS		
						, LOC_STORE_SALES_NET_VAL_GT				
						, LOC_STORE_SALES_QTY_GT					
						, ADP_TIME_GAP_IN_DAYS					
						, CTR_ADV_WEEK_START_WEEKDAY_ID			
						, CTR_STORE_NBR							
						, CTR_EX_ELVIS_COUNTRY_FG				
						, START_DT_BASE_METRIC_NF_FA 			
						, END_DT_BASE_METRIC_NF_FA 				
						, START_DT_DELIV_QTY 					
						, END_DT_DELIV_QTY 						
						, START_DT_STC_REAL_QTY 					
						, END_DT_STC_REAL_QTY 					
						, EXEC_PIT_DAILY_RUN_FG					
						, EXEC_PIT_WEEKLY_RUN_FG					
						, EXEC_PIT_DQ_RUN_FG						
						, EXEC_PIT_MANUAL_RUN_FG 				
						, EXEC_PIT_MANUAL_COUNTRY_LST 			
						, EXEC_PIT_RUN_WEEKLY_WEEKDAY			
						, EXEC_PIT_CNT_INITIAL_ADV_WEEKS			
						, EXEC_PIT_AB_PARALLEL_EXECUTION	
						, EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS
						, DEFAULT_PIT_MANUAL_RUN_FG
						, PIT_MAX_DATA_HISTORY_IN_DAYS
						, PIT_MAX_DATA_HISTORY_IN_ADV_WEEK	
						, EXEC_CLIENT_FG					
				)
				SELECT
					rseq.RUN_ID_SEQ
					, rseq.RUN_TS
					, rseq.RUN_DAY_ID
					, rseq.RUN_CLUSTERING_DESC
					, rseq.APPLICATION_NAME
					, rseq.LOAD_ID
					, rseq.MULTI_CLIENT_RUN_LST
					, rseq.DWH_CREATED_TS
					, rseq.CLIENT_ID	
					
					-- Current Parameters
					, COALESCE(pa.START_DT_PIT_DATA 					, '8888-12-31'::DATE ) 	AS 	START_DT_PIT_DATA 					
					, COALESCE(pa.END_DT_PIT_DATA 						, '8888-12-31'::DATE) 	AS  END_DT_PIT_DATA 						
					, COALESCE(pa.NEXT_RUN_DT_REAGG 					, '8888-12-31'::DATE) 	AS 	NEXT_RUN_DT_REAGG 					
					, COALESCE(pa.CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS		, -1::INTEGER) 			AS  CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS		
					, COALESCE(pa.CNT_DATA_HISTORY_PIT_IN_DAYS			, -1::INTEGER) 			AS  CNT_DATA_HISTORY_PIT_IN_DAYS			
					, COALESCE(pa.CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS	, -1::INTEGER) 			AS  CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS
					, COALESCE(pa.CNT_INTERMEDIATE_PERIOD_IN_DAYS		, -1::INTEGER) 			AS  CNT_INTERMEDIATE_PERIOD_IN_DAYS		
					, COALESCE(pa.START_DT_INTERMEDIATE					, '8888-12-31'::DATE) 	AS  START_DT_INTERMEDIATE					
					, COALESCE(pa.END_DT_INTERMEDIATE 					, '8888-12-31'::DATE) 	AS  END_DT_INTERMEDIATE 					
					, COALESCE(pa.START_ADV_WEEK_INTERMEDIATE			, -1::INTEGER) 			AS  START_ADV_WEEK_INTERMEDIATE			
					, COALESCE(pa.END_ADV_WEEK_INTERMEDIATE				, -1::INTEGER) 			AS  END_ADV_WEEK_INTERMEDIATE				
					, COALESCE(pa.CNT_REAGG_PERIOD_IN_ADV_WEEKS			, -1::INTEGER) 			AS  CNT_REAGG_PERIOD_IN_ADV_WEEKS			
					, COALESCE(pa.CNT_REAGG_PERIOD_IN_DAYS				, -1::INTEGER) 			AS  CNT_REAGG_PERIOD_IN_DAYS				
					, COALESCE(pa.START_DT_REAGG 						, '8888-12-31'::DATE) 	AS  START_DT_REAGG 						
					, COALESCE(pa.END_DT_REAGG 							, '8888-12-31'::DATE) 	AS  END_DT_REAGG 							
					, COALESCE(pa.START_ADV_WEEK_REAGG					, -1::INTEGER) 			AS  START_ADV_WEEK_REAGG					
					, COALESCE(pa.END_ADV_WEEK_REAGG					, -1::INTEGER) 			AS 	END_ADV_WEEK_REAGG					
					, COALESCE(pa.CNT_BASELINE_ADV_WEEK					, -1::INTEGER) 			AS  CNT_BASELINE_ADV_WEEK					
					, COALESCE(pa.LOC_TIME_GAPS_OPENING_DAYS			, -1::INTEGER) 			AS 	LOC_TIME_GAPS_OPENING_DAYS			
					, COALESCE(pa.LOC_TIME_GAPS_CLOSING_DAYS			, -1::INTEGER) 			AS 	LOC_TIME_GAPS_CLOSING_DAYS			
					, COALESCE(pa.WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS	, -1::INTEGER) 			AS 	WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS	
					, COALESCE(pa.LOC_STORE_SALES_NET_VAL_GT			, -1::INTEGER) 			AS 	LOC_STORE_SALES_NET_VAL_GT			
					, COALESCE(pa.LOC_STORE_SALES_QTY_GT				, -1::INTEGER) 			AS 	LOC_STORE_SALES_QTY_GT				
					, COALESCE(pa.ADP_TIME_GAP_IN_DAYS					, -1::INTEGER) 			AS  ADP_TIME_GAP_IN_DAYS					
					, COALESCE(pa.CTR_ADV_WEEK_START_WEEKDAY_ID			, -1::INTEGER) 			AS  CTR_ADV_WEEK_START_WEEKDAY_ID			
					, COALESCE(pa.CTR_STORE_NBR							, -1::SMALLINT) 		AS  CTR_STORE_NBR							
					, COALESCE(pa.CTR_EX_ELVIS_COUNTRY_FG				, -1::SMALLINT) 		AS  CTR_EX_ELVIS_COUNTRY_FG				
					, COALESCE(pa.START_DT_BASE_METRIC_NF_FA 			, -1::INTEGER) 			AS  START_DT_BASE_METRIC_NF_FA 			
					, COALESCE(pa.END_DT_BASE_METRIC_NF_FA 				, -1::INTEGER) 			AS  END_DT_BASE_METRIC_NF_FA 				
					, COALESCE(pa.START_DT_DELIV_QTY 					, -1::INTEGER) 			AS  START_DT_DELIV_QTY 					
					, COALESCE(pa.END_DT_DELIV_QTY 						, -1::INTEGER) 			AS  END_DT_DELIV_QTY 						
					, COALESCE(pa.START_DT_STC_REAL_QTY 				, -1::INTEGER) 			AS 	START_DT_STC_REAL_QTY 				
					, COALESCE(pa.END_DT_STC_REAL_QTY 					, -1::INTEGER) 			AS  END_DT_STC_REAL_QTY 					
					, COALESCE(pa.EXEC_PIT_DAILY_RUN_FG					, -1::SMALLINT) 		AS  EXEC_PIT_DAILY_RUN_FG					
					, COALESCE(pa.EXEC_PIT_WEEKLY_RUN_FG				, -1::SMALLINT) 		AS 	EXEC_PIT_WEEKLY_RUN_FG				
					, COALESCE(pa.EXEC_PIT_DQ_RUN_FG					, -1::SMALLINT) 		AS 	EXEC_PIT_DQ_RUN_FG					
					, COALESCE(pa.EXEC_PIT_MANUAL_RUN_FG 				, -1::SMALLINT) 		AS  EXEC_PIT_MANUAL_RUN_FG 				
					, COALESCE(pa.EXEC_PIT_MANUAL_COUNTRY_LST 			, NULL) 				AS  EXEC_PIT_MANUAL_COUNTRY_LST 			
					, COALESCE(pa.EXEC_PIT_RUN_WEEKLY_WEEKDAY			, -1::INTEGER) 			AS  EXEC_PIT_RUN_WEEKLY_WEEKDAY			
					, COALESCE(pa.EXEC_PIT_CNT_INITIAL_ADV_WEEKS		, -1::INTEGER) 			AS 	EXEC_PIT_CNT_INITIAL_ADV_WEEKS		
					, COALESCE(pa.EXEC_PIT_AB_PARALLEL_EXECUTION	    , -1::INTEGER) 			AS  EXEC_PIT_AB_PARALLEL_EXECUTION	  
					, COALESCE(pa.EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS  , -1::INTEGER) 			AS  EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS
					, COALESCE(pa.DEFAULT_PIT_MANUAL_RUN_FG             , -1::SMALLINT) 		AS  DEFAULT_PIT_MANUAL_RUN_FG           
					, COALESCE(pa.PIT_MAX_DATA_HISTORY_IN_DAYS          , -1::INTEGER) 			AS  PIT_MAX_DATA_HISTORY_IN_DAYS        
					, COALESCE(pa.PIT_MAX_DATA_HISTORY_IN_ADV_WEEK	    , -1::INTEGER) 			AS  PIT_MAX_DATA_HISTORY_IN_ADV_WEEK	  
					, COALESCE(pa.EXEC_CLIENT_FG                        , -1::SMALLINT)			AS  EXEC_CLIENT_FG                      
				FROM 
				-- Run Sequence
				(
					SELECT 
						  #RUNIDSEQ#														AS RUN_ID_SEQ
						, TRY_TO_TIMESTAMP('#RUNTS#', 'YYYY-MM_1-DD HH24:MI:SS.FF3')			AS RUN_TS			
						, TRY_TO_DATE('#RUNDAYID#', 'YYYY-MM_1-DD')							AS RUN_DAY_ID
						, '[' || '#RUNCLUSTER#' || ']' 										AS RUN_CLUSTERING_DESC
						, '#PAPPLICATIONNAME#'												AS APPLICATION_NAME
						, COALESCE(try_to_number('#PLOADID#'),-2)::INTEGER					AS LOAD_ID
						, STRTOK_TO_ARRAY( '#RUNCLUSTER#',',' )	AS MULTI_CLIENT_RUN_LST
						, CURRENT_TIMESTAMP() 												AS DWH_CREATED_TS
						, iff(
							ARRAY_POSITION('0'::VARIANT,MULTI_CLIENT_RUN_LST) IS NULL AND ARRAY_SIZE (MULTI_CLIENT_RUN_LST) = 1
							,COALESCE(TRY_TO_NUMBER('#RUNCLUSTER#'),-2::INTEGER)
							,-2::INTEGER
							)																AS CLIENT_ID
				) rseq
				
				-- Current Prameter Setting
				LEFT JOIN
				(
				SELECT
					  pa.CLIENT_ID
					, pa.START_DT_PIT_DATA 						
					, pa.END_DT_PIT_DATA 						
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
					, iff( 	
							(
								TRUE
								AND pa.EXEC_PIT_DAILY_RUN_FG 											= 1 
								AND DATE_PART('dayofweekiso', TRY_TO_DATE('#RUNDAYID#', 'YYYY-MM_1-DD')) 	= pa.EXEC_PIT_RUN_WEEKLY_WEEKDAY
								AND TRY_TO_DATE('#RUNDAYID#', 'YYYY-MM_1-DD')								= pa.NEXT_RUN_DT_REAGG
							)
							OR
							(
								TRUE
								AND pa.EXEC_PIT_WEEKLY_RUN_FG 											= 1 
								AND DATE_PART('dayofweekiso', TRY_TO_DATE('#RUNDAYID#', 'YYYY-MM_1-DD')) 	= pa.EXEC_PIT_RUN_WEEKLY_WEEKDAY
							)
						, 1::SMALLINT
						, 0::SMALLINT
						)											AS EXEC_CLIENT_FG	
				FROM #PSCHEMA#.T_CNTL_PROCESSING_PARAM_NORMALIZED_1 pa
				WHERE TRUE
				) pa
				ON TRUE
					AND pa.CLIENT_ID = rseq.CLIENT_ID					
			`;
			
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#RUNIDSEQ#/g,res.getColumnValue(3));
			sqlStmt = sqlStmt.replace(/#RUNTS#/g,res.getColumnValue(1));
			sqlStmt = sqlStmt.replace(/#RUNDAYID#/g,res.getColumnValue(2));
			
			sqlStmt = sqlStmt.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
			sqlStmt = sqlStmt.replace(/#RUNCLUSTER#/g,strRunCluster.toUpperCase());
			sqlStmt = sqlStmt.replace(/#QUERYTAG#/g,PQUERYTAG.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);	
			sqlStmt = sqlStmt.replace(/#PLOADID#/g,strLoadID);			
			
			try{
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
				snowflake.createStatement( { sqlText: sqlCommit } ).execute();
			} catch (ERROR){
				msg = "P_STARTPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;			
			}
			//res.next();

			// return run seq
			return res.getColumnValue(3);
		}			
$$
; -- End of sp_StartLogging
-- LOAD_ID :: 2022091215000000001
--CALL sp_StartLogging('${LOAD_ID}', 'PITonCloud','[12]',f_QueryTag('Initialize Logging','PITonCloud','[12]'),'P_LEW_MART_PIT_1')
--SELECT * FROM P_LEW_MART_PIT.V_CNTL_ETL_LOGGING_1 lg WHERE TRUE AND MOVING_RUN_ID_FROM_CURRENT = 0 ORDER BY RUN_ID_SEQ, RUN_TS;
--SELECT * FROM v_cntl_etl_logging_run_seq_1 WHERE TRUE AND MOVING_RUN_ID_FROM_CURRENT = 0 ORDER BY RUN_ID_SEQ, RUN_TS;
-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));
