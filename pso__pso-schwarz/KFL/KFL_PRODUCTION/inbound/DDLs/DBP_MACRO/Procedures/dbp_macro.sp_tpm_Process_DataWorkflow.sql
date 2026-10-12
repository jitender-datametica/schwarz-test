CREATE OR REPLACE PROCEDURE dbp_macro.sp_tpm_Process_DataWorkflow (OUTVAR_ERRORTYPE STRING,	/* Hilfsvariable f?r Error Handling Error/Warning */ OUTVAR_SQLSTATE STRING,			/* Hilfsvariable f?r Error Handling SQLState */ OUTVAR_ERRORCODE FLOAT,	/* Hilfsvariable f?r Error Handling ErrorCode */ OUTVAR_ERRORMESSAGE STRING /* Hilfsvariable f?r Error Handling ErrorMessage */)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	//SQL SECURITY CREATOR /* all the rights/privileges available to the procedure will be of the OWNER/CREATOR of the procedure */	
{
   /* ===============================================
    Author 		R.Anschiz

    Cange History 
     ID		Date		Responsible		Change
     #001	2018-11-26	R.Anschiz		Created
     #002	2019-01-14	R.Anschiz		Execute Proc sp_tpm_process_Fact_QueryLog_UserWM_P() only for WM_P User due to amount of data
     #003	2019-02-21	R.Anschiz		Execute Proc sp_tpm_Anonymization_Fact_QueryLog() for anonymization of MSI User data
     #004	2019-02-21	R.Anschiz		Execute Proc sp_tpm_CleanUp_Fact_QueryLog for clean old data
     #005	2019-03-04	R.Anschiz		Execute Proc_Process_Fact_QueryLog_Aggr for building aggregate table

      =============================================== 
    */

   /* ======================== Test CALL ======================== */
   	// Var_ErrorType	=>  User Defined Error Type
   	// Var_SQLState 	=>  SQL Exit Status
   	// Var_ErrorCode	=>	System Error Code
   	// Var_ErrorMessage =>  System Error Message
    /*
    DATABASE dbe_mig_data_47; 
    DATABASE dbp_macro;
   	CALL sp_tpm_Process_DataWorkflow(
   		Var_ErrorType,
    Var_ErrorMessage,
    Var_ErrorCode,
    Var_SQLState
    );
    */

    /*
    -- Bereinigung Modell - L?schen aller Daten
    DELETE FROM tpm_Fact_QueryLog;
    DELETE FROM tpm_Dim_Account;
    DELETE FROM tpm_Dim_DBUser;
    DELETE FROM tpm_Dim_MSIProjectReport;
    DELETE FROM tpm_Dim_MSIUser;
    DELETE FROM tpm_Dim_QueryAbortion;
    DELETE FROM tpm_Dim_Statement;
    DELETE FROM tpm_Dim_WorkloadDefinition;
    */
   	/*
   	DATABASE dbp_data;
    SELECT * FROM tpm_ErrorLogging ErrLog
    --WHERE ErrLog.ObjectName = 'sp_tpm_Process_DataWorkflow'
    ORDER BY ErrLog.InsertDateTime DESC
    ;
    */
   	/*
   	DATABASE dbp_data;
    SELECT CAST('tpm_Fact_QueryLog' AS VARCHAR(100)) AS "Object", COUNT(*) AS RowCount  FROM tpm_Fact_QueryLog
    UNION ALL
    SELECT 'tpm_Dim_Account' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_Account
    UNION ALL
    SELECT 'tpm_Dim_DBUser' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_DBUser
    UNION ALL
    SELECT 'tpm_Dim_Error' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_Error
    UNION ALL
    SELECT 'tpm_Dim_LockLevel' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_LockLevel
    UNION ALL
    SELECT 'tpm_Dim_MSIProjectReport' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_MSIProjectReport
    UNION ALL
    SELECT 'tpm_Dim_MSIUser' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_MSIUser
    UNION ALL
    SELECT 'tpm_Dim_QueryAbortion' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_QueryAbortion
    UNION ALL
    SELECT 'tpm_Dim_StartingHour' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_StartingHour
    UNION ALL
    SELECT 'tpm_Dim_Statement' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_Statement
    UNION ALL
    SELECT 'tpm_Dim_WorkloadDefinition' AS "Object", COUNT(*) AS RowCount FROM tpm_Dim_WorkloadDefinition
    ;

    -- ?berpr?fung auf Duplikate
   	SELECT 	COUNT(*),
   		ProcessID,
   		QueryID,
   		SessionID,
   		--MSIReportID
   		StartDateID
   	FROM 	tpm_Fact_QueryLog
   	WHERE MSIReportId <> '00000000000000000000000000000000'
   	GROUP BY 
   		ProcessID,
   		QueryID,
   		SessionID,
   		--MSIReportID,
   		StartDateID
   	HAVING COUNT(*) > 1
    */
   /* ========== Declaration & Necessary Initilization & Exception Handling ========== */
   	/* Error Handling Variables */
   var Var_ErrorType;
   var Var_SQLState;
   var Var_Errorcode;
   var Var_ErrorMessage;
   var WorkflowStartTime;	/* Hilfsvariable f?r die Pr?fung des Status der letzten Ausf?hrung der Prozedur */
   var MailRecipients;	/* Hilfsvariable f?r den Mailversand ?ber ViewPoint AlertRequest */
   var exit_handler_1 = function (error) {
      {
         // F?llen von OUTPUT Parametern und Hilfsvariablen 
         OutVar_SQLState = SQLSTATE;
         Var_SQLState = SQLSTATE;
         OutVar_ErrorCode = SQLCODE;
         Var_Errorcode = SQLCODE;
         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
         /*		GET DIAGNOSTICS EXCEPTION 1 OutVar_ErrorMessage = MESSAGE_TEXT*/
         ;
         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
         /*		GET DIAGNOSTICS EXCEPTION 1 Var_ErrorMessage = MESSAGE_TEXT*/
         ;
         OutVar_ErrorType = `Error`;
         var sql_stmt = `INSERT INTO dbp_data.tpm_ErrorLogging (
DBName,
ObjectName,
ExceptionType,
SQLState,
ErrorCode,
ErrorMessage,
InsertDate,
InsertDateTime) VALUES (
DATABASE,
'sp_tpm_Process_DataWorkflow',
'Error',
?,
?,
?,
CURRENT_DATE,
CURRENT_TIMESTAMP(0))`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [Var_SQLState,Var_Errorcode,Var_ErrorMessage]
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
         ;
         /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
         /*		GET DIAGNOSTICS EXCEPTION 1 Var_ErrorMessage = MESSAGE_TEXT*/
         ;
         OutVar_ErrorType = `Warning`;
         var sql_stmt = `INSERT INTO dbp_data.tpm_ErrorLogging (
DBName,
ObjectName,
ExceptionType,
SQLState,
ErrorCode,
ErrorMessage,
InsertDate,
InsertDateTime) VALUES (
DATABASE,
'sp_tpm_Process_DataWorkflow',
'Warning',
?,
?,
?,
CURRENT_DATE,
CURRENT_TIMESTAMP(0) /*Warning, Format 'YYYY-MM-DDBHH:MI:SS' removed.*/::CHAR(19)::TIMESTAMP(0))`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [Var_SQLState,Var_Errorcode,Var_ErrorMessage]
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
      // ====================== Initilization ====================== 
      WorkflowStartTime = function () {
            var sql_stmt = `SELECT
CURRENT_TIMESTAMP(0)`;
            var stmt = snowflake.createStatement({
               sqlText : sql_stmt,
               binds : []
            });
            var res = stmt.execute();
            res.next();
            return res.getColumnValue(1);
         }();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      MailRecipients = `SIT-BID-K-DM@mail.schwarz`;
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ===================== Implementation ====================== */
      /* ======= Processing Dimensions - Exception Handling resides inside a particular stored procedure ======= */

      /*  The error log table needs to be checked after every nested call to determine if an exception was generated. 
       If so, the exception needs to be passed to the outer stored procedure error handler by writing the exception in the error log table. 
       After that the outside exception handler process will be able to check for the error associated 
       with the inner stored procedure exception 
       */

      	/* ======= Dim_Account ======= */
      	/* IMPORTANT - OUTPUT Variables of the nested prosedure fill the OUTPUT Variable of the actuall procedure */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Dim_Account(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Dim_Account'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Dim_Account', 							-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Dim_DBUser ======= */
      /* IMPORTANT - OUTPUT Variables of the nested prosedure fill the OUTPUT Variable of the actuall procedure */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Dim_DBUser(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Dim_DBUser'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Dim_DBUser', 							-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Dim_MSIProjectReport ======= */
      /* IMPORTANT - OUTPUT Variables of the nested prosedure fill the OUTPUT Variable of the actuall procedure */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Dim_MSIProjectReport(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Dim_MSIProjectReport'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Dim_MSIProjectReport', 							-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Dim_MSIUser ======= */
      /* IMPORTANT - OUTPUT Variables of the nested prosedure fill the OUTPUT Variable of the actuall procedure */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Dim_MSIUser(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Dim_MSIUser'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Dim_MSIUser', 							-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Dim_QueryAbortion ======= */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Dim_QueryAbortion(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Dim_QueryAbortion'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Dim_QueryAbortion', 					-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Dim_Statement ======= */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Dim_Statement(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Dim_Statement'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Dim_Statement', 						-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Dim_WorkloadDefinition ======= */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Dim_WorkloadDefinition(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Dim_WorkloadDefinition'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Dim_WorkloadDefinition', 						-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Processing Fact tables - Exception Handling resides inside a particular stored procedure ======= */
      	/* ======= Fact_QueryLog ======= */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Fact_QueryLog(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Fact_QueryLog'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Fact_QueryLog', 						-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Fact_QueryLog - User WM_P extra ======= */
      var sql_stmt = `CALL dbp_macro.sp_tpm_process_Fact_QueryLog_UserWM_P(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_process_Fact_QueryLog'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_process_Fact_QueryLog', 						-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Fact_QueryLog_sum - Aggregat ======= */
      var sql_stmt = `CALL dbp_macro.sp_tpm_Fact_QueryLog_Aggr(
CURRENT_DATE, ?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_ErrorCode,Var_SQLState]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_Fact_QueryLog_Aggr'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_Fact_QueryLog_Aggr', 						-- JobName
'TPM - Procedure for process dimensions & fact tables', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= Anonymization MSI User Fact_QueryLog ======= */
      var sql_stmt = `CALL dbp_macro.sp_tpm_Anonymization_Fact_QueryLog(?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [OUTVAR_ERRORTYPE,OUTVAR_ERRORMESSAGE,OUTVAR_ERRORCODE,OUTVAR_SQLSTATE]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_Anonymization_Fact_QueryLog'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_Anonymization_Fact_QueryLog', 						-- JobName
'TPM - Procedure for anonymization MSI User data in the Fact_QueryLog ', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {

      /* ======= CleanUp data from Fact_QueryLog ======= */
      var sql_stmt = `CALL dbp_macro.sp_tpm_CleanUp_Fact_QueryLog(
60,		--IN RetainDayRange SMALLINT,	/* Anzahl der Tage, die in der Faktentabelle vorgehalten werden */
?, ?, ?, ?
)`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_ErrorCode,Var_SQLState]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_CleanUp_Fact_QueryLog'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_CleanUp_Fact_QueryLog', 						-- JobName
'TPM - Procedure for clean up old data in the Fact_QueryLog ', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      /* ======= Collecting Statistics ======= */
      /* Statistiken werden ?ber StatsManager Portlet in ViewPoint gesammelt */
      //	CALL dbp_macro.sp_tpm_Process_CollectStatistics(
      //		OutVar_ErrorType,
      // 		OutVar_ErrorMessage,
      // 		OutVar_ErrorCode,
      // 		OutVar_SQLState
      // 	);
      /* F?llen von Variablen (innerhalb der Prozedur) mit Werte des protokollierten Datensatzes der ErrroLogging-Tabelle */
      var sql_stmt = `SELECT
ExceptionType,
ErrorMessage,
ErrorCode,
SQLState
	INTO ?, ?, ?, ?
FROM dbp_data.tpm_ErrorLogging
	WHERE	DBName = DATABASE
AND	ObjectName = 'sp_tpm_Process_CollectStatistics'
AND ExceptionType = 'Error'
AND InsertDateTime >= ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [Var_ErrorType,Var_ErrorMessage,Var_Errorcode,Var_SQLState,WorkflowStartTime]
      }).execute();
   }catch(error) {
      ERROR_HANDLERS(error)
   }
   try {
      // Create an AlertRequest in ViewPoint to send an EMail notification in case of an error 
      if (Var_ErrorType == `Error`) {
         var sql_stmt = `INSERT INTO DBCMNGR.AlertRequest (ReqDate, ReqTime, JobName, Description, EventValue, ActionCode, RepeatPeriod, Destination, Message) VALUES (CURRENT_DATE,CURRENT_TIME,
'sp_tpm_Process_CollectStatistics', 						-- JobName
'TPM - Procedure for process dimensions & fact tables statistics', -- Description
0, 		-- EventValue
'E', 	-- ActionCode
1, 		-- RepeatPeriod
?,	-- Destination
'' || '0D'XC ||
	'Error Detail =>' || '0D'XC
	|| RPAD('ErrorType:', 14, ' ') || ? || '0D'XC
	|| RPAD('SQLState:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorCode:', 14, ' ') || ? || '0D'XC
	|| RPAD('ErrorMessage:', 14, ' ') || ? || '0D'XC)`;
         snowflake.createStatement({
            sqlText : sql_stmt,
            binds : [MailRecipients,Var_ErrorType,Var_SQLState,Var_Errorcode,Var_ErrorMessage]
         }).execute();
         // Clean up variable value for the next procedure 
         Var_ErrorType = null;
         Var_ErrorMessage = null;
         Var_Errorcode = null;
         Var_SQLState = null;
      }
   }catch(error) {
      ERROR_HANDLERS(error)
   }
}
 
$$;

