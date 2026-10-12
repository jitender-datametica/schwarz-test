/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_HousekeepingCleanTables
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-05-14 Nikolai Toknov    	Initial version
#  1.0  2024-06-14 Nikolai Toknov    	Optimization 
#  1.1  2025-06-11 Nikolai Toknov		Rename GetPrevParamsValue -> f_GetPrevParamsValue
#-------------------------------------------------------------------------------
*/

/* TO DO: update description
---------------------------------------------------------------------
PROCEDURE	:	sp_HousekeepingCleanTables(pSchema STRING, pTableName STRING )
Input		:   pClientId 				DOUBLE 
				pAdwWeekCnt				DOUBLE 
			 	pHouskeepingMode		STRING  #Method for processing old records. Options: UPDATE, DELETE, NONE (there will be no changing of old rows)
				pApplicationName		STRING	#HOUSEKEEPING
				pPITLoggingLevel		DOUBLE	#0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
				pLoadID					DOUBLE		
Return		:	Error + Error Msg or in success case name of backuped table
Convert		:	None    
Description	: 	
Example		:	Call P_LEW_MART_PIT.sp_HousekeepingCleanTables(1,500,'UPDATE','HOUSEKEEPING',3,0);
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_HousekeepingCleanTables (
	  pClientId 				DOUBLE 
	, pAdwWeekCnt				DOUBLE
	, pHouskeepingMode			STRING
	, pApplicationName			STRING
	, pPITLoggingLevel			DOUBLE
	, pLoadID					DOUBLE
	
)
  RETURNS STRING
  LANGUAGE javascript
  STRICT
  EXECUTE AS CALLER
  AS
  $$
  
   var strClient = "-1" , sqlStmt = "", sqlStmtHousekeeping="", strOut="";
   var sqlStmtStartComponentLoggingTmp = "" , sqlStmtEndComponentLoggingTmp = "";
   var sqlStmtUpdate = "UPDATE #SF_SCHEMA#.#SF_TABLE_NAME# SET DELETED_FG=1,DWH_UPDATED_TS=current_timestamp() WHERE TRUE AND DELETED_FG=0 AND #HOUSEKEEPING_PARAM#;";
   var sqlStmtDelete = "DELETE FROM #SF_SCHEMA#.#SF_TABLE_NAME# WHERE TRUE AND #HOUSEKEEPING_PARAM#;";
   var sqlStmtStartComponentLogging = "CALL sp_StartComponentLogging('${LOAD_ID}','${APPLICATION_NAME}','HOUSEKEEPING', 'Delete Existing Data #SF_SCHEMA#.#SF_TABLE_NAME#: #SQL#', '[${CLIENT_ID}]', f_QueryTag('HOUSEKEEPING','${APPLICATION_NAME}','[${CLIENT_ID}]'),'${SCHEMA}',${PIT_LOGGING_LEVEL});";
   var sqlStmtEndComponentLogging = "CALL sp_EndComponentLogging('${APPLICATION_NAME}','HOUSEKEEPING', 'Delete Existing Data #SF_SCHEMA#.#SF_TABLE_NAME#: #SQL#', '[${CLIENT_ID}]','${SCHEMA}',0,${PIT_LOGGING_LEVEL});" ;

   var sqlStmtUpdateParamSTART_DT_PIT_DATA = "Call P_LEW_MART_PIT.sp_UpdateParam( '${CLIENT_ID}','P_LEW_MART_PIT_2', 'START_DT_PIT_DATA' , CAST( to_char('${START_DT_PIT_DATA}'::DATE,'YYYYMMDD') AS INTEGER) , NULL);";
   var sqlStmtUpdateParamSTART_ADV_WEEK_ID = "Call P_LEW_MART_PIT.sp_UpdateParam( '${CLIENT_ID}','P_LEW_MART_PIT_2', 'START_ADV_WEEK_ID' , ${START_ADV_WEEK_ID} , NULL);";


	sqlStmtStartComponentLogging=sqlStmtStartComponentLogging.replace(/\${CLIENT_ID}/g,PCLIENTID.toString());
	sqlStmtEndComponentLogging=sqlStmtEndComponentLogging.replace(/\${CLIENT_ID}/g,PCLIENTID.toString());

	sqlStmtStartComponentLogging=sqlStmtStartComponentLogging.replace(/\${APPLICATION_NAME}/g,PAPPLICATIONNAME);
	sqlStmtEndComponentLogging=sqlStmtEndComponentLogging.replace(/\${APPLICATION_NAME}/g,PAPPLICATIONNAME);
	
	sqlStmtStartComponentLogging=sqlStmtStartComponentLogging.replace(/\${PIT_LOGGING_LEVEL}/g,PPITLOGGINGLEVEL.toString());
	sqlStmtEndComponentLogging=sqlStmtEndComponentLogging.replace(/\${PIT_LOGGING_LEVEL}/g,PPITLOGGINGLEVEL.toString());
	
	sqlStmtStartComponentLogging=sqlStmtStartComponentLogging.replace(/\${LOAD_ID}/g,PLOADID.toString());
	sqlStmtEndComponentLogging=sqlStmtEndComponentLogging.replace(/\${LOAD_ID}/g,PLOADID.toString());

	// STEP 1.2 choose correct tamplate (drop vs_2 update)
  
  
	// CHECK INPUT pHouskeepingMode 
		if ((PHOUSKEEPINGMODE === "") || (typeof(PHOUSKEEPINGMODE) === "undefined") || (PHOUSKEEPINGMODE.length === 0) || (PHOUSKEEPINGMODE === null)) { 
			sqlStmtHousekeeping ="SELECT NULL;"; 
		} else {
			strHouskeepingMode = PHOUSKEEPINGMODE.toUpperCase();
			if (strHouskeepingMode === "UPDATE") {
				sqlStmtHousekeeping=sqlStmtUpdate;
				}
			if (strHouskeepingMode === "DELETE") {
				sqlStmtHousekeeping=sqlStmtDelete;
				}			
		}
		
		if ((strHouskeepingMode === "UPDATE")||(strHouskeepingMode === "DELETE")) {
		
				// STEP 1.1 Get prev.parameters 
		  
				sqlStmt = "";
				sqlStmt = `		
							select P_LEW_MART_PIT.f_GetPrevParamsValue(#PCLIENTID#, 'END_DT_PIT_DATA', 0) 			AS _END_DT_PIT_DATA_CHAR, 
								TO_DATE(_END_DT_PIT_DATA_CHAR,'YYYY-MM_2-DD') - (#PADWWEEKCNT#)*7 +1					AS _START_DT_PIT_DATA,
								f_GetAdvWeekId(_START_DT_PIT_DATA, ctry.CTR_ADV_WEEK_START_WEEKDAY_ID)				AS _START_ADV_WEEK_ID,
								P_LEW_MART_PIT.f_GetPrevParamsValue(#PCLIENTID#, 'ADP_TIME_GAP_IN_DAYS', 0) 			AS _ADP_TIME_GAP_IN_DAYS,
								P_LEW_MART_PIT.f_GetPrevParamsValue(#PCLIENTID#, 'END_DT_DELIV_QTY', 0) 				AS _END_DT_DELIV_QTY,
								P_LEW_MART_PIT.f_GetPrevParamsValue(#PCLIENTID#, 'START_DT_DELIV_QTY', 0) 			AS _START_DT_DELIV_QTY,
								P_LEW_MART_PIT.f_GetPrevParamsValue(#PCLIENTID#, 'START_DT_STC_REAL_QTY', 0) 			AS _START_DT_STC_REAL_QTY,
								P_LEW_MART_PIT.f_GetPrevParamsValue(#PCLIENTID#, 'START_DT_BASE_METRIC_NF_FA', 0) 	AS _START_DT_BASE_METRIC_NF_FA,
								P_LEW_MART_PIT.f_GetPrevParamsValue(#PCLIENTID#, 'END_DT_BASE_METRIC_NF_FA', 0) 		AS _END_DT_BASE_METRIC_NF_FA,
								TO_CHAR(_START_DT_PIT_DATA + 1,'YYYY-MM_2-DD') 										AS _START_DT_PIT_DATA_CHAR,
								f_GetAdvWeekId(_START_DT_PIT_DATA -7, ctry.CTR_ADV_WEEK_START_WEEKDAY_ID)			AS _START_ADV_WEEK_ID_PREV
							 from (
									SELECT 
									  CLIENT_ID
									, COUNTRY_ISO_CD
									, COUNTRY_DESCR
									, CTR_ADV_WEEK_START_WEEKDAY_ID
									FROM TABLE(f_GetTableAdvWeekStartDayId())
									WHERE CLIENT_ID 		IN (#PCLIENTID#)
								) AS ctry
							
						`;
				// Variable Substitution
				sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
				sqlStmt = sqlStmt.replace(/#PADWWEEKCNT#/g,PADWWEEKCNT);
				
				// Retrieve next Template
				try{
					var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}
				res.next();
				// res.getColumnValue(1) = Template (Header)
			
			
				START_ADV_WEEK_ID=res.getColumnValue(3);	  
				ADP_TIME_GAP_IN_DAYS=res.getColumnValue(4);
				END_DT_DELIV_QTY=res.getColumnValue(5);
				START_DT_DELIV_QTY=res.getColumnValue(6);
				START_DT_STC_REAL_QTY=res.getColumnValue(7);
				START_DT_BASE_METRIC_NF_FA=res.getColumnValue(8);
				END_DT_BASE_METRIC_NF_FA=res.getColumnValue(9);
				START_DT_PIT_DATA=res.getColumnValue(10);
				START_ADV_WEEK_ID_PREV=res.getColumnValue(11);
		  

				// STEP 2. Loop: take all rows from config tables
				sqlStmt = "";
				sqlStmt = `	
					select SF_SCHEMA,
					SF_TABLE_NAME, 
					HOUSEKEEPING_PARAM
					from P_LEW_MART_PIT.T_CNTL_HOUSEKEEPING_PARAM_2
						where current_date between VALID_FROM_DT and VALID_TO_DT
						and REJECT_FG=0
						and DELETED_FG=0
						ORDER BY RANDOM(#PCLIENTID#)  -- performance
						;
				`;
				// Variable Substitution
				
				sqlStmt=sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
				
				// Retrieve next Template
				try{
					var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}
				
				  while ( res.next())  {
				
				  // STEP 2.1 replace parameters    

					  strOut=sqlStmtHousekeeping;

					  SF_SCHEMA = res.getColumnValue(1);
					  SF_TABLE_NAME = res.getColumnValue(2);
					  HOUSEKEEPING_PARAM = res.getColumnValue(3);
					  
					  strOut=strOut.replace(/#SF_SCHEMA#/g,SF_SCHEMA);
					  strOut=strOut.replace(/#SF_TABLE_NAME#/g,SF_TABLE_NAME);
					  strOut=strOut.replace(/#HOUSEKEEPING_PARAM#/g,HOUSEKEEPING_PARAM);  
					  
					  // replace parameters
					  
					  strOut=strOut.replace(/\${CLIENT_ID}/g,PCLIENTID);
					  strOut=strOut.replace(/\${START_DT_PIT_DATA}/g,START_DT_PIT_DATA);
					  strOut=strOut.replace(/\${START_ADV_WEEK_REAGG}/g,START_ADV_WEEK_ID.toString());			  
					  strOut=strOut.replace(/\${ADP_TIME_GAP_IN_DAYS}/g,ADP_TIME_GAP_IN_DAYS);
					  strOut=strOut.replace(/\${END_DT_DELIV_QTY}/g,END_DT_DELIV_QTY);
					  strOut=strOut.replace(/\${START_DT_DELIV_QTY}/g,START_DT_DELIV_QTY);
					  strOut=strOut.replace(/\${START_DT_STC_REAL_QTY}/g,START_DT_STC_REAL_QTY);
					  strOut=strOut.replace(/\${START_DT_BASE_METRIC_NF_FA}/g,START_DT_BASE_METRIC_NF_FA);
					  strOut=strOut.replace(/\${END_DT_BASE_METRIC_NF_FA}/g,END_DT_BASE_METRIC_NF_FA);
					  strOut=strOut.replace(/\${START_ADV_WEEK_REAGG_PREV}/g,START_ADV_WEEK_ID_PREV.toString());
		  

					// STEP 2.2 execute script			  
				
				// Logging
				
				sqlStmtStartComponentLoggingTmp = sqlStmtStartComponentLogging;
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/#SF_SCHEMA#/g,SF_SCHEMA);
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/\${SCHEMA}/g,"P_LEW_MART_PIT_2");
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/#SF_TABLE_NAME#/g,SF_TABLE_NAME);
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/#HOUSEKEEPING_PARAM#/g,HOUSEKEEPING_PARAM);  
				sqlStmtStartComponentLoggingTmp=sqlStmtStartComponentLoggingTmp.replace(/#SQL#/g,strOut.replace(/\'/g,"''''")); 
				
				try{
					snowflake.createStatement( { sqlText: sqlStmtStartComponentLoggingTmp } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmtStartComponentLoggingTmp + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}
				
				try{
					snowflake.createStatement( { sqlText: strOut } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + strOut + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}

				// Logging

				sqlStmtEndComponentLoggingTmp = sqlStmtEndComponentLogging;
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/#SF_SCHEMA#/g,SF_SCHEMA);
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/\${SCHEMA}/g,"P_LEW_MART_PIT_2");
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/#SF_TABLE_NAME#/g,SF_TABLE_NAME);
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/#HOUSEKEEPING_PARAM#/g,HOUSEKEEPING_PARAM); 
				sqlStmtEndComponentLoggingTmp=sqlStmtEndComponentLoggingTmp.replace(/#SQL#/g,strOut.replace(/\'/g,"''''")); 		
				
				try{
					snowflake.createStatement( { sqlText: sqlStmtEndComponentLoggingTmp } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmtEndComponentLoggingTmp + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}
				
				}


			// STEP 3 update parameters	
			// Only two parameters are updated, since the others are calculated in the scripts load_prepare_next_run.sql
			
			//CLIENT_ID
			 sqlStmtUpdateParamSTART_DT_PIT_DATA=sqlStmtUpdateParamSTART_DT_PIT_DATA.replace(/\${CLIENT_ID}/g,PCLIENTID);
			 sqlStmtUpdateParamSTART_ADV_WEEK_ID=sqlStmtUpdateParamSTART_ADV_WEEK_ID.replace(/\${CLIENT_ID}/g,PCLIENTID);

			//START_DT_PIT_DATA
			 sqlStmtUpdateParamSTART_DT_PIT_DATA=sqlStmtUpdateParamSTART_DT_PIT_DATA.replace(/\${START_DT_PIT_DATA}/g,START_DT_PIT_DATA);
			 sqlStmtUpdateParamSTART_ADV_WEEK_ID=sqlStmtUpdateParamSTART_ADV_WEEK_ID.replace(/\${START_DT_PIT_DATA}/g,START_DT_PIT_DATA);

			//START_ADV_WEEK_ID
			 sqlStmtUpdateParamSTART_DT_PIT_DATA=sqlStmtUpdateParamSTART_DT_PIT_DATA.replace(/\${START_ADV_WEEK_ID}/g,START_ADV_WEEK_ID.toString());
			 sqlStmtUpdateParamSTART_ADV_WEEK_ID=sqlStmtUpdateParamSTART_ADV_WEEK_ID.replace(/\${START_ADV_WEEK_ID}/g,START_ADV_WEEK_ID.toString());

			
			try{
					snowflake.createStatement( { sqlText: sqlStmtUpdateParamSTART_DT_PIT_DATA } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmtUpdateParamSTART_DT_PIT_DATA + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}

			try{
					snowflake.createStatement( { sqlText: sqlStmtUpdateParamSTART_ADV_WEEK_ID } ).execute();
				} catch (ERROR){
					msg = "StartComponentLogging: [" + sqlStmtUpdateParamSTART_ADV_WEEK_ID + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
						
					throw new Error(msg);
					return msg ;			
				}
	}
  
  return strOut;
	
  $$
;

