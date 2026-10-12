CREATE OR REPLACE PROCEDURE dbp_macro.m_del_user_rolle_ek_int_zu(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN ROLLE_ID FLOAT64, IN ZEK_ID STRING, IN WBL_ID FLOAT64, IN GF_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  = '''DELETE FROM dbp_security.user_rolle_ek_int_zu_1 WHERE mandant_id = ''' || CAST(MANDANT_ID AS STRING) || ''' AND user_id = ' ''' || USER_ID || ''' ' AND rolle_id = ''' || CAST(ROLLE_ID AS STRING) || ''' AND (zek_id IS NULL OR zek_id = "''' || ZEK_ID || '''") AND (wbl_id     IS NULL OR wbl_id = ''' || CAST(WBL_ID AS STRING) || ''') AND (gf_id IS NULL OR gf_id = ''' || CAST(GF_ID AS STRING) || ''') '''; 

SET sql_stmt = REPLACE(sql_stmt, 'undefined', 'NULL'); 


EXECUTE IMMEDIATE (sql_stmt);
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
