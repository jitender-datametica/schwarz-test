CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_wupcal_ereignis_zu (DAT DATE, WUP_ID FLOAT, NB_ID FLOAT, MANDANT_ID FLOAT, EREIGNISTYP_ID FLOAT, EREIGNIS_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	// Bevor der gewählte Eintrag gespeichert wird, den existieren Satz entfernen
var sql_stmt = `DELETE FROM dbp_data.wupcal_ereignis_zu_1
WHERE dat = ?
AND wup_id = ?
AND nb_id = ?
AND mandant_id = ?
AND ereignistyp_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [DAT.toISOString(),WUP_ID,NB_ID,MANDANT_ID,EREIGNISTYP_ID]
}).execute();
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
// Der neue Kommentar wird eingefügt
var sql_stmt = `INSERT INTO dbp_data.wupcal_ereignis_zu_1 (DAT, WUP_ID, NB_ID, MANDANT_ID, EREIGNISTYP_ID, EREIGNIS_ID, OFFEN)
SELECT
?,
?,
?,
?,
? AS ereignistyp_id,
? AS ereignis_id,
offen
FROM dbp_data.wupcal_1 v01
WHERE dat = ?
AND wup_id = ?
AND nb_id = ?
AND mandant_id = ?
AND 100 = ?
AND 108 <> ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [DAT.toISOString(),WUP_ID,NB_ID,MANDANT_ID,EREIGNISTYP_ID,EREIGNIS_ID,DAT.toISOString(),WUP_ID,NB_ID,MANDANT_ID,EREIGNISTYP_ID,EREIGNIS_ID]
}).execute();
// Ereignis_1 zum löschen eines Umsatz Kommentar, wird über Auswahlliste in Bericht bereitgestellt
// Nur wenn 'Lösch Kommentar' ausgewählt, wird Eintrag für den Markt/Tag_1 komplett gelöscht, daher hier die Verriegelung
var sql_stmt = `DELETE FROM dbp_data.wupcal_ereignis_zu_1
WHERE dat = ?
AND wup_id = ?
AND nb_id = ?
AND mandant_id = ?
AND ereignistyp_id = ?
AND 100 = ?
AND 108 = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [DAT.toISOString(),WUP_ID,NB_ID,MANDANT_ID,EREIGNISTYP_ID,EREIGNISTYP_ID,EREIGNIS_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;

