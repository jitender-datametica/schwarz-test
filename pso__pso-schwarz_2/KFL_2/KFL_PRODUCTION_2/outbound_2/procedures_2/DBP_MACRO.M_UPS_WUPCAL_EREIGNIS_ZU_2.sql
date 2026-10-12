CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wupcal_ereignis_zu(IN DAT DATE, IN WUP_ID FLOAT64, IN NB_ID FLOAT64, IN MANDANT_ID FLOAT64, IN EREIGNISTYP_ID FLOAT64, IN EREIGNIS_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
-- Bevor der gewählte Eintrag gespeichert wird, den existieren Satz entfernen
SET sql_stmt  =  '''DELETE FROM dbp_data.wupcal_ereignis_zu_2 WHERE dat= @DAT  AND wup_id= @WUP_ID  AND nb_id= @NB_ID  AND mandant_id= @MANDANT_ID  AND ereignistyp_id = @EREIGNISTYP_ID  ''';

EXECUTE IMMEDIATE (sql_stmt) USING FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT) AS DAT,  WUP_ID AS WUP_ID,  NB_ID AS NB_ID,  MANDANT_ID AS MANDANT_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID;

--Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
-- Der neue Kommentar wird eingefügt
SET sql_stmt  =  '''INSERT INTO dbp_data.wupcal_ereignis_zu_2 (dat, wup_id, nb_id, mandant_id, ereignistyp_id, ereignis_id,  offen) (SELECT dat,   wup_id,   nb_id,   mandant_id,   CAST(@EREIGNISTYP_ID AS INTEGER) AS ereignistyp_id,   CAST(@EREIGNIS_ID AS INTEGER) AS ereignis_id,   offen  FROM dbp_data.wupcal_2 AS V01  WHERE dat = @DAT_1   AND wup_id = @WUP_ID_1   AND nb_id = @NB_ID_1   AND mandant_id = @MANDANT_ID_1   AND 100 = @EREIGNISTYP_ID_1   AND 108 <> @EREIGNIS_ID_1) ''';

EXECUTE IMMEDIATE (sql_stmt) USING FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT) AS DAT,  WUP_ID AS WUP_ID,  NB_ID AS NB_ID,  MANDANT_ID AS MANDANT_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNIS_ID AS EREIGNIS_ID,  FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT) AS DAT_1,  WUP_ID AS WUP_ID_1,  NB_ID AS NB_ID_1,  MANDANT_ID AS MANDANT_ID_1,  EREIGNISTYP_ID AS EREIGNISTYP_ID_1,  EREIGNIS_ID AS EREIGNIS_ID_1;

-- Ereignis_2 zum löschen eines Umsatz Kommentar, wird über Auswahlliste in Bericht bereitgestellt
-- Nur wenn 'Lösch Kommentar' ausgewählt, wird Eintrag für den Markt/Tag_2 komplett gelöscht, daher hier die Verriegelung
SET sql_stmt  =  '''DELETE FROM dbp_data.wupcal_ereignis_zu_2 WHERE 100 = @EREIGNISTYP_ID AND 108 = @EREIGNISTYP_ID_1 AND dat= @DAT  AND wup_id= @WUP_ID  AND nb_id= @NB_ID  AND   mandant_id= @MANDANT_ID  AND ereignistyp_id=@EREIGNIS_ID   ''';

EXECUTE IMMEDIATE (sql_stmt) USING FORMAT_TIMESTAMP('%FT%H:%M:%S', DAT) AS DAT,  WUP_ID AS WUP_ID,  NB_ID AS NB_ID,  MANDANT_ID AS MANDANT_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID_1,  EREIGNIS_ID AS EREIGNIS_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
