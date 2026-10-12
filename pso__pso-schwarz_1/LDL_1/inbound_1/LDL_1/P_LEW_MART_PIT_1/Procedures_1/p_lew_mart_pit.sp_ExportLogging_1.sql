/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_ExportLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-08-28 Nikolai Toknov    Initial version
#-------------------------------------------------------------------------------
*/
/*
call P_LEW_MART_PIT.sp_ExportLogging (123,'PSNF','1','P_LEW_MART_PIT_1','TEST_1','', '')
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT.sp_ExportLogging (
	  pLoadID				STRING      
	, pProjectName      	STRING 
    , pClientId    			STRING    
	, pSchema				STRING
	, pTableName			STRING
	, pDayDtMin				STRING
	, pDayDtMax				STRING	
)
  RETURNS STRING
  LANGUAGE javascript
  AS
  $$
		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;";
		var strSchema = "P_LEW_MART_PIT_1";
		var strTableName = "";
		var strLoadID = "-2";
        var strDayDtMin ="1900-01-01";
        var strDayDtMax ="9999-12-31";

			// CHECK INPUT pDayDtMin 
			if ((PDAYDTMIN === "") || (typeof(PDAYDTMIN) === "undefined") || (PDAYDTMIN.length === 0) || (PDAYDTMIN === null)) { 
				PDAYDTMIN = strDayDtMin; 
			} else {
				strDayDtMin = PDAYDTMIN.toUpperCase();
			}
 
 			// CHECK INPUT pDayDtMax 
			if ((PDAYDTMAX === "") || (typeof(PDAYDTMAX) === "undefined") || (PDAYDTMAX.length === 0) || (PDAYDTMAX === null)) { 
				PDAYDTMAX = strDayDtMax; 
			} else {
				strDayDtMax = PDAYDTMAX.toUpperCase();
			}
			
			// CHECK INPUT pParamValueChar 
			if ((PLOADID === "") || (typeof(PLOADID) === "undefined")  || (PLOADID.length === 0) || (PLOADID === null)) { 
				PLOADID = strLoadID; 
			} else {
				strLoadID = PLOADID.toUpperCase();
			}			
			
			
			// CHECK INPUT pSchema 
			if ((PSCHEMA === "") || (typeof(PSCHEMA) === "undefined") || (PSCHEMA.length === 0) || (PSCHEMA === null)) { 
				PSCHEMA = strSchema; 
			} else {
				strSchema = PSCHEMA.toUpperCase();
			}
			
			// CHECK INPUT pTableName 
			if ((PTABLENAME === "") || (typeof(PTABLENAME) === "undefined") || (PTABLENAME.length === 0) || (PTABLENAME === null)) { 
				PTABLENAME = strTableName; 
			} else {
				strTableName = PTABLENAME.toUpperCase();
			}				
			
			sqlStmt = "";
			sqlStmt = `		
		INSERT INTO P_LEW_MART_PIT.T_CNTL_EXPORT_LOADING_1 (
		 PROJECT_NAME
		,SCHEMA_NAME
		,TABLE_NAME
		,CLIENT_ID
		,DAY_DT_MIN
		,DAY_DT_MAX
		,LOAD_ID)
		VALUES (
		 '#PPROJECTNAME#'
		,'#PSCHEMA#'
		,'#PTABLENAME#'
		,#PCLIENTID#
		,TO_DATE('#PDAYDTMIN#','YYYY-MM_1-DD')
		,TO_DATE('#PDAYDTMAX#','YYYY-MM_1-DD')
		,#PLOADID#
		
		)
		`;
	
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#PPROJECTNAME#/g,PPROJECTNAME.toUpperCase());
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,strSchema);
			sqlStmt = sqlStmt.replace(/#PTABLENAME#/g,strTableName);
			sqlStmt = sqlStmt.replace(/#PCLIENTID#/g,PCLIENTID);
			sqlStmt = sqlStmt.replace(/#PDAYDTMIN#/g,PDAYDTMIN);			
			sqlStmt = sqlStmt.replace(/#PDAYDTMAX#/g,PDAYDTMAX);
			sqlStmt = sqlStmt.replace(/#PLOADID#/g,strLoadID);


			try{
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
				msg = "P_STARTPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
				throw new Error(msg);
				return msg ;			
			}

		
$$
; 