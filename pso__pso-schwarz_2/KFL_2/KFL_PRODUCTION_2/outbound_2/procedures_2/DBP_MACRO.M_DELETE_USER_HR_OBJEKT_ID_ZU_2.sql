CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_user_hr_objekt_id_zu(IN USER_ID STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''DELETE FROM dbp_security.user_hr_objekt_id_zu_2 WHERE user_id = @USER_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;

