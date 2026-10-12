CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_user_ek_anzeige_zu(IN USER_ID STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''DELETE FROM dbp_security.user_ek_anzeige_zu WHERE user_id = @USER_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
