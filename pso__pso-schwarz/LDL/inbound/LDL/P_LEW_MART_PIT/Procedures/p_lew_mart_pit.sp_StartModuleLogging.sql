/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_StartModuleLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  2.0  2023-06-02 Nikolai Toknov  add parameter pPITLogging
#  2.1	2023-08-14 Andreas Kurz	   changed update to insert
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS;
USE SCHEMA 		P_LEW_MART_PIT;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_StartModuleLogging(pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
Input		:  
				pLoadID				STRING --> ETL Load ID YYYYMMDDHHMMSSNNN * 100 + CLIENT_ID [All 99]
				pApplicationName 	STRING 
				pModuleName         STRING
				pRunClusteringDesc 	STRING --> [0] running in sequence 
				pQueryTag           STRING
				pPITLogging			FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
				
Return		:	Error + Error Msg
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	Call sp_StartModuleLogging(${LOAD_ID},'PITonCloud','Performance', '[0]', 'Start Logging');
				CALL sp_StartModuleLogging(${LOAD_ID},'PITonCloud','Performance', '[0]',f_QueryTag('ETL Logging','PITonCloud',NULL));
				CALL sp_StartModuleLogging(${LOAD_ID},'PITonCloud','T_AGG_REGION_MEDIUM_ALL', '[${CLIENT_ID}]',f_QueryTag('T_AGG_REGION_MEDIUM_ALL','PITonCloud','[${CLIENT_ID}]'),'${SCHEMA}');
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_StartModuleLogging (
      pLoadID				STRING      
	, pApplicationName      STRING 
    , pModuleName           STRING       
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
		var strSchema = "P_LEW_MART_PIT";
 		var strLoadID = "-2";
		var intLoggingLevel = 3;

		// CHECK INPUT pPITLogging 
		if ((PPITLOGGING === "") || (typeof(PPITLOGGING) === "undefined") || (PPITLOGGING.length === 0) || (PPITLOGGING === null)) { 
			PPITLOGGING = intLoggingLevel; 
		} else {
			intLoggingLevel = PPITLOGGING;
		}
			
		//v2.0
		if (intLoggingLevel>=2)
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
						  TO_CHAR(rs.RUN_TS, 'YYYY-MM-DD HH24:MI:SS.FF3' ) 	AS RUN_TS
						, TO_CHAR(rs.RUN_DAY_ID,'YYYY-MM-DD') 				AS RUN_DAY_ID
						, rs.RUN_ID_SEQ
					FROM 
						#PSCHEMA#.T_CNTL_ETL_LOGGING_RUN_SEQ rs
					INNER JOIN
					(
						SELECT 
							COALESCE(MAX(RUN_ID_SEQ),0) AS RUN_ID_SEQ 
						FROM #PSCHEMA#.T_CNTL_ETL_LOGGING_RUN_SEQ
						WHERE TRUE	
							AND RUN_CLUSTERING_DESC 	= '[' || '#RUNCLUSTER#' || ']' 
							AND APPLICATION_NAME 		= '#PAPPLICATIONNAME#'
					) rsm
					ON TRUE
						AND rs.RUN_ID_SEQ = rsm.RUN_ID_SEQ
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
				msg = "StartModuleLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;			
			}
			res.next();
			// res.getColumnValue(1) = RUN_ID_SEQ

			
			sqlStmt = "";
			sqlStmt = `		
				INSERT INTO #PSCHEMA#.T_CNTL_ETL_LOGGING 
					(
						  RUN_ID_SEQ
						, RUN_TS
						, RUN_DAY_ID
						, RUN_CLUSTERING_DESC
						, APPLICATION_NAME
						, MODULE_NAME
						, COMPONENT_NAME
						, QUERY_TAG
						, MODULE_LEVEL_FG
						, LOAD_ID
						, MULTI_CLIENT_RUN_LST
						, DWH_CREATED_TS
						, CLIENT_ID	
						, MODULE_START_FG	
						, START_RUN_TS
					) 
				SELECT
						  #RUNIDSEQ#
						, TRY_TO_TIMESTAMP('#RUNTS#', 'YYYY-MM-DD HH24:MI:SS.FF3')
						, TRY_TO_DATE('#RUNDAYID#', 'YYYY-MM-DD')
						, '[' || '#RUNCLUSTER#' || ']' 										AS RUN_CLUSTERING_DESC
						, '#PAPPLICATIONNAME#'
						, '#PMODULENAME#'
						, '#PMODULENAME#'
						, '#PQUERYTAG#'
						, 1::SMALLINT
						, COALESCE(try_to_number('#PLOADID#'),-2)::INTEGER
						
						, STRTOK_TO_ARRAY( '#RUNCLUSTER#',',' )								AS MULTI_CLIENT_RUN_LST
						, CURRENT_TIMESTAMP() 												AS DWH_CREATED_TS
						, iff(
							ARRAY_POSITION('0'::VARIANT,MULTI_CLIENT_RUN_LST) IS NULL AND ARRAY_SIZE (MULTI_CLIENT_RUN_LST) = 1
							,COALESCE(TRY_TO_NUMBER('#RUNCLUSTER#'),-2::INTEGER)
							,-2::INTEGER
							)																AS CLIENT_ID
						, 1::SMALLINT														AS MODULE_START_FG
						, CURRENT_TIMESTAMP()												AS START_RUN_TS
			`;
					
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#RUNIDSEQ#/g,res.getColumnValue(3));
			sqlStmt = sqlStmt.replace(/#RUNTS#/g,res.getColumnValue(1));
			sqlStmt = sqlStmt.replace(/#RUNDAYID#/g,res.getColumnValue(2));		
			
			sqlStmt = sqlStmt.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
			sqlStmt = sqlStmt.replace(/#RUNCLUSTER#/g,strRunCluster.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PMODULENAME#/g,PMODULENAME.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PQUERYTAG#/g,PQUERYTAG.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);		
			sqlStmt = sqlStmt.replace(/#PLOADID#/g,strLoadID);
			
			try{
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
				snowflake.createStatement( { sqlText: sqlCommit } ).execute();			
			} catch (ERROR){
				msg = "StartModuleLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;
			}
			
			res.next();

			return res.getColumnValue(3);		
		}		
$$
; -- End of sp_StartModuleLogging
--CALL sp_StartModuleLogging('202209180002447612','PITonCloud','T_DIM_ITEM_HIER', '[12]',f_QueryTag('T_DIM_ITEM_HIER','PITonCloud','[12]'),'P_LEW_MART_PIT')
--SELECT * FROM T_CNTL_ETL_LOGGING_RUN_SEQ
-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));
--CALL P_LEW_MART_PIT.sp_StartLogging('-1','PITonCloud','[0]',P_LEW_MART_PIT.f_QueryTag('Initialize Logging','PITonCloud','[0]'),'P_LEW_MART_PIT',NULL);
--CALL P_LEW_MART_PIT.sp_StartModuleLogging('-1','PITonCloud','Cube Refresh', '[0]',P_LEW_MART_PIT.f_QueryTag('Cube Refresh','PITonCloud','[0]'),'P_LEW_MART_PIT',NULL);
