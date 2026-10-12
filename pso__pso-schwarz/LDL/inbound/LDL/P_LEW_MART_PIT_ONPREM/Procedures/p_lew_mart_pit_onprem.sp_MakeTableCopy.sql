CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_MakeTableCopy (
      pSchema      			STRING
	, pTableName			STRING
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  EXECUTE AS CALLER
  AS
  $$

// ---------------------------------------------------------------------
// PROCEDURE	:	sp_MakeTableCopy(pSchema STRING, pTableName STRING )
// Input		:   pSchema 				STRING 
// 				pTableName 				STRING
// Return		:	Error + Error Msg or in success case name of backuped table
// Convert		:	None    
// Description	: 	Copies / backup important tables 
// 				Format: #PSCHEMA#.#PTABLENAME#_{Current TS:: YYYYMMDD_H24MISS}_TMP
// Example		:	Call sp_MakeTableCopy('P_LEW_MART_PIT_ONPREM');
// ------------------------------------------------------------------------
// History:
//  1.0  2021-07-01 Andreas Kurz    Initial version

		var _rowCnt = 0, iCnt = 0, iMaxRuns = 100, strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "", strTS = "";
        	
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
		
		// Format YYYYMMDD_HHMISS 
		var TS = function getTimeStamp() {
			var now = new Date();
			return (
				now.getFullYear() 
				+ "" +
				(
					((now.getMonth() + 1 )< 10) ? ("0" + (now.getMonth() + 1)) : (now.getMonth() + 1)
				)
				+ "" +
				(now.getDate()) 
				+ "_" +
					now.getHours() 
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
		
		strTS = TS();
	
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
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_MakeTableCopy: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
        
        _rowCnt = res.getRowCount();
       
		if(_rowCnt > 0) {
			sqlStmt = `
						CREATE TABLE IF NOT EXISTS #PSCHEMA#.#PTABLENAME#_#TS#_TMP
							CLONE #PSCHEMA#.#PTABLENAME#;
					`;
					
			// Variable Substitution
			sqlStmt = sqlStmt.replace(/#PSCHEMA#/g,PSCHEMA.toUpperCase());			
			sqlStmt = sqlStmt.replace(/#PTABLENAME#/g,PTABLENAME.toUpperCase());		
			sqlStmt = sqlStmt.replace(/#TS#/g,strTS);		
			
			
			// Retrieve from all uses tables
			try{
				
				var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
				
				msg = "P_MakeTableCopy: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
			}
			
			return PSCHEMA + "." + PTABLENAME + "_" + strTS + "_TMP";			
			
	   } else {
			return "NO COPY: TABLE or Schema does not exist: [" + PSCHEMA + "." + PTABLENAME + "]"
	   }
	
$$
;