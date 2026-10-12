/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_psnf_Manual2DailyRun
#-------------------------------------------------------------------------------
# Describtion: Procedure to update manualRun Flag  [2] to a Daily Run Flag [3]
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_EK_WA;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_1; 

DROP PROCEDURE IF EXISTS P_LEW_MART_PIT.sp_psnf_Manual2DailyRun(STRING, STRING, DOUBLE)
;
-- DESCRIBE PROCEDURE sp_psnf_Manual2DailyRun(STRING, STRING, DOUBLE)
-- SHOW USER PROCEDURES
-- SELECT get_ddl('PROCEDURE','sp_psnf_Manual2DailyRun')
-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));

Call sp_RunSearchOptimization('P_LEW_MART_PIT_1','PITonCloud','Performance','',100,FALSE);
SELECT * FROM P_LEW_MART_PIT.T_CNTL_PSNF_PROCESSING_PARAM_1 WHERE CLIENT_ID = 23 AND PARAM_ID = 40
*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_psnf_Manual2DailyRun(pApplicationName STRING, pPCLIENTIDingDesc STRING)
Input		:   pClientId 			STRING 
				pSchema				STRING
				pRunMode			DOUBLE [0:: Daily Run 3::
Return		:	Error + Error Msg | Success Nbr of rows (modules and or compenents) of this run
Convert		:	None    
Description	: 	Initialize Logging 
Example		:	Call P_LEW_MART_PIT.sp_psnf_Manual2DailyRun( '23','P_LEW_MART_PIT_1', 3);
------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_psnf_manual2dailyrun(IN pClientId STRING, IN pSchema STRING, IN pRunMode FLOAT64, OUT out_param STRING)
BEGIN
DECLARE _rowCnt BIGNUMERIC;
DECLARE iCnt BIGNUMERIC;
DECLARE iMaxRuns BIGNUMERIC;
DECLARE msg STRING;
DECLARE SQLCODE BIGNUMERIC;
DECLARE SQLSTATE STRING;
DECLARE strClient STRING;
DECLARE sqlStmt STRING;
DECLARE sqlStmtUpd_1 STRING;
DECLARE sqlStmtUpd_2 STRING;
DECLARE sqlBeginTransaction STRING;
DECLARE sqlCommit STRING;
DECLARE strSchema STRING;
DECLARE strParamValueChar STRING;
DECLARE iRunMode BIGNUMERIC;
DECLARE res ARRAY<JSON>;
DECLARE resUpd_1 STRING;
DECLARE resUpd_2 STRING;
DECLARE iterator_res INT64 DEFAULT -1;
SET _rowCnt  =  0;
SET iCnt  =  0;
SET iMaxRuns  =  1;
SET msg  =  '';
SET SQLCODE  =  0;
SET SQLSTATE  =  '00000';
SET strClient  =  '0';
SET sqlStmt  =  '';
SET sqlStmtUpd_1  =  '';
SET sqlStmtUpd_2  =  '';
SET sqlBeginTransaction  =  'BEGIN TRANSACTION';
SET sqlCommit  =  'COMMIT TRANSACTION';
SET strSchema  =  'P_LEW_MART_PIT_1';
SET strParamValueChar  =  '';
SET strClient  =  '-1';
SET iRunMode  =  3;
-- CHECK INPUT PCLIENTID


IF pClientId = '' OR pClientId IS NULL OR (LENGTH(pClientId) = 0)
 OR pClientId IS NULL THEN
    BEGIN
    SET pClientId  =  strClient;
    END;
ELSE
    BEGIN
    SET strClient  =  UPPER(pClientId);
    END;
END IF;

-- CHECK INPUT pSchema


IF pSchema = '' OR pSchema IS NULL OR (LENGTH(pSchema) = 0)
 OR pSchema IS NULL THEN
    BEGIN
    SET pSchema  =  strSchema;
    END;
ELSE
    BEGIN
    SET strSchema  =  pSchema;
    END;
END IF;

-- RunMode must be between 0 or 3


IF pRunMode IS NULL OR pRunMode IS NULL OR IS_NAN(pRunMode) = true
 OR pRunMode = 0 OR pRunMode = 3 THEN
    BEGIN
    SET pRunMode  =  iRunMode;
    END;
END IF;

SET sqlStmt  =  '';
SET sqlStmt  =  '''SELECT 
    pa.CLIENT_ID,
    pa.PARAM_ID,
    pa.VERSION_NR,
    pa.PARAM_VALUE
FROM (
    SELECT 
        CLIENT_ID,
        PARAM_ID,
        VERSION_NR,
        PARAM_VALUE
    FROM `#PSCHEMA#.t_cntl_psnf_processing_param_1`                 
    WHERE TRUE
      AND CLIENT_ID IN (#PCLIENTID#)
      AND DELETED_FG = 0
      AND CURRENT_FG = 1
      AND REJECT_FG = 0
    /* ALWAYS TAKE MAX VERSION NR IGNORE DATE_FROM DATE_TO IN CASE OF ALREADY CLOSED PERIODS */
    QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
) AS pa 

/* PARAM REF */
INNER JOIN (
    SELECT DISTINCT
        PARAM_ID,
        PARAM_NAME,
        PARAM_DESCR,
        PARAM_COLUMN_DATATYPE
    FROM `#PSCHEMA#.t_cntl_dim_processing_param_1`
    WHERE TRUE
      AND UPPER(TRIM(PARAM_NAME)) = UPPER(TRIM('EXEC_PIT_MANUAL_RUN_FG'))
      AND DELETED_FG = 0
      AND REJECT_FG = 0
    -- Deduplication 
    QUALIFY ROW_NUMBER() OVER(PARTITION BY PARAM_ID ORDER BY DWH_UPDATED_TS DESC) = 1                       
) AS par
  ON TRUE
 AND pa.PARAM_ID = par.PARAM_ID
 AND pa.PARAM_VALUE = 2 -- Initial run
''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PCLIENTID#', strClient);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', strSchema);
BEGIN

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'CLIENT_ID,PARAM_ID,VERSION_NR,PARAM_VALUE',  sqlStmt)
INTO res ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'Manual2DailyRun: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  COALESCE(CAST(ARRAY_LENGTH(res) AS BIGNUMERIC), 0);
-- only if exists 2 than 3

SET iterator_res  =  iterator_res  + 1;
WHILE (iterator_res  < ARRAY_LENGTH(res) AND iCnt < iMaxRuns) DO
    BEGIN
    EXECUTE IMMEDIATE (sqlBeginTransaction );
    SET sqlStmtUpd_1  =  '';
    -- SET sqlStmtUpd_1  =  '''
    CALL p_lew_mart_pit.sp_psnf_updateparam( strClient,strSchema, 'EXEC_PIT_MANUAL_RUN_FG', pRunMode , NULL, resUpd_1)
				;	
                -- '''   ;
    -- Variable Substitution

    -- SET sqlStmtUpd_1  =  REGEXP_REPLACE(sqlStmtUpd_1, '#PCLIENTID#', strClient);
    -- SET sqlStmtUpd_1  =  REGEXP_REPLACE(sqlStmtUpd_1, '#PSCHEMA#', strSchema);
    -- SET sqlStmtUpd_1  =  REGEXP_REPLACE(sqlStmtUpd_1, '#PRUNMODE#', pRunMode);
    SET sqlStmtUpd_2  =  '';
    -- SET sqlStmtUpd_2  =  '''
    
     CALL p_lew_mart_pit.sp_psnf_updateparam( strClient,strSchema, 'EXEC_PIT_MANUAL_COUNTRY_LST', NULL , '', resUpd_2);
    -- '''   ;
    -- Variable Substitution

    -- SET sqlStmtUpd_2  =  REGEXP_REPLACE(sqlStmtUpd_2, '#PCLIENTID#', strClient);
    -- SET sqlStmtUpd_2  =  REGEXP_REPLACE(sqlStmtUpd_2, '#PSCHEMA#', strSchema);
    -- SET sqlStmtUpd_2  =  REGEXP_REPLACE(sqlStmtUpd_2, '#PRUNMODE#', pRunMode);
    

    

    EXECUTE IMMEDIATE (sqlCommit);
    BEGIN
    EXCEPTION
    WHEN ERROR THEN
    SET msg  =  CONCAT(
        'Manual2DailyRun: [Failed Statement: ', @@error.statement_text, '] ',
        'MESSAGE: ', @@error.message
    )
    ;
    RAISE USING MESSAGE = msg ;
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
    SET _rowCnt  =  _rowCnt + CAST(GETROWCOUNT(resUpd_1) AS FLOAT64);
    SET _rowCnt  =  _rowCnt + CAST(GETROWCOUNT(resUpd_2) AS FLOAT64);
    SET iCnt  =  iCnt + 1;
    SET iterator_res  =  iterator_res  + 1    ;
    END;
END WHILE;
-- while result set

SET out_param  =  '' || CAST(_rowCnt AS STRING);
SELECT out_param;
RETURN;
END;