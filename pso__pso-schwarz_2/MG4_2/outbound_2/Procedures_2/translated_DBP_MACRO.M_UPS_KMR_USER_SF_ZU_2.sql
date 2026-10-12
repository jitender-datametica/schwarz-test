CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.m_ups_kmr_user_sf_zu(IN SF_ID FLOAT64, IN USER_ID STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
SET sql_stmt  =  '''MERGE INTO kfl_production_dbp_security.ts_kmr_user_security_filter_zu_2 AS a USING (SELECT @SF_ID AS sf_id,   @USER_ID AS user_id) AS b ON a.user_id = b.user_id WHEN MATCHED THEN UPDATE SET  sf_id = CAST(b.sf_id AS INTEGER) WHEN NOT MATCHED THEN INSERT (user_id, sf_id) VALUES(UPPER(SUBSTR(b.user_id, 1, 2)) || LOWER(SUBSTR(b.user_id, 3, LENGTH(b       .user_id) - 2)), CAST(b.sf_id AS INTEGER));''';

EXECUTE IMMEDIATE (sql_stmt) USING SF_ID AS SF_ID,  USER_ID AS USER_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
