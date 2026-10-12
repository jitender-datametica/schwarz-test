CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_startlogging(IN PAPPLICATIONNAME STRING, IN PRUNCLUSTERINGDESC STRING, IN PQUERYTAG STRING, OUT out_param STRING)
BEGIN
DECLARE strRunCluster STRING;
DECLARE SQLCODE BIGNUMERIC;
DECLARE SQLSTATE STRING;
DECLARE msg STRING;
DECLARE sqlStmt STRING;
DECLARE sqlBeginTransaction STRING;
DECLARE sqlCommit STRING;
DECLARE res ARRAY<JSON>;
DECLARE iterator_res INT64 DEFAULT -1;
-- ---------------------------------------------------------------------
-- PROCEDURE_	:	sp_StartLogging(pApplicationName STRING, pRunClusteringDesc STRING, pQueryTag STRING)/
-- Input		:   pApplicationName 	STRING
-- 				pRunClusteringDesc 	STRING --> [0] running in sequence
-- 				pQueryTag STRING
-- Return		:	Error + Error Msg
-- Convert		:	None
-- Description	: 	Initialize Logging
-- Example		:	Call sp_StartLogging('PITonPREM', '[0]', 'Start Logging');
-- 				CALL sp_StartLogging('PITonPrem','[0]',QueryTag('ETL Logging','PITonPrem',NULL));
-- ------------------------------------------------------------------------
--
-- History:
--  1.0  2021-07-01 Andreas Kurz    Initial version

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

--sqlStmt = "SELECT SEQ_CNTL_ETL_LOGGING.NEXTVAL;"

SET sqlStmt  =  '''SELECT COALESCE(MAX(run_id_seq),0) + 1 AS next_run_id_seq FROM p_lew_mart_pit_onprem.t_cntl_etl_logging_run_seq_1 ''';
-- Retrieve next Seq RunID

BEGIN

EXECUTE IMMEDIATE (sqlBeginTransaction);

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'next_run_id_seq',  sqlStmt)
INTO res ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_STARTPROCESSING: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET iterator_res  =  iterator_res  + 1;
-- res.getColumnValue(1) = RUN_ID_SEQ

SET sqlStmt  =  '';
SET sqlStmt  =  'INSERT INTO p_lew_mart_pit_onprem.t_cntl_etl_logging_1 (run_id_seq, run_clustering_desc,application_name,query_tag,start_processig_flag) VALUES (' || JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]') || ',\''||strRunCluster||'\',\''||UPPER(PAPPLICATIONNAME)||'\',\''||PQUERYTAG||'\',1);';
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
SET sqlStmt  =  '';
SET sqlStmt  =  'INSERT INTO p_lew_mart_pit_onprem.t_cntl_etl_logging_run_seq_1 (run_id_seq, run_ts, run_day_id,run_clustering_desc,application_name) VALUES (' || JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]') || ', CAST(CURRENT_TIMESTAMP() AS DATETIME), CURRENT_DATE("Europe/Berlin"), \''||strRunCluster||'\',\''||UPPER(PAPPLICATIONNAME)||'\');';
BEGIN

EXECUTE IMMEDIATE (sqlStmt);

EXECUTE IMMEDIATE (sqlCommit);
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_STARTPROCESSING: [' || sqlStmt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;

-- return run seq

SET out_param  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');
SELECT out_param;
SET iterator_res  =  iterator_res  + 1;
RETURN;
END;