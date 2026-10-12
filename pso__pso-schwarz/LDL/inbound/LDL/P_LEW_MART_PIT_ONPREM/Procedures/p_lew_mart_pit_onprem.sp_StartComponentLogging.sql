CREATE OR REPLACE PROCEDURE P_LEW_MART_PIT_ONPREM.sp_StartComponentLogging (
      pApplicationName      STRING 
    , pModuleName           STRING  
    , pComponentName        STRING  
    , pRunClusteringDesc    STRING    
    , pQueryTag             STRING
)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  STRICT
  AS
  $$
  
// ---------------------------------------------------------------------
// PROCEDURE	:	sp_StartComponentLogging(pApplicationName STRING, pModuleName STRING, pComponentName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
// Input		:   pApplicationName 	STRING 
// 				pModuleName         STRING
// 				pComponentName      STRING
// 				pRunClusteringDesc 	STRING --> [0] running in sequence 
// 				pQueryTag           STRING				
// Return		:	Error + Error Msg
// Convert		:	None    
// Description	: 	Initialize Logging 
// Example		:	Call sp_StartComponentLogging('PITonPREM','Performance', '[0]', 'Start Logging');
// 				CALL sp_StartComponentLogging('PITonPrem','Performance', '[0]',QueryTag('ETL Logging','PITonPrem',NULL));
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version

		var strRunCluster = "[0]", SQLCODE = 0, SQLSTATE = '00000', msg = "", sqlStmt = "";

		// CHECK INPUT runcluster 
		if ((PRUNCLUSTERINGDESC === "") || (typeof(PRUNCLUSTERINGDESC) === "undefined") || (PRUNCLUSTERINGDESC.length === 0) || (PRUNCLUSTERINGDESC === null)) { 
			PRUNCLUSTERINGDESC = strRunCluster; 
		} else {
			strRunCluster = PRUNCLUSTERINGDESC.toUpperCase();
		}
 
		sqlStmt = "SELECT max(RUN_ID_SEQ) AS RUN_ID_SEQ FROM T_CNTL_ETL_LOGGING_RUN_SEQ WHERE RUN_CLUSTERING_DESC = '" + strRunCluster + "' AND UPPER(APPLICATION_NAME) = '" + PAPPLICATIONNAME.toUpperCase() + "';";
        // Retrieve next Seq RunID
        try{
            
            var res = snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			
        }
        res.next();
        // res.getColumnValue(1) = RUN_ID_SEQ

		sqlStmt = "";
        sqlStmt = "INSERT INTO T_CNTL_ETL_LOGGING (RUN_ID_SEQ, RUN_TS, RUN_DAY_ID,RUN_CLUSTERING_DESC,APPLICATION_NAME, MODULE_NAME, COMPONENT_NAME, QUERY_TAG,COMPONENT_LEVEL_FLAG) VALUES (" +
                  res.getColumnValue(1) + ", CURRENT_TIMESTAMP(), CURRENT_DATE(), '" + strRunCluster + "','" +  PAPPLICATIONNAME.toUpperCase() + "','" +  PMODULENAME.toUpperCase() + "','" +  PCOMPONENTNAME + "','"+ PQUERYTAG + "',1);"; 

        try{
            snowflake.createStatement( { sqlText: sqlStmt } ).execute();
        } catch (ERROR){
            msg = "StartComponentLogging: [" + sqlStmt + "]" + ERROR.code + "SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;			

        }
		res.next();

		return res.getColumnValue(1);
$$
; -- End of sp_StartComponentLogging (including QueryTag param)
