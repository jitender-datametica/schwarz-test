
CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_endcomponentlogging(IN PAPPLICATIONNAME STRING, IN PMODULENAME STRING, IN PCOMPONENTNAME STRING, IN PRUNCLUSTERINGDESC STRING, IN PRECORDPROCESSEDNR STRING, OUT out_param STRING)
BEGIN
DECLARE strRunCluster STRING;
DECLARE SQLCODE BIGNUMERIC;
DECLARE SQLSTATE STRING;
DECLARE msg STRING;
DECLARE sqlStmt STRING;
DECLARE sqlBeginTransaction STRING;
DECLARE sqlCommit STRING;
DECLARE res INT64;
-- ---------------------------------------------------------------------
-- PROCEDURE	:	sp_EndComponentLogging(pApplicationName STRING, pModuleName STRING, pComponentName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
-- Input		:   pApplicationName 	STRING
--				pModuleName         STRING
-- 				pComponentName      STRING
-- 				pRunClusteringDesc 	STRING --> [0] running in sequence
-- 				pRecordProcessedNr	STRING --> number of recoreds written
-- Return		:	Error + Error Msg
-- Convert		:	None
-- Description	: 	Initialize Logging
-- Example		:	Call sp_EndComponentLogging('PITonPREM','Performance', 'Comp1', '[0]', to_char(&__rowcount));
-- 				CALL sp_EndComponentLogging('PITonPrem','Performance', 'Comp1', '[0]',to_char(100));
-- ------------------------------------------------------------------------
--
-- History:
--   1.0  2021-07-01 Andreas Kurz    Initial version

SET strRunCluster  =  '[0]';
SET SQLCODE  =  0;
SET SQLSTATE  =  '00000';
SET msg  =  '';
SET sqlStmt  =  '';
SET sqlBeginTransaction  =  'BEGIN TRANSACTION';
SET sqlCommit  =  'COMMIT TRANSACTION';
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

SET sqlStmt  =  '';
SET sqlStmt  =  '''SELECT MAX(run_id_seq) AS run_id_seq FROM p_lew_mart_pit_onprem.t_cntl_etl_logging_run_seq_1 WHERE run_clustering_desc = "'''||strRunCluster||'''"  AND UPPER(application_name) = "'''||UPPER(PAPPLICATIONNAME)||'''" ''';
BEGIN

EXECUTE IMMEDIATE (sqlBeginTransaction);

EXECUTE IMMEDIATE (sqlStmt)
INTO res ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'EndComponentLogging: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
-- res.getColumnValue(1) = RUN_ID_SEQ

SET sqlStmt  =  '';
SET sqlStmt  =  'UPDATE p_lew_mart_pit_onprem.t_cntl_etl_logging_1 set end_run_ts = CAST(CURRENT_TIMESTAMP() AS DATETIME)' || ', record_processed_nr = COALESCE(CAST(SAFE_CAST(\''||PRECORDPROCESSEDNR||'\' AS BIGNUMERIC)AS INTEGER),-1)' || ' WHERE run_id_seq = ' || res || ' AND run_clustering_desc = \''||strRunCluster||'\' AND UPPER(application_name) =\''||UPPER(PAPPLICATIONNAME)||'\' AND UPPER(module_name) =\''||UPPER(PMODULENAME)||'\' AND component_name =\''||PCOMPONENTNAME||'\';';
BEGIN

EXECUTE IMMEDIATE (sqlCommit);

EXECUTE IMMEDIATE (sqlStmt);
EXCEPTION
WHEN ERROR THEN
SET msg  =  'EndComponentLogging: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
SET out_param  =  msg;
RAISE USING MESSAGE = msg ;
RETURN;
END;
SET out_param  =  NULL;
SELECT out_param;
RETURN;
END;