CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.P_MSTR_COLLECT_STATS(MSTR_VOLATILE_TABLE VARCHAR, MSTR_COLUMNNAMELIST VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
 	var resultSetCounter = 0;
	var tablelist = new Array;
	MSTR_STATS: {
	   {
	      var Start_Time;
	      var EXIT_Status = `1`;
	      var EXIT_Message = ``;
	      var EXIT_Condition = {
	         sqlstate : `EXIT_Condition`
	      };
	      var EXIT_Condition_HANDLER = function (error) {
	         //         ;
	         throw error;
	      };
	      var exit_handler_1 = function (error) {
	         {
	            //Conversion warning - Procedure - This statement may be a dynamic sql that could not be recognized and converted 
	            EXIT_Message = `SQLSTATE = ${SqlState}.  SQL Error @:  ${EXIT_Message}`;
	            //            ;
	         }
	         throw error;
	      };
	      var ERROR_HANDLERS = function (error) {
	         switch(error.sqlstate) {
	            case `EXIT_Condition`:EXIT_Condition_HANDLER(error);
	            break;
	            //Conversion Warning - handlers for the switch default (SQLWARNING/SQLEXCEPTION/NOT FOUND) can be the following
	            default:exit_handler_1(error);
	         }
	      };
	      try {
	         //=+=+=+ END OF DECLARE SECTION =+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	         //=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	         //+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	         EXIT_Status = 1;
	      }catch(error) {
	         ERROR_HANDLERS(error)
	      }
	      try {
	         EXIT_Message = `Starting.`;
	      }catch(error) {
	         ERROR_HANDLERS(error)
	      }
	      try {
	         //+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	         if (function () {
	               var sql_stmt = `SELECT NullIf( Trim(` + MSTR_VOLATILE_TABLE + `), '''')`;
	               var stmt = snowflake.createStatement({
	                  sqlText : sql_stmt
	               });
	               var res = stmt.execute();
	               res.next();
	               return res.getColumnValue();
	            }() == null) {
	            //+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	            EXIT_Status = 2;
	            EXIT_Message = `Tablename parameter is NULL or blank.  [TERMINATING!]`;
	            throw EXIT_Condition;
	         }
	      }catch(error) {
	         ERROR_HANDLERS(error)
	      }
	      try {
	         if (function () {
	               var sql_stmt = `SELECT NullIf( Trim(` + MSTR_COLUMNNAMELIST + `), '''')`;
	               var stmt = snowflake.createStatement({
	                  sqlText : sql_stmt
	               });
	               var res = stmt.execute();
	               res.next();
	               return res.getColumnValue();
	            }() == null) {
	            //+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	            EXIT_Status = 3;
	            EXIT_Message = `ColumnNames List parameter is NULL or blank.  [TERMINATING!]`;
	            throw EXIT_Condition;
	         }
	      }catch(error) {
	         ERROR_HANDLERS(error)
	      }
	      try {
	         STAGE_C: {
	            {
	               var COLLECT_Stats_str = `COLLECT STATISTICS USING NO THRESHOLD `;
	               var ColumnName_Str;
	               var SEL_ColumnName_Count = `0`;
	               //+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	               EXIT_Status = 4;
	               EXIT_Message = `Preparing the Collect Statistics Sql.`;
	               LoopA:while ( true ) {
	                  SEL_ColumnName_Count = SEL_ColumnName_Count + 1;
	                  ColumnName_Str = Trim(function () {
	                        var sql_stmt = `SELECT StrTok(` + MSTR_COLUMNNAMELIST + ` , '','', ` + SEL_ColumnName_Count + `)`;
	                        var stmt = snowflake.createStatement({
	                           sqlText : sql_stmt
	                        });
	                        var res = stmt.execute();
	                        res.next();
	                        return res.getColumnValue();
	                     }());
	                  if (ColumnName_Str == null) {
	                     break LoopA;
	                  }
	                  if (Trim(ColumnName_Str) == ``) {
	                     /*Conversion issue - Severity Medium - No Transformation rule found for this node.*/
	                     /*                ITERATE LoopA*/
	                     
	                  }
	                  if (SEL_ColumnName_Count > 1) {
	                     //Conversion warning - Procedure - This statement may be a dynamic sql that could not be recognized and converted 
	                     COLLECT_Stats_str = `${COLLECT_Stats_str},`;
	                  }
	                  //Conversion warning - Procedure - This statement may be a dynamic sql that could not be recognized and converted 
	                  COLLECT_Stats_str = `${COLLECT_Stats_str}${Chr}10  COLUMN (${ColumnName_Str})`;
	               }
	               //+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	               EXIT_Status = 5;
	               EXIT_Message = `Executing the Collect Statistics Sql.`;
	               //+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	               //Conversion warning - Procedure - This statement may be a dynamic sql that could not be recognized and converted 
	               COLLECT_Stats_str = `${COLLECT_Stats_str}${Chr}10ON ${MSTR_Volatile_Table}`;
	               var sql_stmt = `COLLECT_Stats_str`;
	               snowflake.createStatement({
	                  sqlText : sql_stmt
	               }).execute();
	            }
	         }
	      }catch(error) {
	         ERROR_HANDLERS(error)
	      }
	      try {
	         //=+=+=+ END OF COLLECTING MSTR VOLATILE TABLE STATS +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	         //=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	         //
	         // **  Now exit.
	         //
	         //+=+=+=+=+=+=+=+=+=+=+=+=+=+=
	         EXIT_Status = 0;
	      }catch(error) {
	         ERROR_HANDLERS(error)
	      }
	      try {
	         //Conversion warning - Procedure - This statement may be a dynamic sql that could not be recognized and converted 
	         EXIT_Message = `Completed successfully.   Elapsed Time =  ${Current_Timestamp}${Start_Time}20 (Hour to Seconds).`;
	      }catch(error) {
	         ERROR_HANDLERS(error)
	      }
	      try {
	         throw EXIT_Condition;
	      }catch(error) {
	         ERROR_HANDLERS(error)
	      }
	      /*
	       **  Cursor for Exit Code.
	      */
	      var sql_stmt = `            SELECT ${EXIT_Status},
	            ''${EXIT_Message}'';`;
	      var EXIT_cur = snowflake.createStatement({
	         sqlText : sql_stmt
	      }).execute();
	   }
	}
	return tablelist;
 
';