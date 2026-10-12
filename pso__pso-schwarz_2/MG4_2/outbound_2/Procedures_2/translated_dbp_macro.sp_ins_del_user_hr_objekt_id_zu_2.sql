CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.sp_ins_del_user_hr_objekt_id_zu(IN MANDANT_ID FLOAT64, IN HR_OBJEKT_EBENE1_ID FLOAT64, IN USER_ID STRING, IN PFLEGE_FG FLOAT64)
BEGIN
DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;

BEGIN TRANSACTION;
IF PFLEGE_FG = 1 THEN
    BEGIN

   SET sql_stmt = """ MERGE `kfl_production_dbp_security.user_hr_objekt_id_zu_2` AS t1_2
USING (
  SELECT
    """ || mandant_id || """          AS mandant_id,
    """ || hr_objekt_ebene1_id || """ AS hr_objekt_ebene1_id,
    '""" || user_id || """'           AS user_id
) AS src
ON  t1.mandant_id = src.mandant_id
AND t1.user_id = src.user_id
AND t1.hr_objekt_ebene1_id = src.hr_objekt_ebene1_id

WHEN NOT MATCHED THEN
  INSERT (mandant_id, hr_objekt_ebene1_id, user_id)
  VALUES (src.mandant_id, src.hr_objekt_ebene1_id, src.user_id)""";

    EXECUTE IMMEDIATE (sql_stmt);
    END;
ELSE
    BEGIN

    IF PFLEGE_FG = 0 THEN
        BEGIN
 

SET sql_stmt  =  '''DELETE FROM kfl_production_dbp_security.user_hr_objekt_id_zu_2 WHERE mandant_id = ''' ||MANDANT_ID || ''' AND user_id = "''' ||MANDANT_ID || '''" AND hr_objekt_ebene1_id = ''' ||MANDANT_ID || ''';''';

        EXECUTE IMMEDIATE (sql_stmt);
        END;
    END IF;

    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_stmt);
END;
