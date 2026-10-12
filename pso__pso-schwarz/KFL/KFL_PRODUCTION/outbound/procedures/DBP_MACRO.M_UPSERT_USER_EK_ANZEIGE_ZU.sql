CREATE OR REPLACE PROCEDURE dbp_macro.m_upsert_user_ek_anzeige_zu(IN USER_ID STRING, IN EK_ANZEIGE_FG FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_security.user_ek_anzeige_zu AS TARGET 
                    USING (SELECT @USER_ID AS user_id,   @EK_ANZEIGE_FG AS ek_anzeige_fg) AS source 
                    ON TARGET.user_id = source.user_id 
                    WHEN MATCHED THEN UPDATE 
                    SET  ek_anzeige_fg = CAST(source.ek_anzeige_fg AS INTEGER) 
                    WHEN NOT MATCHED THEN INSERT (user_id, ek_anzeige_fg) 
                    VALUES(source.user_id, CAST(source.ek_anzeige_fg AS INTEGER)) ''';

EXECUTE IMMEDIATE (sql_stmt) USING USER_ID AS USER_ID,  EK_ANZEIGE_FG AS EK_ANZEIGE_FG;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;