/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_MakeTableCopy
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2022-01-20 Andreas Kurz		Revised Bug Fix getTimeStamp
#  1.2	2023-09-25 Andreas Kurz		Changed that Tables are created or replaced only on P_LEW_MART_PIT_2
#  1.3 	2024-01-09 Andreas Kurz		Added new Parameter bScope which is controlling Begein / End Transaction
#  1.4  2025-01-28 Nikolai Toknov	Exclude bScope because this parameter is not used in scripts
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT; 
--USE DATABASE 	LDL_PRODUCTION_CLONE_EK_WA;
--USE DATABASE LDL_PRODUCTION_CLONE_PIT_UWG_2023_04_21;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS; 
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_CLONE_PARAM_TESTING;
USE SCHEMA 		P_LEW_MART_PIT_2;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;

SELECT '>>> ${EXEC_PIT_TIMESTAMP}  Creating Procedure sp_MakeTableCopy [SP Procedure general use on PITonCloud]' AS ""
;


DROP PROCEDURE IF EXISTS sp_MakeTableCopy(STRING, STRING, BOOLEAN)
;
-- DESCRIBE PROCEDURE sp_MakeTableCopy(STRING, STRING, BOOLEAN)
-- SHOW USER PROCEDURES
-- SELECT get_ddl('PROCEDURE','P_LEW_MART_PIT.sp_MakeTableCopy')
-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));

*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_MakeTableCopy(pSchema STRING, pTableName STRING )
Input		:   pSchema 				STRING 
				pTableName 				STRING
				pExecute				BOOLEAN
				pScope				BOOLEAN (True/False) for BEGIN Transaction and Commit. Default is FALSE not BT and COMMIT				
Return		:	Error + Error Msg or in success case name of backuped table
Convert		:	None    
Description	: 	Copies / backup important tables 
				Format: #PSCHEMA#.#PTABLENAME#_{Current TS:: YYYYMMDD_H24MISS}_TMP
