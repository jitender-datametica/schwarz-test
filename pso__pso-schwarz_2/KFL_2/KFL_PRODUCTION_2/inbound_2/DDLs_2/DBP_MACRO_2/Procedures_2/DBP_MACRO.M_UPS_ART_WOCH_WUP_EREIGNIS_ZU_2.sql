CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_art_woch_wup_ereignis_zu (MANDANT_ID FLOAT, ART_ID FLOAT, KJWO FLOAT, WUP_ID FLOAT, NB_ID FLOAT, EREIGNIS_ID FLOAT, EREIGNISTYP_ID FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	// Bevor der gewählte Eintrag gespeichert wird, den existieren Satz entfernen
var sql_stmt = `DELETE FROM dbp_data.art_woche_wup_ereignis_zu_2
WHERE kjwo = ?
AND wup_id = ?
AND nb_id = ?
AND mandant_id = ?
AND art_id = ?
AND ereignistyp_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [KJWO,WUP_ID,NB_ID,MANDANT_ID,ART_ID,EREIGNISTYP_ID]
}).execute();
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
// Der neue Kommentar wird eingefügt
var sql_stmt = `INSERT INTO dbp_data.art_woche_wup_ereignis_zu_2 (MANDANT_ID, ART_ID, KJWO, WUP_ID, NB_ID, EREIGNIS_ID, EREIGNISTYP_ID)
SELECT
? AS mandant_id,
? AS art_id,
? AS kjwo,
? AS wup_id,
? AS nb_id,
? AS ereignis_id,
? AS ereignistyp_id
WHERE 102 = ?
AND 999 <> ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,ART_ID,KJWO,WUP_ID,NB_ID,EREIGNIS_ID,EREIGNISTYP_ID,EREIGNISTYP_ID,EREIGNIS_ID]
}).execute();
// Ereignis_2 zum löschen eines Umsatz Kommentar, wird über Auswahlliste in Bericht bereitgestellt
// Nur wenn 'Lösch Kommentar' ausgewählt, wird Eintrag für den Markt/Tag_2 komplett gelöscht, daher hier die Verriegelung
var sql_stmt = `DELETE FROM dbp_data.art_woche_wup_ereignis_zu_2
WHERE mandant_id = ?
AND art_id = ?
AND kjwo = ?
AND wup_id = ?
AND nb_id = ?
AND ereignistyp_id = ?
AND 102 = ?
AND 999 = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,ART_ID,KJWO,WUP_ID,NB_ID,EREIGNISTYP_ID,EREIGNISTYP_ID,EREIGNIS_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;

