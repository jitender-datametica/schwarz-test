/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_Manual2DailyRun
#-------------------------------------------------------------------------------
# Describtion: Procedure to update manualRun Flag  [2] to a Daily Run Flag [3]
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_EK_WA;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_2; 

DROP PROCEDURE IF EXISTS P_LEW_MART_PIT.sp_Manual2DailyRun(STRING, STRING, DOUBLE)
;
-- DESCRIBE PROCEDURE sp_Manual2DailyRun(STRING, STRING, DOUBLE)
-- SHOW USER PROCEDURES
-- SELECT get_ddl('PROCEDURE','SP_Manual2DailyRun')
-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));

Call sp_RunSearchOptimization('P_LEW_MART_PIT_2','PITonCloud','Performance','',100,FALSE);
SELECT * FROM P_LEW_MART_PIT.T_CNTL_PROCESSING_PARAM_2 WHERE CLIENT_ID = 23 AND PARAM_ID = 40
*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_Manual2DailyRun(pApplicationName STRING, pPCLIENTIDingDesc STRING)
Input		:   pClientId 			STRING 
				pSchema				STRING
				pRunMode			DOUBLE [0:: Daily Run 3::
Return		:	Error + Error Msg | Success Nbr of rows (modules and or compenents) of this run
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	Call P_LEW_MART_PIT.sp_Manual2DailyRun( '23','P_LEW_MART_PIT_2', 3);
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_Manual2DailyRun (
      pClientId    			STRING    
	, pSchema				STRING	
	, pRunMode 				DOUBLE
)
  RETURNS STRING
  LANGUAGE javascript
  CALLED ON NULL INPUT
  AS
  $$
	  
  		var _rowCnt = 0,  iCnt = 0, iMaxRuns = 1, msg = "", SQLCODE = 0, SQLSTATE = '00000', strClient = "0", sqlStmt = "", sqlStmtUpd_1 = "", sqlStmtUpd_2 = "";
        var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";
		var strSchema = "P_LEW_MART_PIT_2";
		var strParamValueChar = "";	
		var strClient = "-1";
		var iRunMode = 3;
  
		// CHECK INPUT PCLIENTID 
		if ((PCLIENTID === "") || (typeof(PCLIENTID) === "undefined") || (PCLIENTID.length === 0) || (PCLIENTID === null)) { 
			PCLIENTID = strClient; 
		} else {
			strClient = PCLIENTID.toUpperCase();
		}	
		
		// CHECK INPUT pSchema 
		if ((PSCHEMA === "") || (typeof(PSCHEMA) === "undefined") || (PSCHEMA.length === 0) || (PSCHEMA === null)) { 
			PSCHEMA = strSchema; 
		} else {
			strSchema = PSCHEMA.toUpperCase();
		}
		
		// RunMode must be between 0 or 3
		if ((PRUNMODE == "") || (PRUNMODE == null) || (Number.isNaN(PRUNMODE) == true) || (PRUNMODE === 0)  || (PRUNMODE === 3) ) { 
			PRUNMODE =  iRunMode ;
		} 	
		
		sqlStmt = "";
		sqlStmt = `
				SELECT 
					  pa.CLIENT_ID
					, pa.PARAM_ID
					, pa.VERSION_NR
					, pa.PARAM_VALUE
				FROM
					(
					SELECT 
						  CLIENT_ID
						, PARAM_ID
						, VERSION_NR
						, PARAM_VALUE
					FROM #PSCHEMA#.T_CNTL_PROCESSING_PARAM_2					
					WHERE TRUE
						AND CLIENT_ID 	IN ( #PCLIENTID# )
						AND DELETED_FG 	= 0
						AND CURRENT_FG 	= 1
						AND REJECT_FG  	= 0
					/* ALWAYS TAKE MAX VERSION NR IGNORE DATE_FROM DATE_TO IN CASE OF ALREADY CLOSED PERIODS */
					QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
				) pa 
				
				/* PARAM REF */
				INNER JOIN
				(
					SELECT DISTINCT
						  PARAM_ID
						, PARAM_NAME
						, PARAM_DESCR
						, PARAM_COLUMN_DATATYPE
					FROM #PSCHEMA#.T_CNTL_DIM_PROCESSING_PARAM_2
					WHERE TRUE
						AND UPPER(TRIM(PARAM_NAME))  	=  UPPER(TRIM('EXEC_PIT_MANUAL_RUN_FG'))
						AND DELETED_FG 	= 0
						AND REJECT_FG  	= 0
					-- Deduplication 
					QUALIFY ROW_NUMBER() OVER(PARTITION BY PARAM_ID ORDER BY DWH_UPDATED_TS DESC) = 1						
				) AS par
				ON TRUE
					AND pa.PARAM_ID 	= par.PARAM_ID
					AND pa.PARAM_VALUE 	= 2 -- Initital run
			;			
		`;		
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,strClient);
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
		
		try{
		    var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "Manual2DailyRun: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;
        }
		var _rowCnt = res.getRowCount();		

		// only if exists 2 than 3
		while (res.next() && iCnt < iMaxRuns) {

			sqlStmtUpd_1 = "";
			sqlStmtUpd_1 = `
				CALL #PSCHEMA#.sp_UpdateParam( '#PCLIENTID#','#PSCHEMA#', 'EXEC_PIT_MANUAL_RUN_FG', #PRUNMODE# , NULL)
				;		
			`;		
			
		
			// Variable Substitution
			sqlStmtUpd_1 = sqlStmtUpd_1.replace(/#PCLIENTID#/g,strClient);
			sqlStmtUpd_1 = sqlStmtUpd_1.replace(/#PSCHEMA#/g,strSchema);
			sqlStmtUpd_1 = sqlStmtUpd_1.replace(/#PRUNMODE#/g,PRUNMODE);

			sqlStmtUpd_2 = "";
			sqlStmtUpd_2 = `
				CALL #PSCHEMA#.sp_UpdateParam( '#PCLIENTID#','#PSCHEMA#', 'EXEC_PIT_MANUAL_COUNTRY_LST', NULL , '')
				;			
			`;		
			
		
			// Variable Substitution
			sqlStmtUpd_2 = sqlStmtUpd_2.replace(/#PCLIENTID#/g,strClient);
			sqlStmtUpd_2 = sqlStmtUpd_2.replace(/#PSCHEMA#/g,strSchema);
			sqlStmtUpd_2 = sqlStmtUpd_2.replace(/#PRUNMODE#/g,PRUNMODE);
		
	
			try{
				snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
				var resUpd_1 = snowflake.createStatement( { sqlText: sqlStmtUpd_1 } ).execute();
				var resUpd_2 = snowflake.createStatement( { sqlText: sqlStmtUpd_2 } ).execute();			
				snowflake.createStatement( { sqlText: sqlCommit } ).execute();
			} catch (ERROR){
				msg = "Manual2DailyRun: [" + sqlStmtUpd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;
			}
		
			_rowCnt += resUpd_1.getRowCount();
			_rowCnt += resUpd_2.getRowCount();		
			
			iCnt += 1;
			
		} // while result set
		
		return "" + _rowCnt;
		
  $$
; -- End of sp_Manual2DailyRun