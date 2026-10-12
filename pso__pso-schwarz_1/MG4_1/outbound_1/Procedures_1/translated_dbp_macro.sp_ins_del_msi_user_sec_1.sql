CREATE OR REPLACE PROCEDURE kfl_production_dbp_macro.sp_ins_del_msi_user_sec(IN MANDANT_ID FLOAT64, IN USER_ID STRING, IN SEC_FG FLOAT64, IN MSI_PRODUKT_BEZ STRING)
BEGIN
DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;


BEGIN TRANSACTION;
IF SEC_FG = 1 THEN
    BEGIN
    
    SET sql_stmt  =  '''MERGE INTO kfl_production_dbp_security.user_mandant_msiprodukt_zu_1 as target using (
    select
      '?' as msi_produkt,
      ? as mandant_1,
      '?' as ldap
) as tab
on tab.mandant_1 = target.mandant_id
 and tab.ldap = target.user_id
 and tab.msi_produkt = target.msi_produkt_bez
   when not matched by target then
    insert (mandant_id, user_id, msi_produkt_bez)
    values (tab.mandant_1, tab.ldap, tab.msi_produkt)''';

    EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID ,  USER_ID ,  MSI_PRODUKT_BEZ ;

    END;
ELSE
    BEGIN

    IF SEC_FG = 0 THEN
        BEGIN
        
      
        set sql_stmt = '''DELETE FROM kfl_production_dbp_security.user_mandant_msiprodukt_zu_1
                     WHERE mandant_id =?
                     AND user_id =?
                     AND msi_produkt_bez =?''';

        EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID ,  USER_ID ,  MSI_PRODUKT_BEZ ;

        END;
    END IF;

    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
