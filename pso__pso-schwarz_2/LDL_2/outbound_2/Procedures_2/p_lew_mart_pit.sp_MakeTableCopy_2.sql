/*
USE ROLE		R_LDL_D_PIT_ETL;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT; 
--USE DATABASE 	LDL_PRODUCTION_CLONE_EK_WA;
--USE DATABASE LDL_PRODUCTION_CLONE_PIT_UWG_2023_04_21;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS; 
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_CLONE_PARAM_TESTING;
USE SCHEMA 		P_LEW_MART_PIT_2;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;

SELECT '>>> ${EXEC_PIT_TIMESTAMP}  Creating Procedure sp_MakeTableCopy [SP Procedure general use on PITonCloud]' AS ""
;


DROP PROCEDURE IF EXISTS sp_MakeTableCopy(STRING, STRING, BOOLEAN)
;
-- DESCRIBE PROCEDURE sp_MakeTableCopy(STRING, STRING, BOOLEAN)
-- SHOW USER PROCEDURES
-- SELECT get_ddl('PROCEDURE','P_LEW_MART_PIT.sp_MakeTableCopy')
-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));

*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_MakeTableCopy(pSchema STRING, pTableName STRING )
Input		:   pSchema 				STRING 
				pTableName 				STRING
				pExecute				BOOLEAN
				pScope				BOOLEAN (True/False) for BEGIN Transaction and Commit. Default is FALSE not BT and COMMIT				
Return		:	Error + Error Msg or in success case name of backuped table
Convert		:	None    
Description	: 	Copies / backup important tables 
				Format: #PSCHEMA#.#PTABLENAME#_{Current TS:: YYYYMMDD_H24MISS}_TMP
Example		:	Call sp_MakeTableCopy('P_LEW_MART_PIT_2');
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_maketablecopy(IN pSchema STRING, IN pTableName STRING,IN pExecute BOOLEAN, OUT out_param STRING)
BEGIN
DECLARE _rowCnt BIGNUMERIC;
DECLARE iCnt BIGNUMERIC;
DECLARE iMaxRuns BIGNUMERIC;
DECLARE strRunCluster STRING;
DECLARE SQLCODE BIGNUMERIC;
DECLARE SQLSTATE STRING;
DECLARE msg STRING;
DECLARE sqlStmt STRING;
DECLARE strTS STRING;
DECLARE strRAND STRING;
DECLARE res ARRAY<JSON>;
DECLARE iterator_res INT64 DEFAULT -1;
-- ---------------------------------------------------------------------
-- PROCEDURE	:	sp_MakeTableCopy(pSchema STRING, pTableName STRING )
-- Input		:   pSchema 				STRING
-- 				pTableName 				STRING
-- Return		:	Error + Error Msg or in success case name of backuped table
-- Convert		:	None
-- Description	: 	Copies / backup important tables
-- 				Format: #PSCHEMA#.#PTABLENAME#_{Current TS:: YYYYMMDD_H24MISS}_TMP
-- Example		:	Call sp_MakeTableCopy('P_LEW_MART_PIT_ONPREM');
-- ------------------------------------------------------------------------
-- History:
--  1.0  2021-07-01 Andreas Kurz    Initial version

SET _rowCnt  =  0;
SET iCnt  =  0;
SET iMaxRuns  =  100;
SET strRunCluster  =  '[0]';
SET SQLCODE  =  0;
SET SQLSTATE  =  '00000';
SET msg  =  '';
SET sqlStmt  =  '';
SET strTS  =  '';
-- CHECK INPUT PSCHEMA


IF pExecute IS NULL OR pExecute = FALSE THEN
        SET out_param = 'NO COPY_: Logging === false: [' || IFNULL(pSchema, 'NULL') || '.' || IFNULL(pTableName, 'NULL') || ']';
        RETURN;
    END IF;


IF pSchema = '' OR pSchema IS NULL THEN
    BEGIN
    SET msg  =  'P_MakeTableCopy: [Missing or wrong Parameter PSCHEMA] ';
    RAISE USING MESSAGE = msg ;
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
END IF;

-- CHECK INPUT PTABLENAME


IF pTableName = ''  OR pTableName IS NULL THEN
    BEGIN
    SET msg  =  'P_MakeTableCopy: [Missing or wrong Parameter PTABLENAME] ';
    RAISE USING MESSAGE = msg ;
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
END IF;

-- Format YYYYMMDD_HHMISS 
SET strRAND = `dbp_etl._rand`(1, 9999, 4);
SET strTS = FORMAT_TIMESTAMP('%Y%m%d_%H%M%S', CURRENT_TIMESTAMP());

SET sqlStmt  =  '''select 1 
					from #PSCHEMA#.INFORMATION_SCHEMA.TABLES 
					where LOWER(table_schema) = '#PSCHEMA#'
          and LOWER(table_name)   = '#PTABLENAME#' ''';


-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', LOWER(pSchema));
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PTABLENAME#', LOWER(pTableName));
-- Retrieve from all uses tables

BEGIN

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  '1',  sqlStmt)
INTO res ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_MakeTableCopy: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  COALESCE(CAST(ARRAY_LENGTH(res) AS BIGNUMERIC), 0);

IF _rowCnt > 0 THEN
    BEGIN
    SET sqlStmt  =  '''
						CREATE TABLE IF NOT EXISTS #PSCHEMA#.#PTABLENAME#_#TS#_TMP
							CLONE #PSCHEMA#.#PTABLENAME#;
					''';
    -- Variable Substitution

    SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', LOWER(pSchema));
    SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PTABLENAME#', LOWER(pTableName));
    SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#TS#', strTS);
    -- Retrieve from all uses tables

    BEGIN

    EXECUTE IMMEDIATE (sqlStmt);
    EXCEPTION
    WHEN ERROR THEN
    SET msg  =  'P_MakeTableCopy: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
    RAISE USING MESSAGE = msg ;
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
    SET out_param  =  pSchema || '.' || pTableName || '_' || strTS || '_TMP';
    SELECT out_param;
    RETURN;
    END;
ELSE
    SET out_param  =  'NO COPY: TABLE or Schema does not exist: [' || pSchema || '.' || pTableName || ']';
    SELECT out_param;
    RETURN;
END IF;

END;


 -- End of sp_MakeTableCopy

/*
Call sp_MakeTableCopy('P_LEW_MART_PIT_2','T_CNTL_ETL_LOGGING_2',true);
CALL P_LEW_MART_PIT.sp_MakeTableCopy('P_LEW_MART_PIT_2','T_CNTL_PROCESSING_PARAM_2',true);
CALL P_LEW_MART_PIT.sp_MakeTableCopy('P_LEW_MART_PIT_2','T_CNTL_ETL_LOGGING_2',True)
Call sp_MakeTableCopy('${SCHEMA}','T_CNTL_ETL_LOGGING_2',${PIT_EXECUTE_COPYTABLE});

SHOW TABLES LIKE 'T_CNTL_ETL_LOGGING_2%';
*/
/* --- EOF - END OF FILE --- */