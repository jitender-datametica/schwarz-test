CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_nachlieferungprocess(IN REQUEST_ID FLOAT64, IN ACTIVE_FG FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''UPDATE dbp_msi_data.ts_nachlieferung SET  active_fg =cast(@ACTIVE_FG as INT64) -- // active_fg  
WHERE nachlieferung_request_id = @REQUEST_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING REQUEST_ID AS REQUEST_ID,  ACTIVE_FG AS ACTIVE_FG;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
