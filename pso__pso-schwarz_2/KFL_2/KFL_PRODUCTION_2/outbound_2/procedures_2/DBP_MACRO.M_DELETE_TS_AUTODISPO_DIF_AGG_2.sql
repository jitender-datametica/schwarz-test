CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_ts_autodispo_dif_agg(IN DATEINAME STRING, IN DELETE_FG FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;

SET sql_stmt  =  '''DELETE FROM dbp_data.ts_autodispo_dif_2 WHERE 1 = @DELETE_FG AND dateiname = @DATEINAME ''';

SET sql_stmt  =  REGEXP_REPLACE(sql_stmt, 'undefined', 'NULL');

EXECUTE IMMEDIATE (sql_stmt) USING DATEINAME AS DATEINAME,  DELETE_FG AS DELETE_FG;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;