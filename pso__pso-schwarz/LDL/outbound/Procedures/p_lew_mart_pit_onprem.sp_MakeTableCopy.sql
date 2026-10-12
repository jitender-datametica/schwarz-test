CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_maketablecopy(IN pSchema STRING, IN pTableName STRING, OUT out_param STRING)
BEGIN
DECLARE _rowCnt INT64;
DECLARE iCnt INT64;
DECLARE iMaxRuns INT64;
DECLARE strRunCluster STRING;
DECLARE SQLCODE INT64;
DECLARE SQLSTATE STRING;
DECLARE msg STRING;
DECLARE sqlStmt STRING;
DECLARE strTS STRING;
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
SET strTS = FORMAT_TIMESTAMP('%Y%m%d_%H%M%S', CURRENT_TIMESTAMP());

SET sqlStmt  =  '''select 1 
					from #PSCHEMA#.INFORMATION_SCHEMA.TABLES 
					where lower(table_schema) = '#PSCHEMA#'
          and lower(table_name)   = '#PTABLENAME#' ''';


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
SET _rowCnt  =  COALESCE(CAST(ARRAY_LENGTH(res) AS INT64), 0);

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

