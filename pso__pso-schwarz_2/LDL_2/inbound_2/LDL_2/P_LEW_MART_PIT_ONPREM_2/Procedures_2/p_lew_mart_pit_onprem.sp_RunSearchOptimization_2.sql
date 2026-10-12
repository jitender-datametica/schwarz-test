CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_RunSearchOptimization (
      pSchema      			STRING 
	, pApplicationName 		STRING 
	, pModuleName 			STRING 		
	, pRunClusteringDesc    STRING  
	, pMaxRuns				DOUBLE
	, pLogging				BOOLEAN	
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  EXECUTE AS CALLER
  AS
  $$


// ---------------------------------------------------------------------
// PROCEDURE	:	sp_RunSearchOptimization(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
// Input		:   pSchema 				STRING 
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
//     			pMaxRuns				INTEGER
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
//                 Logging is also enables  but must be enabled! 
// Example		:	Call sp_RunSearchOptimization('P_LEW_MART_PIT_ONPREM');
// ------------------------------------------------------------------------
// 
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version
// #  2.0  2021-12-08 Andreas Kurz and Nikolai Toknov	Change script


	var _rowCnt = 0, iCnt = 0, iMaxRuns = 100, strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmtLogStart = "", sqlStmtLogEnd = "", sqlStmt = "";
		var _bLogging = new Boolean("false");
        
		if ((PLOGGING === "") || (typeof(PLOGGING) === "undefined") || (PLOGGING === null)) {
			_bLogging = Boolean("false");
		} else {
			_bLogging = Boolean(PLOGGING);
		}
        
		if ((PMAXRUNS == "") || (PMAXRUNS == null) || (Number.isNaN(PMAXRUNS) == true)) { 
			PMAXRUNS = iMaxRuns; 
		} else {
			iMaxRuns = PMAXRUNS;
		}
		
		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}	
		
		sqlStmt = "SELECT Table_Schema || '.' || Table_Name FROM INFORMATION_SCHEMA.TABLES WHERE TRUE AND UPPER(Table_Schema) IN ('" + PSCHEMA.toUpperCase() + "')" +
					" AND UPPER(Table_Name)   LIKE 'T_%' AND UPPER(Table_Name)   NOT LIKE 'TT%' AND UPPER(Table_Name) NOT LIKE '%_TMP';";


        // Retrieve from all uses tables
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            
        	msg = "P_RUNSEARCHOPTIMIZATION: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;           
        }
		// Loop all results
		var _rowCnt = res.getRowCount();
	
		while (res.next() && iCnt < iMaxRuns) {
		       	
			sqlStmt = "";
			sqlStmt = "ALTER TABLE IF EXISTS " + res.getColumnValue(1) + " ADD SEARCH OPTIMIZATION;";
			
			if ( _bLogging ) {
				sqlStmtLogStart = "";
				sqlStmtLogStart = "CALL sp_StartComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','" + res.getColumnValue(1) + "', '" + strRunCluster + "',QueryTag('" + PAPPLICATIONNAME + "','" + PMODULENAME + "',NULL));";

				sqlStmtLogEnd = ""; 
				sqlStmtLogEnd ="CALL sp_EndComponentLogging('" + PAPPLICATIONNAME + "','" + PMODULENAME + "','"  + res.getColumnValue(1) + "', '"+ strRunCluster + "', to_char(1));";
			} // if ( _bLogging ) {
		   
			if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogStart } ).execute();
				} catch (ERROR){
				
					msg = "P_RUNSEARCHOPTIMIZATION_ALTER: [" + sqlStmtLogStart + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;
				}
			} // if ( _bLogging ) {

		    try{
				snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			} catch (ERROR){
			
				msg = "P_RUNSEARCHOPTIMIZATION_ALTER: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
				throw new Error(msg);
				return msg ;
			}

			if ( _bLogging ) {
				try{
					snowflake.createStatement( { sqlText: sqlStmtLogEnd } ).execute();
				} catch (ERROR){
				
					msg = "P_RUNSEARCHOPTIMIZATION_ALTER: [" + sqlStmtLogEnd + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
					
					throw new Error(msg);
					return msg ;
				}
			} // if ( _bLogging ) {
			
			iCnt += 1;
			
		} // while result set

		return "" + _rowCnt;			
$$
;