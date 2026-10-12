-- 31.08.2018 twie: SPEC0042079 In der Tabelle wird hinterlegt, ob der Anwender ein Update oder Delete des Datensatzes wünscht (update oder delete wird in Feld freigabe geschrieben)



--                            Nur wenn er ein Update wünscht, werden die geänderten Datenfelder auch aktualisiert, ansonsten bleiben sie unververändert und in freigabe wird das Wort delete geschrieben



--                            Die Backendverarbeitung erkennt am Feld freigabe, was mit den Datensätzen passieren soll und verarbeitet sie entsprechend.



--                            Wurden die fehlerhaften Felder korrigiert, landen die Datensätze nicht mehr in der RFI Tabelle. Sind sie weiterhin fehlerhaft, landen sie wieder hier und können vom Anwender erneut korrigiert werden.  



--eindeutiger Schlüssel der Tabelle



--enthält Info, was mit dem Datensatz passieren soll



--Datenfelder, die geändert werden können:



CREATE OR REPLACE PROCEDURE dbp_macro.sp_update_statusmeldung_rfi(IN STATUSID STRING, IN FREIGABE STRING, IN STATUS FLOAT64, IN LIFNR STRING, IN KREDITOR STRING, IN DOCCLASS STRING, IN CRUSER STRING)
BEGIN
DECLARE sql_commit STRING;
DECLARE sql_stmt STRING;
BEGIN
BEGIN TRANSACTION;
IF FREIGABE = 'update' THEN
    BEGIN
    --Wenn der Anwender update wählt, werden alle geänderten Felder abgespeichert
SET sql_stmt  =  '''UPDATE dbp_msi_data.statusmeldung_rfi SET  freigabe = "FREIGABE",  status = CAST("STATUS" AS INTEGER),  lifnr = "LIFNR",  kreditor = "KREDITOR",  docclass = "DOCCLASS",  cruser = "CRUSER" WHERE statusid = "STATUSID" ''';

    EXECUTE IMMEDIATE (sql_stmt);
    END;
ELSE
    BEGIN
    -- ansonsten (keine Änderung/bzw. delete) wird diese Info im Feld freigabe hinterlegt, aber die Datenfelder bleiben unverändert
SET sql_stmt  =  '''UPDATE dbp_msi_data.statusmeldung_rfi SET  freigabe = "FREIGABE" WHERE statusid = "STATUSID" ''';

    EXECUTE IMMEDIATE (sql_stmt);
    END;
END IF;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
END;