CREATE OR REPLACE PROCEDURE DBP_MACRO.sp_update_statusmeldung_rfi (
-- 31.08.2018 twie: SPEC0042079 In der Tabelle wird hinterlegt, ob der Anwender ein Update oder Delete des Datensatzes wünscht (update oder delete wird in Feld freigabe geschrieben)
--                            Nur wenn er ein Update wünscht, werden die geänderten Datenfelder auch aktualisiert, ansonsten bleiben sie unververändert und in freigabe wird das Wort delete geschrieben
--                            Die Backendverarbeitung erkennt am Feld freigabe, was mit den Datensätzen passieren soll und verarbeitet sie entsprechend.
--                            Wurden die fehlerhaften Felder korrigiert, landen die Datensätze nicht mehr in der RFI Tabelle. Sind sie weiterhin fehlerhaft, landen sie wieder hier und können vom Anwender erneut korrigiert werden.  
STATUSID STRING, --eindeutiger Schlüssel der Tabelle
FREIGABE STRING, --enthält Info, was mit dem Datensatz passieren soll
--Datenfelder, die geändert werden können:
STATUS_2 FLOAT, LIFNR STRING, KREDITOR_2 STRING, DOCCLASS STRING, CRUSER STRING)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{
   if (FREIGABE == `update`) {
      //Wenn der Anwender update wählt, werden alle geänderten Felder abgespeichert
      var sql_stmt = `UPDATE DBP_MSI_DATA.statusmeldung_rfi_2 
                     SET
                        freigabe    = '` + FREIGABE + `'
                        ,status_2     = '` + STATUS_2 + `'
                        ,lifnr      = '` + LIFNR + `'
                        ,kreditor_2   = '` + KREDITOR_2 + `'
                        ,docclass   = '` + DOCCLASS + `'
                        ,cruser     = '` + CRUSER + `'
                     WHERE statusid = '` + STATUSID + `'`;
      snowflake.createStatement({
         sqlText : sql_stmt
      }).execute();
         
   } else {
      // ansonsten (keine Änderung/bzw. delete) wird diese Info im Feld freigabe hinterlegt, aber die Datenfelder bleiben unverändert
      var sql_stmt = `UPDATE DBP_MSI_DATA.statusmeldung_rfi_2 
                     SET freigabe   = '` + FREIGABE + `'
                     WHERE statusid = '` + STATUSID + `'`;
      snowflake.createStatement({
         sqlText : sql_stmt
      }).execute();
   }
   var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

}
 
$$;