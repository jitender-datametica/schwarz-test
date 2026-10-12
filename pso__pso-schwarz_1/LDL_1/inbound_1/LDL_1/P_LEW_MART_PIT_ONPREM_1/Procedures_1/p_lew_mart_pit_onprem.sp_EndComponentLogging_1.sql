CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_EndComponentLogging (
      pApplicationName      STRING 
    , pModuleName           STRING 
    , pComponentName        STRING
    , pRunClusteringDesc    STRING 
	, pRecordProcessedNr	STRING
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  AS
  $$

// ---------------------------------------------------------------------
// PROCEDURE	:	sp_EndComponentLogging(pApplicationName STRING, pModuleName STRING, pComponentName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
// Input		:   pApplicationName 	STRING 
//				pModuleName         STRING
// 				pComponentName      STRING
// 				pRunClusteringDesc 	STRING --> [0] running in sequence 
// 				pRecordProcessedNr	STRING --> number of recoreds written			
// Return		:	Error + Error Msg
// Convert		:	None    
// Description	: 	Initialize Logging 
// Example		:	Call sp_EndComponentLogging('PITonPREM','Performance', 'Comp1', '[0]', to_char(&__rowcount));
// 				CALL sp_EndComponentLogging('PITonPrem','Performance', 'Comp1', '[0]',to_char(100));
// ------------------------------------------------------------------------
// 
// History:
//   1.0  2021-07-01 Andreas Kurz    Initial version



  
		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;"
  
  		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}
		
		sqlStmt = "";
        sqlStmt = "SELECT MAX(RUN_ID_SEQ) AS RUN_ID_SEQ FROM T_CNTL_ETL_LOGGING_RUN_SEQ_1 WHERE RUN_CLUSTERING_DESC = '" + strRunCluster + "' AND UPPER(APPLICATION_NAME) = '" + PAPPLICATIONNAME.toUpperCase() + "';";

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
        sqlStmt = "UPDATE T_CNTL_ETL_LOGGING_1 SET END_RUN_TS = CURRENT_TIMESTAMP()" +
				  ", RECORD_PROCESSED_NR = COALESCE(try_to_number('" + PRECORDPROCESSEDNR + "'),-1)" + 
                  " WHERE RUN_ID_SEQ = " + res.getColumnValue(1) + " AND RUN_CLUSTERING_DESC = '" + strRunCluster + "' AND UPPER(APPLICATION_NAME) ='" + PAPPLICATIONNAME.toUpperCase() + "' AND UPPER(MODULE_NAME) ='" + PMODULENAME.toUpperCase() + "' AND COMPONENT_NAME ='" + PCOMPONENTNAME + "';";
    
        try{
		    snowflake.createStatement( { sqlText: sqlCommit } ).execute();
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "EndComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;
        }
		
		res.next();

		return res.getColumnValue(1);		
  $$
;