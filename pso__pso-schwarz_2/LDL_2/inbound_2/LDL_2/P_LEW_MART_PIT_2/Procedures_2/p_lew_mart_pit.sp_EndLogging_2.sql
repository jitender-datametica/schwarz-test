/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_EndLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2023-01-24 Andreas Kurz		Corrected sqlBeginTransaction which was missing
#  2.0  2023-06-02 Nikolai Toknov   add parameter pPITLogging
#  2.1	2023-08-14 Andreas Kurz	   changed update to insert
#-------------------------------------------------------------------------------
*/

/*
USE ROLE 		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS;
USE SCHEMA 		P_LEW_MART_PIT_2;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;
*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_EndLogging(pApplicationName STRING, pRunClusteringDesc STRING)
Input		:   pApplicationName 	STRING 
				pRunClusteringDesc 	STRING --> [0] running in sequence
				pPITLogging			FLOAT  --> 0 - no logging, 1 - Start/End-Logging, 2 - Start/End-ModuleLogging, 3 - Start/End-ComponentLogging
								
Return		:	Error + Error Msg | Success Nbr of rows (modules and or compenents) of this run
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	CALL sp_StartLogging('PITonCloud','[0]',f_QueryTag('ETL Logging','PITonCloud',NULL),1);
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_EndLogging (
      pApplicationName      STRING 
    , pRunClusteringDesc    STRING    
	, pSchema				STRING
	, pPITLogging			FLOAT	
)
  RETURNS STRING
  LANGUAGE javascript
  AS
  $$
  
		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";		
		var strSchema = "P_LEW_MART_PIT_2";
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
						  TO_CHAR(rs.RUN_TS, 'YYYY-MM_2-DD HH24:MI:SS.FF3' ) 	AS RUN_TS
						, TO_CHAR(rs.RUN_DAY_ID,'YYYY-MM_2-DD') 				AS RUN_DAY_ID
						, rs.RUN_ID_SEQ										AS RUN_ID_SEQ
						, TO_CHAR(rs.LOAD_ID)								AS LOAD_ID
					FROM 
					#PSCHEMA#.T_CNTL_ETL_LOGGING_RUN_SEQ_2 rs_2
					INNER JOIN
					(
						SELECT 
							COALESCE(MAX(RUN_ID_SEQ),0) AS RUN_ID_SEQ 
						FROM #PSCHEMA#.T_CNTL_ETL_LOGGING_RUN_SEQ_2
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
	
			
			// Retrieve next Seq RunID
			try{
				snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
				var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
				msg = "EndComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;			
			}
			res.next();
			// res.getColumnValue(1) = RUN_ID_SEQ
			
			sqlStmt = "";
			sqlStmt = `
				INSERT INTO #PSCHEMA#.T_CNTL_ETL_LOGGING_2 
					( 
						  RUN_ID_SEQ
						, RUN_TS
						, RUN_DAY_ID
						, RUN_CLUSTERING_DESC
						, APPLICATION_NAME
						, MODULE_NAME
						, COMPONENT_NAME
						, END_PROCESSING_FG
						, LOAD_ID
						, MULTI_CLIENT_RUN_LST
						, DWH_CREATED_TS
						, CLIENT_ID
						, COMPLETED_RUN_FG
						, END_RUN_TS
					) 
				SELECT 
					  #RUNIDSEQ#														AS RUN_ID_SEQ
					, TRY_TO_TIMESTAMP('#RUNTS#', 'YYYY-MM_2-DD HH24:MI:SS.FF3')          AS RUN_TS
					, TRY_TO_DATE('#RUNDAYID#', 'YYYY-MM_2-DD')                           AS RUN_DAY_ID
					, '[' || '#RUNCLUSTER#' || ']' 										AS RUN_CLUSTERING_DESC
					, '#PAPPLICATIONNAME#'                                              AS APPLICATION_NAME
					, '>>>End Logging<<<'                                               AS MODULE_NAME
					, '>>>End Logging<<<'                                               AS COMPONENT_NAME
					, 1::SMALLINT														AS END_PROCESSING_FG
					, COALESCE(try_to_number('#PLOADID#'),-2)::INTEGER					AS LOAD_ID 
					, STRTOK_TO_ARRAY('#RUNCLUSTER#', ',')								AS MULTI_CLIENT_RUN_LST
					, CURRENT_TIMESTAMP() 												AS DWH_CREATED_TS
					, iff(
						ARRAY_POSITION('0'::VARIANT,MULTI_CLIENT_RUN_LST) IS NULL AND ARRAY_SIZE (MULTI_CLIENT_RUN_LST) = 1
						,COALESCE(TRY_TO_NUMBER('#RUNCLUSTER#'),-2::INTEGER)
						,-2::INTEGER
						)																AS CLIENT_ID
					, 1::SMALLINT														AS COMPLETED_RUN_FG
					, CURRENT_TIMESTAMP()												AS END_RUN_TS
			`;
			
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#RUNIDSEQ#/g,res.getColumnValue(3));
			sqlStmt = sqlStmt.replace(/#RUNTS#/g,res.getColumnValue(1));
			sqlStmt = sqlStmt.replace(/#RUNDAYID#/g,res.getColumnValue(2));
			sqlStmt = sqlStmt.replace(/#PLOADID#/g,res.getColumnValue(4));					
			
			sqlStmt = sqlStmt.replace(/#PAPPLICATIONNAME#/g,PAPPLICATIONNAME.toUpperCase());
			sqlStmt = sqlStmt.replace(/#RUNCLUSTER#/g,strRunCluster.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);	

		
			try{	
				snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
				snowflake.createStatement( { sqlText: sqlCommit } ).execute();
			} catch (ERROR){
				msg = "P_ENDPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;			
			}
			
			//res.next();
			// return RUN_ID_SEQ
			return res.getColumnValue(3);	
		}				
  $$
; -- End of sp_EndLogging