CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_StartModuleLogging (
      pApplicationName      STRING 
    , pModuleName           STRING       
    , pRunClusteringDesc    STRING    
    , pQueryTag             STRING
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  AS
  $$


// ---------------------------------------------------------------------
// PROCEDURE	:	sp_StartModuleLogging(pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
// Input		:   pApplicationName 	STRING 
// 				pModuleName         STRING
// 				pRunClusteringDesc 	STRING --> [0] running in sequence 
// 				pQueryTag           STRING				
// Return		:	Error + Error Msg
// Convert		:	None    
// Description	: 	Initialize Logging 
// Example		:	Call sp_StartModuleLogging('PITonPREM','Performance', '[0]', 'Start Logging');
// 				CALL sp_StartModuleLogging('PITonPrem','Performance', '[0]',QueryTag('ETL Logging','PITonPrem',NULL));
// ------------------------------------------------------------------------
// 
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version
  
		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";

		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}
		
        sqlStmt = "SELECT max(RUN_ID_SEQ) AS RUN_ID_SEQ FROM T_CNTL_ETL_LOGGING_RUN_SEQ_2 WHERE RUN_CLUSTERING_DESC = '" + strRunCluster + "' AND APPLICATION_NAME = '" + PAPPLICATIONNAME.toUpperCase() + "';";
        // Retrieve next Seq RunID
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartModuleLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
        res.next();
        // res.getColumnValue(1) = RUN_ID_SEQ

		sqlStmt = "";
        sqlStmt = "INSERT INTO T_CNTL_ETL_LOGGING_2 (RUN_ID_SEQ, RUN_TS, RUN_DAY_ID,RUN_CLUSTERING_DESC,APPLICATION_NAME, MODULE_NAME, QUERY_TAG,MODULE_LEVEL_FLAG) VALUES (" +
                  res.getColumnValue(1) + ", CURRENT_TIMESTAMP(), CURRENT_DATE(), '" + strRunCluster + "','" +  PAPPLICATIONNAME.toUpperCase() + "','" +  PMODULENAME.toUpperCase() + "','"+ PQUERYTAG + "',1);"; 

        try{
            snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartModuleLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;
        }
		
		res.next();

		return res.getColumnValue(1);		
$$
;