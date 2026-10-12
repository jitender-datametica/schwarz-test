/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_ExportLogging
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-08-28 Nikolai Toknov    Initial version
#-------------------------------------------------------------------------------
*/
/*
call P_LEW_MART_PIT.sp_ExportLogging (123,'PSNF','1','P_LEW_MART_PIT','TEST','', '')
*/



CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_exportlogging(IN PLOADID STRING, IN PPROJECTNAME STRING, IN pClientId STRING, IN PSCHEMA STRING, IN PTABLENAME STRING, IN PDAYDTMIN STRING, IN PDAYDTMAX STRING, OUT out_param STRING)
BEGIN
DECLARE strRunCluster STRING;
DECLARE sqlBeginTransaction STRING;
DECLARE strSchema STRING;
DECLARE strTableName STRING;
DECLARE strLoadID STRING;
DECLARE strDayDtMin STRING;
DECLARE strDayDtMax STRING;
DECLARE sqlStmt STRING;
DECLARE msg STRING;
SET strRunCluster  =  '[0]';
SET sqlBeginTransaction  =  'BEGIN TRANSACTION';
SET strSchema  =  'P_LEW_MART_PIT';
SET strTableName  =  '';
SET strLoadID  =  '-2';
SET strDayDtMin  =  '1900-01-01';
SET strDayDtMax  =  '9999-12-31';
-- CHECK INPUT pDayDtMin


IF PDAYDTMIN = '' OR PDAYDTMIN IS NULL  THEN
    BEGIN
    SET PDAYDTMIN  =  strDayDtMin;
    END;
ELSE
    BEGIN
    SET strDayDtMin  =  UPPER(PDAYDTMIN);
    END;
END IF;

-- CHECK INPUT PDAYDTMAX


IF PDAYDTMAX = '' OR PDAYDTMAX IS NULL  THEN
    BEGIN
    SET PDAYDTMAX  =  strDayDtMax;
    END;
ELSE
    BEGIN
    SET strDayDtMax  =  UPPER(PDAYDTMAX);
    END;
END IF;

-- CHECK INPUT pParamValueChar


IF PLOADID = '' OR PLOADID IS NULL  THEN
    BEGIN
    SET PLOADID  =  strLoadID;
    END;
ELSE
    BEGIN
    SET strLoadID  =  UPPER(PLOADID);
    END;
END IF;

-- CHECK INPUT PSCHEMA


IF PSCHEMA = '' OR PSCHEMA IS NULL  THEN
    BEGIN
    SET PSCHEMA  =  strSchema;
    END;
ELSE
    BEGIN
    SET strSchema  =  UPPER(PSCHEMA);
    END;
END IF;

-- CHECK INPUT PTABLENAME


IF PTABLENAME = '' OR PTABLENAME IS NULL  THEN
    BEGIN
    SET PTABLENAME  =  strTableName;
    END;
ELSE
    BEGIN
    SET strTableName  =  UPPER(PTABLENAME);
    END;
END IF;

SET sqlStmt  =  '';
SET sqlStmt  =  '''INSERT INTO p_lew_mart_pit.t_cntl_export_loading (project_name, schema_name, table_name, client_id, day_dt_min,  day_dt_max, load_id) (SELECT "#PPROJECTNAME#" AS project_name,   "#PSCHEMA#" AS schema_name,   "#PTABLENAME#" AS table_name,   #PCLIENTID# AS client_id,   PARSE_DATE("%F", "#PDAYDTMIN#") AS day_dt_min,   PARSE_DATE("%F", "#PDAYDTMAX#") AS day_dt_max,   #PLOADID# AS load_id) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPROJECTNAME#', UPPER(PPROJECTNAME));
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', strSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PTABLENAME#', strTableName);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PCLIENTID#', pClientId);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PDAYDTMIN#', PDAYDTMIN);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PDAYDTMAX#', PDAYDTMAX);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PLOADID#', strLoadID);
BEGIN

EXECUTE IMMEDIATE (sqlStmt);
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_STARTPROCESSING: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
END;

