CREATE OR REPLACE PROCEDURE dbp_macro.m_lis_leist_empfaenger_ldap_zu (MANDANT_ID FLOAT, WUP_ID FLOAT, MA_LDAP CHAR(10), LEIST_AUSWERTEBERECHTIGT_FG FLOAT)
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
if ((LEIST_AUSWERTEBERECHTIGT_FG != 0 && LEIST_AUSWERTEBERECHTIGT_FG != 1) && MANDANT_ID != null && WUP_ID != null) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Ungültiges Flag leist_auswerteberechtigt_fg, zulässig 0 oder 1`;
}
if ((MANDANT_ID > 127 || MANDANT_ID < -128 || MANDANT_ID == null) && MANDANT_ID != null && WUP_ID != null) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Ungültiger Mandant, zulässige Werte: mandant_id von -128 bis 127`;
}

if (MANDANT_ID != null && WUP_ID != null) {

var sql_stmt = `
SELECT mandant_id
FROM dbp_data.mandant
WHERE mandant_id = ` + MANDANT_ID + `;`

var stmt = snowflake.createStatement({
   sqlText : sql_stmt
});
var res = stmt.execute();

if (stmt.getRowCount() == 0) {

   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return 'Der eingegebene Mandant existiert nicht'
}

}


if (MANDANT_ID != null && WUP_ID != null) {

var sql_stmt = `(SELECT
mandant_id,
nb_id,
wup_id
FROM dbp_data.wup
WHERE mandant_id = ?
AND nb_id = -111
AND wup_id = ?
)`;

var stmt = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WUP_ID]
});
var res = stmt.execute();

if (stmt.getRowCount() == 0) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Kein gültiges Verteilzentrum`
}

}




if (MANDANT_ID != null && WUP_ID != null) {

var sql_stmt = `(SELECT
ma_ldap
FROM dbp_security.leist_empfaenger_ldap_zu
WHERE ma_ldap = ?
AND mandant_id = ?
AND wup_id = ?
AND nb_id = -111
GROUP BY ma_ldap
)`;

var stmt = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MA_LDAP,MANDANT_ID,WUP_ID]
});
var res = stmt.execute();

if (stmt.getRowCount() == 0) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `Keine gültige VZ / LDAP User Kombination`
}

}


// Aktualisierung des Freigabe Flag
var sql_stmt = `UPDATE dbp_security.leist_empfaenger_ldap_zu SET leist_auswerteberechtigt_fg = ?
WHERE mandant_id = ?
AND nb_id = -111
AND wup_id = ?
AND ma_ldap = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [LEIST_AUSWERTEBERECHTIGT_FG,MANDANT_ID,WUP_ID,MA_LDAP]
}).execute();

var setname = `SELECT
CASE WHEN ? = 1 THEN 'Der User '||TRIM(?)||' wurde für Einzelauswertung freigeschaltet'
WHEN ? = 0 THEN 'Der User '||TRIM(?)||' wurde für Einzelauswertung gesperrt'
END`;

var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [LEIST_AUSWERTEBERECHTIGT_FG,MA_LDAP,LEIST_AUSWERTEBERECHTIGT_FG,MA_LDAP]
})

var res = RESULTSET.execute()
res.next();
var return_stmt = res.getColumnValue(1);

return return_stmt;
 
$$;

