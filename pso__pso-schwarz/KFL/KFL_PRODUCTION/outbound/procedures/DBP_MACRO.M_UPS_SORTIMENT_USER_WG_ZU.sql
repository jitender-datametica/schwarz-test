CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_sortiment_user_wg_zu(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN WG_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''MERGE INTO dbp_security.sortiment_user_wg_zu AS TARGET 
                    USING (SELECT @MANDANT_ID AS mandant_id, UPPER(LEFT(@USER_ID, 2)) || LOWER(SUBSTR(@USER_ID_1, 3, 
                    LENGTH(@USER_ID_1_2) - 2)) AS user_id,   
                    @WG_ID AS wg_id)             AS source 
                    ON TARGET.mandant_id = source.mandant_id AND TARGET.user_id = source.user_id AND TARGET.wg_id = source.wg_id 
                    WHEN MATCHED THEN UPDATE 
                    SET  mandant_id = CAST(@MANDANT_ID_1 AS INTEGER) 
                    WHEN NOT MATCHED THEN INSERT (mandant_id, user_id, wg_id) 
                    VALUES(CAST(@MANDANT_ID_1_2 AS INTEGER), UPPER(LEFT(@USER_ID_1_2_3, 2)) || LOWER(SUBSTR(@USER_ID_1_2_3_4, 3, LENGTH              (@USER_ID_1_2_3_4_5) - 2)), CAST(@WG_ID_1 AS INTEGER)) ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  USER_ID AS USER_ID,  USER_ID AS USER_ID_1,  USER_ID AS USER_ID_1_2,  WG_ID AS WG_ID,  MANDANT_ID AS MANDANT_ID_1,  MANDANT_ID AS MANDANT_ID_1_2,  USER_ID AS USER_ID_1_2_3,  USER_ID AS USER_ID_1_2_3_4,  USER_ID AS USER_ID_1_2_3_4_5,  WG_ID AS WG_ID_1;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;