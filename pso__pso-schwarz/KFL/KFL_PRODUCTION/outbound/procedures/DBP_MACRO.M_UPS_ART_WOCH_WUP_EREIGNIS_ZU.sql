CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_art_woch_wup_ereignis_zu(IN MANDANT_ID FLOAT64, IN ART_ID FLOAT64, IN KJWO FLOAT64, IN WUP_ID FLOAT64, IN NB_ID FLOAT64, IN EREIGNIS_ID FLOAT64, IN EREIGNISTYP_ID FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;

BEGIN TRANSACTION;
-- Bevor der gewählte Eintrag gespeichert wird, den existieren Satz entfernen
SET sql_stmt  =  '''DELETE FROM dbp_data.art_woche_wup_ereignis_zu WHERE kjwo = @KJWO AND wup_id = @WUP_ID AND nb_id = @NB_ID AND mandant_id = @MANDANT_ID AND art_id = @ART_ID  AND ereignistyp_id = @EREIGNISTYP_ID ''';

EXECUTE IMMEDIATE (sql_stmt) USING KJWO AS KJWO,  WUP_ID AS WUP_ID,  NB_ID AS NB_ID,  MANDANT_ID AS MANDANT_ID,  ART_ID AS ART_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID;

--Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
-- Der neue Kommentar wird eingefügt
SET sql_stmt  =  '''INSERT INTO dbp_data.art_woche_wup_ereignis_zu (mandant_id, art_id, kjwo, wup_id, nb_id, ereignis_id,  ereignistyp_id) (SELECT CAST(@MANDANT_ID AS INTEGER) AS mandant_id,   CAST(@ART_ID AS INTEGER) AS art_id,   CAST(@KJWO AS INTEGER) AS kjwo,   CAST(@WUP_ID AS INTEGER) AS wup_id,   CAST(@NB_ID AS INTEGER) AS nb_id,   CAST(@EREIGNIS_ID AS INTEGER) AS ereignis_id,   CAST(@EREIGNISTYP_ID AS INTEGER) AS ereignistyp_id  FROM (SELECT 0 AS zero) AS t  WHERE 102 = @EREIGNISTYP_ID_1   AND 999 <> @EREIGNIS_ID_1) ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  ART_ID AS ART_ID,  KJWO AS KJWO,  WUP_ID AS WUP_ID,  NB_ID AS NB_ID,  EREIGNIS_ID AS EREIGNIS_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID_1,  EREIGNIS_ID AS EREIGNIS_ID_1;

-- Ereignis zum löschen eines Umsatz Kommentar, wird über Auswahlliste in Bericht bereitgestellt
-- Nur wenn 'Lösch Kommentar' ausgewählt, wird Eintrag für den Markt/Tag komplett gelöscht, daher hier die Verriegelung
SET sql_stmt  =  '''DELETE FROM dbp_data.art_woche_wup_ereignis_zu WHERE 102 = @EREIGNISTYP_ID_1 AND 999 = @EREIGNIS_ID AND mandant_id = @MANDANT_ID AND art_id = @ART_ID AND kjwo = @KJWO AND wup_id = @WUP_ID AND nb_id = @NB_ID AND ereignistyp_id = @EREIGNISTYP_ID_1 ''';

EXECUTE IMMEDIATE (sql_stmt) USING MANDANT_ID AS MANDANT_ID,  ART_ID AS ART_ID,  KJWO AS KJWO,  WUP_ID AS WUP_ID,  NB_ID AS NB_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID,  EREIGNISTYP_ID AS EREIGNISTYP_ID_1,  EREIGNIS_ID AS EREIGNIS_ID;

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;