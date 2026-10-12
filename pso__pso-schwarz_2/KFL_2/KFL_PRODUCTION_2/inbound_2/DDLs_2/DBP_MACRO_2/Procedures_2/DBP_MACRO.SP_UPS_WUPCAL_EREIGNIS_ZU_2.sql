CREATE OR REPLACE PROCEDURE dbp_macro.sp_ups_wupcal_ereignis_zu (MANDANT_ID FLOAT, WUP_ID FLOAT, DAT DATE, EREIGNIS_ID FLOAT, EREIGNISTYP_ID FLOAT, EREIGNIS_BEZ_LANG STRING)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	{

   /*
   ---------------------------------------------------------------
   -- 0. Deklarationen.
   ---------------------------------------------------------------
   */
   var var_new_ereignis_id;
   var var_mandant_id;
   var var_wup_id;
   var var_dat;
   var var_ereignis_id;
   var var_ereignistyp_id;
   var var_ereignis_bez_lang;
   var_mandant_id = MANDANT_ID;
   var_wup_id = WUP_ID;
   var_dat = DAT;
   var_ereignis_id = EREIGNIS_ID;
   var_ereignistyp_id = EREIGNISTYP_ID;
   var_ereignis_bez_lang = EREIGNIS_BEZ_LANG;
   //
   //---------------------------------------------------------------
   //-- 1. Ein neuer Freitext wird vergeben
   //---------------------------------------------------------------
   //
   //---------------------------------------------------
   // 1.0 Nächste freie ereignis_id
   //---------------------------------------------------
   // Nur bei noch nicht existierenden Ereignis_2-Freitext (Typ 101) muss eine_2 neue Ereinis-ID vergeben werden
   // Der TransactionService Übergabeparamter ist NULL, bei nicht vorhandenem Freitext
   // In der View mv_wupcal_ereignis_zu_cross_2 werden für jeden Tag_2 Einträge mit ereignis_id = -1 vorgehalten
   // Ein 'echtes' Ereignis_2 bekommt eine_2 ID > 0
   if (var_ereignis_id <= 0 && var_ereignistyp_id == 101) {
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      var sql_stmt = `SELECT
MAX(v01.ereignis_id) + 1
INTO ?
FROM dbp_data.ereignis_2 v01
WHERE v01.ereignistyp_id = ?
  AND v01.mandant_id = ?
  AND ( v01.mandant_id
       ,v01.ereignistyp_id
       ,v01.ereignis_id) NOT IN (SELECT
v02.mandant_id,
v02.ereignistyp_id,
v02.ereignis_id
FROM dbp_data.wupcal_ereignis_zu_2 v02
WHERE v02.dat = ?
  AND v02.mandant_id = ?
  AND v02.ereignistyp_id = ?
  AND v02.wup_id = ?
  AND v02.nb_id = 0
)

GROUP BY v01.mandant_id
,v01.ereignistyp_id`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [var_new_ereignis_id,EREIGNISTYP_ID,MANDANT_ID,DAT.toISOString(),MANDANT_ID,EREIGNISTYP_ID,WUP_ID]
      }).execute();
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      //---------------------------------------------------
      // 1.1 Befüllen der Lookup Tabelle dbx.ereignis_2
      //---------------------------------------------------
      var sql_stmt = `INSERT INTO dbp_data.ereignis_2 (
 ereignis_id
,ereignistyp_id
,mandant_id
,default_offen
,sap_ereignis_id)
SELECT
t1.ereignis_id,
t1.ereignistyp_id,
t1.mandant_id,
t2.offen,
t1.sap_ereignis_id
FROM
(SELECT
? AS ereignis_id,
?  AS ereignistyp_id,
? AS mandant_id,
NULL AS sap_ereignis_id
) t1_2

CROSS JOIN
(SELECT
v01.offen
FROM dbp_data.wupcal_2 v01
WHERE v01.mandant_id = ?
  AND v01.wup_id = ?
  AND v01.dat = ?
) t2`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [EREIGNIS_ID,EREIGNISTYP_ID,MANDANT_ID,MANDANT_ID,WUP_ID,DAT.toISOString()]
      }).execute();
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      //---------------------------------------------------
      // 1.2 Befüllen der Sprachtabelle Tabelle dbx.ereignis_spr_zu_2
      //---------------------------------------------------
      var sql_stmt = `INSERT INTO dbp_data.ereignis_spr_zu_2 (
         ereignis_id
,ereignistyp_id
,spr_id
,mandant_id
,ereignis_bez_lang
,ereignis_bez_mittel
,ereignis_bez_kurz)

SELECT
t1.ereignis_id,
t1.ereignistyp_id,
t2.spr_id,
t1.mandant_id,
t1.ereignis_bez_lang,
t1.ereignis_bez_mittel,
t1.ereignis_bez_kurz
FROM
(SELECT
? AS ereignis_id,
?  AS ereignistyp_id,
? AS mandant_id,
? AS ereignis_bez_lang,
? AS ereignis_bez_mittel,
? AS ereignis_bez_kurz
) t1_2

CROSS JOIN
(SELECT
v01.spr_id
FROM dbp_data.mandant_spr_zu_2 v01
WHERE v01.mandant_id = ?
) t2`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [EREIGNIS_ID,EREIGNISTYP_ID,MANDANT_ID,var_ereignis_bez_lang,var_ereignis_bez_lang,var_ereignis_bez_lang,var_mandant_id]
      }).execute();
      //Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
      //---------------------------------------------------
      // 1.3 Befüllen der Zuordnungs Tabelle dbx.wupcal_ereignis_zu_2
      //---------------------------------------------------
      var sql_stmt = `INSERT INTO dbp_data.wupcal_ereignis_zu_2 (
         dat
,wup_id
,nb_id
,mandant_id
,ereignistyp_id
,ereignis_id
,offen)

SELECT
t1.dat,
t1.wup_id,
t1.nb_id,
t1.mandant_id,
t1.ereignistyp_id,
t1.ereignis_id,
t2.offen
FROM
(SELECT
? AS dat,
? AS wup_id,
0 AS nb_id,
? AS mandant_id,
? AS ereignistyp_id,
? AS ereignis_id
) t1_2

CROSS JOIN
(SELECT
v01.offen
FROM dbp_data.wupcal_2 v01
WHERE v01.mandant_id = ?
  AND v01.wup_id = ?
  AND v01.dat = ?
) t2`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [DAT.toISOString(),WUP_ID,MANDANT_ID,EREIGNISTYP_ID,EREIGNIS_ID,var_mandant_id,var_wup_id,var_dat]
      }).execute();
   }
   //
   //---------------------------------------------------------------
   //-- 2. Freitext wird aktualisiert
   //---------------------------------------------------------------
   //
   // Update von Ereignis_2-Freitext (Typ 101)
   // In der View mv_wupcal_ereignis_zu_cross_2 werden für jeden Tag_2 Einträge mit ereignis_id = -1 vorgehalten
   // Ein 'echtes' Ereignis_2 bekommt eine_2 ID > 0
   if (var_ereignis_id > 0 && var_ereignistyp_id == 101 && var_ereignis_bez_lang != null) {
      var sql_stmt = `UPDATE dbp_data.ereignis_spr_zu_2 SET ereignis_bez_lang = ?
,ereignis_bez_mittel = ?
,ereignis_bez_kurz = ?
WHERE mandant_id = ?
  AND ereignistyp_id = ?
  AND ereignis_id = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [EREIGNIS_BEZ_LANG,EREIGNIS_BEZ_LANG,EREIGNIS_BEZ_LANG,MANDANT_ID,EREIGNISTYP_ID,EREIGNIS_ID]
      }).execute();
   }
   //
   //---------------------------------------------------------------
   //-- 3. Freitext wird gelöscht
   //---------------------------------------------------------------
   //
   // Löschen von Ereignis_2-Freitext (Typ 101) Einträgen
   // Im TransactionService Bericht gibt es kein 'Löschen-Knopf'. 
   // Ein Eintrag gilt als gelöscht, wenn eine_2 ID vorhanden ist (es gibt einen Freitext) und das Feld Freitext leer ist
   // In der View mv_wupcal_ereignis_zu_cross_2 werden für jeden Tag_2 Einträge mit ereignis_id = -1 vorgehalten
   // Ein 'echtes' Ereignis_2 bekommt eine_2 ID > 0
   if (var_ereignis_id > 0 && var_ereignistyp_id == 101 && var_ereignis_bez_lang == null) {
      var sql_stmt = `DELETE FROM dbp_data.ereignis_spr_zu_2
WHERE mandant_id = ?
  AND ereignistyp_id = ?
  AND ereignis_id = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [MANDANT_ID,EREIGNISTYP_ID,EREIGNIS_ID]
      }).execute();
      var sql_stmt = `DELETE FROM dbp_data.ereignis_2
WHERE mandant_id = ?
  AND ereignistyp_id = ?
  AND ereignis_id = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [MANDANT_ID,EREIGNISTYP_ID,EREIGNIS_ID]
      }).execute();
      var sql_stmt = `DELETE FROM dbp_data.wupcal_ereignis_zu_2
WHERE mandant_id = ?
  AND ereignistyp_id = ?
  AND ereignis_id = ?
  AND dat = ?
  AND wup_id = ?`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [MANDANT_ID,EREIGNISTYP_ID,EREIGNIS_ID,DAT.toISOString(),WUP_ID]
      }).execute();
   }
}
 
$$;

