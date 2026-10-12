CREATE OR REPLACE PROCEDURE dbp_macro.sp_update_problemmeldung_rfi(IN PRMSGID STRING, IN FREIGABE STRING, IN KREDITOR_2 STRING, IN DOCCLASS STRING, IN CRUSER STRING, IN CAUSER STRING, IN WERKS STRING, IN PRCODE STRING, IN LIFNR STRING, IN MATNR STRING)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN
BEGIN TRANSACTION;
IF FREIGABE = 'update' THEN
    BEGIN
    SET sql_stmt  =  '''UPDATE dbp_msi_data.problemmeldung_rfi_2 SET  freigabe = "FREIGABE",  kreditor_2 = "KREDITOR_2",  docclass = "DOCCLASS",  cruser = "CRUSER",  causer = "CAUSER",  werks = "WERKS",  prcode = "PRCODE",  lifnr = "LIFNR",  matnr = "MATNR" WHERE prmsgid = "PRMSGID" ''';
    SET sql_stmt  =  REGEXP_REPLACE(sql_stmt, '\'undefined\'', 'NULL');

    EXECUTE IMMEDIATE (sql_stmt);
    SET sql_commit  =  'COMMIT TRANSACTION'    ;

    EXECUTE IMMEDIATE (sql_commit);
    END;
ELSE
    BEGIN
    SET sql_stmt  =  '''UPDATE dbp_msi_data.problemmeldung_rfi_2 SET  freigabe = "FREIGABE" WHERE prmsgid = "PRMSGID" ''';

    EXECUTE IMMEDIATE (sql_stmt);
    SET sql_commit  =  'COMMIT TRANSACTION'    ;

    EXECUTE IMMEDIATE (sql_commit);
    END;
END IF;

END;
END;
