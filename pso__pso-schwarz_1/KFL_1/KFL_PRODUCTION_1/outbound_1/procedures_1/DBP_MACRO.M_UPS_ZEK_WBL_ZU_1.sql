CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_zek_wbl_zu(IN MANDANT_ID FLOAT64, IN ZEK_ID FLOAT64, IN WBL_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;

SET sql_stmt  =  '''MERGE INTO dbp_security.zek_wbl_zu_1 AS TARGET 
                    USING (SELECT @MANDANT_ID AS mandant_id,   @ZEK_ID AS zek_id,   @WBL_ID AS wbl_id) AS source 
                    ON TARGET.mandant_id = source.mandant_id AND CAST(TARGET.zek_id AS FLOAT64) = source.zek_id 
                    WHEN MATCHED THEN UPDATE 
                    SET  wbl_id = CAST(source.wbl_id AS INTEGER) 
                    WHEN NOT MATCHED THEN INSERT (mandant_id, zek_id, wbl_id) 
                    VALUES(CAST(source.mandant_id AS INTEGER), CAST(source.zek_id AS STRING)  , CAST(source.wbl_id AS INTEGER)) ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  ZEK_ID AS ZEK_ID,  WBL_ID AS WBL_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;