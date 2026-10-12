CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_StartLogging (
      pApplicationName      STRING 
    , pRunClusteringDesc    STRING    
    , pQueryTag             STRING
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  EXECUTE AS CALLER
  AS
  $$

// ---------------------------------------------------------------------
// PROCEDURE_	:	sp_StartLogging(pApplicationName STRING, pRunClusteringDesc STRING, pQueryTag STRING)/
// Input		:   pApplicationName 	STRING 
// 				pRunClusteringDesc 	STRING --> [0] running in sequence
// 				pQueryTag STRING 
// Return		:	Error + Error Msg
// Convert		:	None    
// Description	: 	Initialize Logging 
// Example		:	Call sp_StartLogging('PITonPREM', '[0]', 'Start Logging');
// 				CALL sp_StartLogging('PITonPrem','[0]',QueryTag('ETL Logging','PITonPrem',NULL));
// ------------------------------------------------------------------------
// 
// History:
//  1.0  2021-07-01 Andreas Kurz    Initial version

		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";
		var sqlBeginTransaction  = "BEGIN TRANSACTION;", sqlCommit = "COMMIT;"	
		
		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}
		
        //sqlStmt = "SELECT SEQ_CNTL_ETL_LOGGING.NEXTVAL;"
		sqlStmt = "SELECT COALESCE(MAX(RUN_ID_SEQ),0)+1 AS NEXT_RUN_ID_SEQ FROM T_CNTL_ETL_LOGGING_RUN_SEQ;"

        // Retrieve next Seq RunID
        try{
            snowflake.createStatement( { sqlText: sqlBeginTransaction } ).execute();
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
		
			msg = "P_STARTPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;
        }
        res.next();
        // res.getColumnValue(1) = RUN_ID_SEQ

		sqlStmt = "";
        sqlStmt = "INSERT INTO T_CNTL_ETL_LOGGING (RUN_ID_SEQ, RUN_CLUSTERING_DESC,APPLICATION_NAME,QUERY_TAG,START_PROCESSIG_FLAG) VALUES (" +
                  res.getColumnValue(1) + ",'" + strRunCluster + "','" +  PAPPLICATIONNAME.toUpperCase() + "','" + PQUERYTAG + "',1);"; 

        try{
            snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
			msg = "P_STARTPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }

		sqlStmt = "";
        sqlStmt = "INSERT INTO T_CNTL_ETL_LOGGING_RUN_SEQ (RUN_ID_SEQ, RUN_TS, RUN_DAY_ID,RUN_CLUSTERING_DESC,APPLICATION_NAME) VALUES (" +
                  res.getColumnValue(1) + ", CURRENT_TIMESTAMP(), CURRENT_DATE(), '" + strRunCluster + "','" +  PAPPLICATIONNAME.toUpperCase() + "');"; 
        try{
            snowflake.createStatement( { sqlText: sqlStmt } ).execute();
			snowflake.createStatement( { sqlText: sqlCommit } ).execute();
        } catch (ERROR){
			msg = "P_STARTPROCESSING: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
		res.next();

		// return run seq
		return res.getColumnValue(1);			
$$
;