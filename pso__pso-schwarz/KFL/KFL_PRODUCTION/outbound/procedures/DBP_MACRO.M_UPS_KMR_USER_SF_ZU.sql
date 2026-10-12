CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_kmr_user_sf_zu(IN SF_ID FLOAT64, IN USER_ID STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_security.ts_kmr_user_security_filter_zu AS A USING (SELECT CAST(@SF_ID AS INT64) AS sf_id,   @USER_ID AS user_id) AS b ON A.user_id = b.user_id WHEN MATCHED THEN UPDATE SET  sf_id = CAST(b.sf_id AS INT64) WHEN NOT MATCHED THEN INSERT (user_id, sf_id) VALUES(UPPER(SUBSTR(b.user_id, 1, 2)) || LOWER(SUBSTR(b.user_id, 3, LENGTH(b.user_id) - 2)), CAST(b.sf_id AS INT64)) ''';

EXECUTE IMMEDIATE (sql_stmt) USING SF_ID AS SF_ID,  USER_ID AS USER_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;

