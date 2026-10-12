CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_EndModuleLogging (
      pApplicationName      STRING 
    , pModuleName           STRING       
    , pRunClusteringDesc    STRING    
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  AS
  $$
		
// ---------------------------------------------------------------------
// PROCEDURE	:	sp_EndModuleLogging(pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
// Input		:   pApplicationName 	STRING 
// 				pModuleName         STRING
// 				pRunClusteringDesc 	STRING --> [0] running in sequence 
// Return		:	Error + Error Msg
// Convert		:	None    
// Description	: 	Initialize Logging 
// Example		:	Call sp_EndModuleLogging('PITonPREM','Performance', '[0]', 'Start Logging');
//				CALL sp_EndModuleLogging('PITonPrem','Performance', '[0]',QueryTag('ETL Logging','PITonPrem',NULL));
//------------------------------------------------------------------------		
// History:
// 1.0  2021-07-01 Andreas Kurz    Initial version		
		
		
		
		
		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;"

		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}
		
        sqlStmt = "SELECT max(RUN_ID_SEQ) AS RUN_ID_SEQ FROM T_CNTL_ETL_LOGGING_RUN_SEQ_2 WHERE RUN_CLUSTERING_DESC = '" + strRunCluster + "' AND APPLICATION_NAME = '" + PAPPLICATIONNAME.toUpperCase() + "';";

        try{
			snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "EndModuleLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
        res.next();
        // res.getColumnValue(1) = RUN_ID_SEQ

		sqlStmt = "";
        sqlStmt = "UPDATE T_CNTL_ETL_LOGGING_2 SET END_RUN_TS = CURRENT_TIMESTAMP()" +
                  "WHERE RUN_ID_SEQ = " + res.getColumnValue(1) + " AND UPPER(RUN_CLUSTERING_DESC) = '" + strRunCluster + "' AND UPPER(APPLICATION_NAME) ='" + PAPPLICATIONNAME.toUpperCase() + "' AND UPPER(MODULE_NAME) ='" + PMODULENAME.toUpperCase() + "';";
    
        try{
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			snowflake.createStatement( { sqlText: sqlCommit } ).execute();
        } catch (ERROR){
                        msg = "EndModuleLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;
        }
		
		res.next();

		return res.getColumnValue(1);			
  $$
; 