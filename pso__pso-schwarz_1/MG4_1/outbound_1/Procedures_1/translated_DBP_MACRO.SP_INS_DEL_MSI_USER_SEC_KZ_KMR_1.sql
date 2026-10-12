

CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.sp_ins_del_msi_user_sec_kz_kmr(IN P_SEC_KZ STRING, IN P_USER_ID STRING, IN P_SEC_FG FLOAT64)
BEGIN
DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;


BEGIN TRANSACTION;

IF P_SEC_FG = 1 THEN
    BEGIN


    set sql_stmt = '''MERGE INTO kfl_production_dbp_msi_data.ts_kmr_user_sec_kz_zu_1 AS target USING (
  SELECT
      ? AS sec,
      ? AS ldap
) AS tab
ON tab.ldap = target.user_id 
 AND tab.sec = target.sec_kz
   WHEN NOT MATCHED BY TARGET THEN
    INSERT
    VALUES (tab.ldap, tab.sec)''';


    EXECUTE IMMEDIATE (sql_stmt) USING P_SEC_KZ ,  P_USER_ID ;

    END;
ELSE
    

    IF P_SEC_FG = 0 THEN
        BEGIN

        
        set sql_stmt = '''Delete from kfl_production_dbp_msi_data.ts_kmr_user_sec_kz_zu_1
                     where sec_kz =?
                     and user_id =? ''';

        EXECUTE IMMEDIATE (sql_stmt) USING P_SEC_KZ ,  P_USER_ID ;

        END;
    END IF;

    
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
