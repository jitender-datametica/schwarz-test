CREATE OR REPLACE PROCEDURE dbp_macro.m_del_sortiment_user_wg_zu(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN WG_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
--Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
SET sql_stmt  =  '''DELETE FROM dbp_security.sortiment_user_wg_zu_2 WHERE user_id = UPPER(LEFT(user_id, 2)) || LOWER(SUBSTR(@USER_ID_1, 3, LENGTH(@USER_ID_1_2) - 2)) AND mandant_id =  @MANDANT_ID AND wg_id =@WG_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  USER_ID AS USER_ID,  USER_ID AS USER_ID_1,  USER_ID AS USER_ID_1_2,  WG_ID AS WG_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
