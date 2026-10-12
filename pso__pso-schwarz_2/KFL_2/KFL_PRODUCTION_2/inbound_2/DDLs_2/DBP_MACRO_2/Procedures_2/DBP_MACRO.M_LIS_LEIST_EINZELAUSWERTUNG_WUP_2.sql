CREATE OR REPLACE PROCEDURE dbp_macro.m_lis_leist_einzelauswertung_wup (AKTION_2 VARCHAR(100), MANDANT_ID FLOAT, WUP_ID FLOAT, LEIST_EINZELAUSWERTUNG_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var InFunc = function (objectParam) {
   var result = objectParam['inArray'];
   if (objectParam['sqlText'] != '') {
      var res = snowflake.createStatement({
         sqlText : objectParam['sqlText']
      }).execute();
      while ( res.next() ) {
         result.push(res.getColumnValue(1));
      }
   }
   return result.includes(objectParam['inValue']);
};
if (!InFunc({
   sqlText : '',
   inArray : [`INS`,`DELETE FROM`,`UPD`],
   inValue : AKTION_2
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Ungültige Aktion_2`;
}
if (!InFunc({
   sqlText : '',
   inArray : 1 && (InFunc({
            sqlText : '',
            inArray : [`INS`,`UPD`],
            inValue : AKTION_2
         }) || AKTION_2 == `DELETE FROM` && MANDANT_ID != null && WUP_ID != null),
   inValue : LEIST_EINZELAUSWERTUNG_FG
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Ungültiges Flag leist_einzelauswertung_fg, zulässig 0 oder 1`;
}
if ((MANDANT_ID > 127 || MANDANT_ID < -128 || MANDANT_ID == null) && (InFunc({
         sqlText : '',
         inArray : [`INS`,`UPD`],
         inValue : AKTION_2
      }) || AKTION_2 == `DELETE FROM` && MANDANT_ID != null && WUP_ID != null)) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Ungültiger Mandant_2, zulässige Werte: mandant_id von -128 bis 127`;
}
var sql_stmt = `(SELECT
?
FROM dbp_data.mandant_2
)`;
var stmt = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID]
});
var res = stmt.execute();
res.next();
var subQueryVariable0 = res.getColumnValue(1);
if (!InFunc({
   sqlText : '',
   inArray : subQueryVariable0 && (InFunc({
            sqlText : '',
            inArray : [`INS`,`UPD`],
            inValue : AKTION_2
         }) || AKTION_2 == `DELETE FROM` && MANDANT_ID != null && WUP_ID != null),
   inValue : MANDANT_ID
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Der eingegebene Mandant_2 existiert nicht`;
}
var sql_stmt = `(SELECT
mandant_id,
nb_id,
wup_id
FROM dbp_data.wup_2
WHERE mandant_id = ?
AND nb_id = -111
AND wup_id = ?
)`;
var stmt = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WUP_ID]
});
var res = stmt.execute();
res.next();
var subQueryVariable1 = res.getColumnValue(1);
if (!InFunc({
   sqlText : '',
   inArray : subQueryVariable1 && (InFunc({
            sqlText : '',
            inArray : [`INS`,`UPD`],
            inValue : AKTION_2
         }) || AKTION_2 == `DELETE FROM` && MANDANT_ID != null && WUP_ID != null),
   inValue : MANDANT_ID
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Kein gültiges Verteilzentrum`;
}
if (AKTION_2 == `INS` && InFunc({
      sqlText : `(SELECT
mandant_id,
nb_id,
wup_id
FROM dbp_security.leist_einzelauswertung_wup_2
WHERE mandant_id = :mandant_id
AND nb_id = -111
AND wup_id = :wup_id
)`,
      inArray : [],
      inValue : MANDANT_ID
   })) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Der Datensatz, den Sie einfügen möchten, existiert schon`;
}
var sql_stmt = `INSERT INTO dbp_security.leist_einzelauswertung_wup_2 (MANDANT_ID, WUP_ID, NB_ID, LEIST_EINZELAUSWERTUNG_FG)
                SELECT
               ?,
               ?,
               -111,
               ?
               WHERE ? = 'INS'`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WUP_ID,LEIST_EINZELAUSWERTUNG_FG,AKTION_2]
}).execute();
// Löschen des VZ aus Freigabesteuerung
var sql_stmt = `DELETE FROM dbp_security.leist_einzelauswertung_wup_2
WHERE mandant_id = ?
AND nb_id = -111
AND wup_id = ?
AND ? = 'DEL'`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WUP_ID,AKTION_2]
}).execute();
// Aktualisierung des Freigabe Flag
var sql_stmt = `UPDATE dbp_security.leist_einzelauswertung_wup_2 SET leist_einzelauswertung_fg = ?
WHERE mandant_id = ?
AND nb_id = -111
AND wup_id = ?
AND ? = 'UPD'`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [LEIST_EINZELAUSWERTUNG_FG,MANDANT_ID,WUP_ID,AKTION_2]
}).execute();
var resultSetCounter = 0;
var tablelist = new Array;
var procname = `dbp_macro.m_lis_leist_einzelauswertung_wup_`;
var sql_command = `select current_session() || '_' || to_varchar(current_timestamp, 'yyyymmddhh24missss')`;
var stmt = snowflake.createStatement({
   sqlText : sql_command
});
var res = stmt.execute();
res.next();
var sessionid = procname + res.getColumnValue(1);
var setname = `SELECT
CASE WHEN ? = 'INS' THEN 'Das VZ '||TRIM(?)||' wurde hinzugefügt'
WHEN ? = 'DEL' THEN 'Das VZ '||TRIM(?)||' wurde gelöscht'
WHEN ? = 'UPD' AND ? = 1 THEN 'Das VZ '||TRIM(?)||' wurde für Einzelauswertung freigeschaltet'
WHEN ? = 'UPD' AND ? = 0 THEN 'Das VZ '||TRIM(?)||' wurde für Einzelauswertung gesperrt'
END`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [AKTION_2,WUP_ID,AKTION_2,WUP_ID,AKTION_2,LEIST_EINZELAUSWERTUNG_FG,WUP_ID,AKTION_2,LEIST_EINZELAUSWERTUNG_FG,WUP_ID]
}).execute();
return tablelist;
 
$$;

