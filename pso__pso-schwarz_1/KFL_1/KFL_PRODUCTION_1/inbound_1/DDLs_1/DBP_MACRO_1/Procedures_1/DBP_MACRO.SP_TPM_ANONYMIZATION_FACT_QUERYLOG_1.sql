CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_TPM_ANONYMIZATION_FACT_QUERYLOG(OUTVAR_ERRORTYPE VARCHAR, OUTVAR_SQLSTATE FLOAT, OUTVAR_ERRORCODE VARCHAR, OUTVAR_ERRORMESSAGE VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	//SQL SECURITY CREATOR /* all the rights/privileges available to the procedure will be of the OWNER/CREATOR of the procedure */	
	{
	   /* ===============================================
	    Author 		R.Anschiz
	
	    Cange History 
	     ID		Date		Responsible		Change
	     #001	2019-02-21	R.Anschiz		Anonymizing of MSIUser names after 90 days of retention
	    #002
	    #003
	    #004
	
	      =============================================== 
	    */
	
	   /* ======================== Test_1 CALL ======================== */
	   	// Var_ErrorType	=>  User Defined Error Type
	   	// Var_SQLState 	=>  SQL Exit Status_1
	   	// Var_ErrorCode	=>	System Error Code
	   	// Var_ErrorMessage =>  System Error Message
	    /*
	    DATABASE dbe_mig_data_47; 
	    DATABASE dbp_macro;
	   	CALL sp_tpm_Anonymization_Fact_QueryLog(
	   		Var_ErrorType,
	    Var_ErrorMessage,
	    Var_ErrorCode,
	    Var_SQLState
	    --,OutVar_RowsInserted
	    );
	    */
	    /*
	    SELECT * 
	    FROM tpm_ErrorLogging 
	    --WHERE ObjectName = ''sp_tpm_Anonymization_Fact_QueryLog'' 
	    ORDER BY InsertDateTime;
	   	*/
	   /* ========== Declaration & Necessary Initilization & Exception Handling ========== */
	   var Var_Errorcode;
	   var Var_SQLState;
	   var Var_ErrorMessage;
	   var Var_AnonymizationMSIUserID;	/* Hilfsvariable f?r die Anonymisierung von MSIUser daten */
	   var exit_handler_1 = function (error) {
	      {
	         // F?llen von OUTPUT Parametern und Hilfsvariablen 
	         OutVar_SQLState = SQLSTATE;
	         Var_SQLState = SQLSTATE;
	         OutVar_ErrorCode = SQLCODE;
	         Var_Errorcode = SQLCODE;
	         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	         /*		GET DIAGNOSTICS EXCEPTION 1 OutVar_ErrorMessage = MESSAGE_TEXT*/
	         
	         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	         /*		GET DIAGNOSTICS EXCEPTION 1 Var_ErrorMessage = MESSAGE_TEXT*/
	         
	         OutVar_ErrorType = `Error`;
	         var sql_stmt = `INSERT INTO dbp_data.PUBLIC.tpm_ErrorLogging (
	DBName,
	ObjectName,
	ExceptionType,
	SQLState,
	ErrorCode,
	ErrorMessage,
	InsertDate,
	InsertDateTime) VALUES (
	DATABASE,
	''sp_tpm_Anonymization_Fact_QueryLog'',
	''Error'',
	` + Var_SQLState + `,
	` + Var_Errorcode + `,
	` + Var_ErrorMessage + `,
	CURRENT_DATE,
	CURRENT_TIMESTAMP(0))`;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	      }
	      throw error;
	   };
	   var continue_handler_1 = function (error) {
	      {
	         // F?llen von OUTPUT Parametern und Hilfsvariablen 
	         OutVar_SQLState = SQLSTATE;
	         Var_SQLState = SQLSTATE;
	         OutVar_ErrorCode = SQLCODE;
	         Var_Errorcode = SQLCODE;
	         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	         /*		GET DIAGNOSTICS EXCEPTION 1 OutVar_ErrorMessage = MESSAGE_TEXT*/
	         
	         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	         /*		GET DIAGNOSTICS EXCEPTION 1 Var_ErrorMessage = MESSAGE_TEXT*/
	         
	         OutVar_ErrorType = `Warning`;
	         var sql_stmt = `INSERT INTO dbp_data.PUBLIC.tpm_ErrorLogging (
	DBName,
	ObjectName,
	ExceptionType,
	SQLState,
	ErrorCode,
	ErrorMessage,
	InsertDate,
	InsertDateTime) VALUES (
	DATABASE,
	''sp_tpm_Anonymization_Fact_QueryLog'',
	''Warning'',
	` + Var_SQLState + `,
	` + Var_Errorcode + `,
	` + Var_ErrorMessage + `,
	CURRENT_DATE,
	CURRENT_TIMESTAMP(0) (FORMAT ''YYYY-MM_1-DDBHH:MI:SS'')::CHAR(19)::TIMESTAMP)`;
	         snowflake.createStatement({
	            sqlText : sql_stmt
	         }).execute();
	      }
	   };
	   var ERROR_HANDLERS = function (error) {
	      switch(error.sqlstate) {
	         //Conversion Warning - handlers for the switch default (SQLWARNING/SQLEXCEPTION/NOT FOUND) can be the following
	         default:exit_handler_1(error);
	         continue_handler_1(error);
	      }
	   };
	   try {
	      var sql_stmt = `			(
					SELECT MSIUserID
					FROM dbp_data.PUBLIC.tpm_Dim_MSIUser
					WHERE MSIUserName = ''Anonymized''
				)`;
	      var stmt = snowflake.createStatement({
	         sqlText : sql_stmt
	      });
	      var res = stmt.execute();
	      res.next();
	      var subQueryVariable0 = res.getColumnValue(1);
	      // ====================== Initilization ====================== 
	      // ===================== Implementation ====================== 
	      // #003 Anonymizing of MSIUser names after 90 days of retention 
	      Var_AnonymizationMSIUserID = subQueryVariable0;
	   }catch(error) {
	      ERROR_HANDLERS(error)
	   }
	   try {
	      var sql_stmt = `	UPDATE dbp_data.PUBLIC.tpm_Fact_QueryLog
		SET MSIUserID = ` + Var_AnonymizationMSIUserID + `
		WHERE CAST(StartDateID AS DATE) <= CURRENT_DATE - 90`;
	      snowflake.createStatement({
	         sqlText : sql_stmt
	      }).execute();
	   }catch(error) {
	      ERROR_HANDLERS(error)
	   }
	}
 
';