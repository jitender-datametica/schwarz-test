CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_endmodulelogging(IN PAPPLICATIONNAME STRING, IN PMODULENAME STRING, IN PRUNCLUSTERINGDESC STRING, OUT out_param STRING)
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
-- PROCEDURE	:	sp_EndModuleLogging(pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pQueryTag STRING)
-- Input		:   pApplicationName 	STRING
-- 				pModuleName         STRING
-- 				pRunClusteringDesc 	STRING --> [0] running in sequence
-- Return		:	Error + Error Msg
-- Convert		:	None
-- Description	: 	Initialize Logging
-- Example		:	Call sp_EndModuleLogging('PITonPREM','Performance', '[0]', 'Start Logging');
--				CALL sp_EndModuleLogging('PITonPrem','Performance', '[0]',QueryTag('ETL Logging','PITonPrem',NULL));
--------------------------------------------------------------------------
-- History:
-- 1.0  2021-07-01 Andreas Kurz    Initial version

SET strRunCluster  =  '[0]';
SET SQLCODE  =  0;
SET SQLSTATE  =  '00000';
SET msg  =  '';
SET sqlStmt  =  '';
SET sqlBeginTransaction  =  'BEGIN TRANSACTION';
SET sqlCommit  =  'COMMIT TRANSACTION';
-- CHECK INPUT runcluster


IF PRUNCLUSTERINGDESC = '' OR PRUNCLUSTERINGDESC IS NULL
 OR PRUNCLUSTERINGDESC IS NULL THEN
    BEGIN
    SET PRUNCLUSTERINGDESC  =  strRunCluster;
    END;
ELSE
    BEGIN
    SET strRunCluster  =  UPPER(PRUNCLUSTERINGDESC);
    END;
END IF;

SET sqlStmt  =  '''SELECT MAX(run_id_seq) AS run_id_seq FROM p_lew_mart_pit_onprem.t_cntl_etl_logging_run_seq_1 WHERE run_clustering_desc = "'''|| strRunCluster ||'''"  AND application_name = "'''||UPPER(PAPPLICATIONNAME)||'''" ''';
BEGIN

EXECUTE IMMEDIATE (sqlBeginTransaction);

EXECUTE IMMEDIATE (sqlStmt)
INTO res ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'EndModuleLogging: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
-- res.getColumnValue(1) = RUN_ID_SEQ

SET sqlStmt  =  '';
SET sqlStmt  =  'UPDATE p_lew_mart_pit_onprem.t_cntl_etl_logging_1 SET end_run_ts = CAST(CURRENT_TIMESTAMP() AS DATETIME)' || 'WHERE run_id_seq = ' || res || ' AND UPPER(run_clustering_desc) = \''||strRunCluster||'\' AND UPPER(application_name) =\''||UPPER(PAPPLICATIONNAME)||'\' AND UPPER(module_name) =\''||UPPER(PMODULENAME)||'\';';
BEGIN

EXECUTE IMMEDIATE (sqlStmt);

EXECUTE IMMEDIATE (sqlCommit);
EXCEPTION
WHEN ERROR THEN
SET msg  =  'EndModuleLogging: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET out_param  =  NULL;
SELECT out_param;
RETURN;
END;