Example		:	Call sp_MakeTableCopy('P_LEW_MART_PIT_2');
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_MakeTableCopy (
      pSchema      			STRING
	, pTableName			STRING
	, pExecute				BOOLEAN	
	--, pScope				BOOLEAN
)
  RETURNS STRING
  LANGUAGE javascript
  STRICT
  EXECUTE AS OWNER
  AS
  $$
		var _rowCnt = 0, iCnt = 0, iMaxRuns = 100, strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "", strTS = "", strRAND = "";
		var _bExecute = new Boolean("false");
        var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";		

		if ((PEXECUTE === "") || (typeof(PEXECUTE) === "undefined") || (PEXECUTE === null)) {
			_bExecute = Boolean("false");
		} else {
			_bExecute = PEXECUTE;
		}
		
		if ((_bExecute === "false") || (_bExecute === 0)){
			return "NO COPY_: Logging === " + _bExecute + ": [" + PSCHEMA + "." + PTABLENAME + "]";
		}
		
		// CHECK INPUT PSCHEMA 
		if ((PSCHEMA === "") || (typeof(PSCHEMA) === "undefined") || (PSCHEMA.length === 0) || (PSCHEMA === null)) { 
			msg = "P_MakeTableCopy: [Missing or wrong Parameter PSCHEMA] ";
				
			throw new Error(msg);
			return msg ;
		}	
		
		// CHECK INPUT PTABLENAME 
		if ((PTABLENAME === "") || (typeof(PTABLENAME) === "undefined") || (PTABLENAME.length === 0) || (PTABLENAME === null)) { 
			msg = "P_MakeTableCopy: [Missing or wrong Parameter PTABLENAME] ";
				
			throw new Error(msg);
			return msg ;
		}	
		// check PScope
		if ((PSCOPE === "") || (typeof(PSCOPE) === "undefined") || (PSCOPE === null)) {
			_bScope = Boolean("falsefalse");
		} else {
			_bScope = Boolean(PSCOPE);
		}		
		
		// 
		var _RAND = function randomIntFromInterval(min, max, size) { 
			// min and max included 
			var rand_num = Math.floor(Math.random() * (max - min + 1) + min);				
			var s = "000000000" + rand_num;
			return s.substr(s.length-size);
		};
		
		// Format YYYYMMDD_HHMISS 
		var _TS = function getTimeStamp() {
			var now = new Date();
			var iday = now.getDate();

			var strday = "";

			if (iday < 10) {
				strday = "0" + iday.toString()
			} else {
			   strday = iday.toString()
			}
			
			return (
				now.getFullYear() 
				+ "" +
				(
					((now.getMonth() + 1 )< 10) ? ("0" + (now.getMonth() + 1)) : (now.getMonth() + 1)
				)
				+ "" +
					strday
				+ "_" +
				(
					(now.getHours()  < 10 ) ? ("0" + now.getHours()) : (now.getHours())
                ) 
				+ 
				(
					(now.getMinutes() < 10) ? ("0" + now.getMinutes()) : (now.getMinutes())
				) 
				+
				(
					(now.getSeconds() < 10) ? ("0" + now.getSeconds()) : (now.getSeconds())
				)
			);
		};		
		
		strTS = _TS();
		
		strRAND	= _RAND(1,9999,4);
		
	
		sqlStmt = `
					SELECT 1 
					FROM INFORMATION_SCHEMA.TABLES 
					WHERE TRUE 
						AND UPPER(Table_Schema) IN ('#PSCHEMA#')
						AND UPPER(Table_Name)   = '#PTABLENAME#'
				`;
			
		// Variable Substitution
		sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());			
		sqlStmt = sqlStmt.replace(/#PTABLENAME#/g,PTABLENAME.toUpperCase());
	
        // Retrieve from all uses tables
        try{
			//Begin Transaction
		    if ( _bScope ) {
				snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
			} // if ( _bScope )		
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			
			//End  Transaction Commit
		    if ( _bScope ) {
				snowflake.createStatement( { sqlText: sqlCommit } ).execute();
			} // if ( _bScope )			
        } catch (ERROR){
            
        	msg = "P_MakeTableCopy: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        
        _rowCnt = res.getRowCount();
       
		if(_rowCnt > 0) {
			sqlStmt = `
						CREATE OR REPLACE TABLE P_LEW_MART_PIT.#PTABLENAME#_#TS#_#RAND#_TMP
							CLONE #PSCHEMA#.#PTABLENAME#
					`;
					
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());			
			sqlStmt = sqlStmt.replace(/#PTABLENAME#/g,PTABLENAME.toUpperCase());		
			sqlStmt = sqlStmt.replace(/#TS#/g,strTS);		
			sqlStmt = sqlStmt.replace(/#RAND#/g,strRAND);		
			
			
			// Retrieve from all uses tables
			try{
				
				var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
				
				msg = "P_MakeTableCopy: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
			}
			
			return PSCHEMA.toUpperCase() + "." + PTABLENAME.toUpperCase() + "_" + strTS + "_" + strRAND + "_TMP";			
			
	   } else {
			return "NO COPY: TABLE or Schema does not exist: [" + PSCHEMA + "." + PTABLENAME + "]"
	   }
	
$$
; -- End of sp_MakeTableCopy

/*
Call sp_MakeTableCopy('P_LEW_MART_PIT_2','T_CNTL_ETL_LOGGING_2',true);
CALL P_LEW_MART_PIT.sp_MakeTableCopy('P_LEW_MART_PIT_2','T_CNTL_PROCESSING_PARAM_2',true);
CALL P_LEW_MART_PIT.sp_MakeTableCopy('P_LEW_MART_PIT_2','T_CNTL_ETL_LOGGING_2',True)
Call sp_MakeTableCopy('${SCHEMA}','T_CNTL_ETL_LOGGING_2',${PIT_EXECUTE_COPYTABLE});

SHOW TABLES LIKE 'T_CNTL_ETL_LOGGING_2%';
*/
/* --- EOF - END OF FILE --- */