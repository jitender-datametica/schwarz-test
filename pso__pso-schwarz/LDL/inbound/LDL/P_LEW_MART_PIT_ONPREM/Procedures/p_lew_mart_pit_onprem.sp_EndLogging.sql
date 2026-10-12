CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_EndLogging (
      pApplicationName      STRING 
    , pRunClusteringDesc    STRING    
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  AS
  $$
  
  
// ---------------------------------------------------------------------
// PROCEDURE	:	sp_EndLogging(pApplicationName STRING, pRunClusteringDesc STRING)
// Input		:   pApplicationName 	STRING 
// 				pRunClusteringDesc 	STRING --> [0] running in sequence
// Return		:	Error + Error Msg | Success Nbr of rows (modules and or compenents) of this run
// Convert		:	None    
// Description	: 	Initialize Logging 
// Example		:	Call sp_StartLogging('PITonPREM', '[0]', 'Start Logging');
// 				CALL sp_StartLogging('PITonPrem','[0]',QueryTag('ETL Logging','PITonPrem',NULL));
// ------------------------------------------------------------------------
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
		
        sqlStmt = "SELECT MAX(RUN_ID_SEQ) AS RUN_ID_SEQ FROM T_CNTL_ETL_LOGGING_RUN_SEQ WHERE RUN_CLUSTERING_DESC = '" + strRunCluster + "' AND APPLICATION_NAME = '" + PAPPLICATIONNAME.toUpperCase() + "';";

        try{
			snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
			msg = "P_ENDPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
        res.next();
        // res.getColumnValue(1) = RUN_ID_SEQ

		sqlStmt = "";
        sqlStmt = "UPDATE T_CNTL_ETL_LOGGING SET END_RUN_TS = CURRENT_TIMESTAMP(), END_PROCESSIG_FLAG = 1, COMPLETED_RUN_FLAG = 1 " +
                  "WHERE RUN_ID_SEQ = " + res.getColumnValue(1) + " AND RUN_CLUSTERING_DESC = '" + strRunCluster + "' AND APPLICATION_NAME ='" + PAPPLICATIONNAME.toUpperCase() + "';";
    
        try{
			snowflake.createStatement( { sqlText: sqlCommit } ).execute();
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
			msg = "P_ENDPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
		
		res.next();

		return res.getColumnValue(1);			
  $$
;