CREATE OR REPLACE PROCEDURE dbp_macro.m_del_artikel_zuordnung(IN S_MANDANT_ID FLOAT64, IN S_EAN_ID FLOAT64, IN S_ART_ID FLOAT64, IN S_WG_ID FLOAT64, IN S_WUG_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
SET sql_stmt  =  '''DELETE FROM dbp_data.ts_artikel_zuordnung_1 WHERE 
                    mandant_id = @S_MANDANT_ID 
                    AND ean_id = @S_EAN_ID 
                    AND art_id = @S_ART_ID 
                    AND wg_id =  @S_WG_ID 
                    AND wug_id = @S_WUG_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING S_MANDANT_ID AS S_MANDANT_ID,  S_EAN_ID AS S_EAN_ID,  S_ART_ID AS S_ART_ID,  S_WG_ID AS S_WG_ID,  S_WUG_ID AS S_WUG_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;