CREATE OR REPLACE PROCEDURE KFL_PRODUCTION_DBP_MACRO.M_DEL_USER_ROLLE_EK_INT_ZU(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN ROLLE_ID FLOAT64, IN ZEK_ID STRING, IN WBL_ID FLOAT64, IN GF_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;

SET sql_stmt  =  '''DELETE FROM  KFL_PRODUCTION_DBP_SECURITY.USER_ROLLE_EK_INT_ZU_2
	WHERE mandant_id = ''' || CAST(MANDANT_ID AS STRING) || '''
	AND user_id = \'\' || USER_ID || \'\'
	AND rolle_id = ''' || CAST(ROLLE_ID AS STRING) || '''
	AND (zek_id = \'\' || ZEK_ID || \'\' or zek_id is null)
	AND (wbl_id = ''' || CAST(WBL_ID AS STRING) || ''' or wbl_id is null)
	AND (gf_id = ''' || CAST(GF_ID AS STRING) || ' or gf_id is null)';
SET sql_stmt  =  REGEXP_REPLACE(sql_stmt, 'undefinedg', 'NULL');

EXECUTE IMMEDIATE (sql_stmt);
SET sql_commit  =  'COMMIT TRANSACTION'
;

EXECUTE IMMEDIATE (sql_commit);
END;
