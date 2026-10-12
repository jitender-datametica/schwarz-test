CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_startmodulelogging(IN PAPPLICATIONNAME STRING, IN PMODULENAME STRING, IN PRUNCLUSTERINGDESC STRING, IN PQUERYTAG STRING, OUT out_param STRING)
BEGIN
DECLARE strRunCluster STRING;
DECLARE SQLCODE BIGNUMERIC;
DECLARE SQLSTATE STRING;
DECLARE msg STRING;
DECLARE sqlStmt STRING;
DECLARE res INT64;
-- ---------------------------------------------------------------------
-- PROCEDURE	:	sp_StartModuleLogging(pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
-- Input		:   pApplicationName 	STRING
-- 				pModuleName         STRING
-- 				pRunClusteringDesc 	STRING --> [0] running in sequence
-- 				pQueryTag           STRING
-- Return		:	Error + Error Msg
-- Convert		:	None
-- Description	: 	Initialize Logging
-- Example		:	Call sp_StartModuleLogging('PITonPREM','Performance', '[0]', 'Start Logging');
-- 				CALL sp_StartModuleLogging('PITonPrem','Performance', '[0]',QueryTag('ETL Logging','PITonPrem',NULL));
-- ------------------------------------------------------------------------
--
-- # History:
-- #  1.0  2021-07-01 Andreas Kurz    Initial version

SET strRunCluster  =  '[0]';
SET SQLCODE  =  0;
SET SQLSTATE  =  '00000';
SET msg  =  '';
SET sqlStmt  =  '';
-- CHECK INPUT runcluster


IF PRUNCLUSTERINGDESC = '' OR PRUNCLUSTERINGDESC IS NULL THEN
    BEGIN
    SET PRUNCLUSTERINGDESC  =  strRunCluster;
    END;
ELSE
    BEGIN
    SET strRunCluster  =  UPPER(PRUNCLUSTERINGDESC);
    END;
END IF;

SET sqlStmt  =  '''SELECT MAX(run_id_seq) AS run_id_seq FROM p_lew_mart_pit_onprem.t_cntl_etl_logging_run_seq_2 WHERE run_clustering_desc = "'''|| strRunCluster ||'''"  AND application_name = "'''||UPPER(PAPPLICATIONNAME)||'''" ''';
-- Retrieve next Seq RunID

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
INTO res ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'StartModuleLogging: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
-- res.getColumnValue(1) = RUN_ID_SEQ

SET sqlStmt  =  '';
SET sqlStmt  =  'INSERT INTO p_lew_mart_pit_onprem.t_cntl_etl_logging_2 (run_id_seq, run_ts, run_day_id,run_clustering_desc,application_name, module_name, query_tag,module_level_flag) VALUES (' || res || ', CAST(CURRENT_TIMESTAMP()AS DATETIME), CURRENT_DATE("Europe/Berlin"), \''||strRunCluster||'\',\''||UPPER(PAPPLICATIONNAME)||'\',\''||UPPER(PMODULENAME)||'\',\''||PQUERYTAG||'\',1);';
BEGIN

EXECUTE IMMEDIATE (sqlStmt);
EXCEPTION
WHEN ERROR THEN
SET msg  =  'StartModuleLogging: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET out_param  =  NULL;
SELECT out_param;
RETURN;
END;