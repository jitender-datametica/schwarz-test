CREATE OR REPLACE PROCEDURE dbp_macro.m_update_l_bon_wup (MANDANT_ID FLOAT, WUP_ID FLOAT)
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
   sqlText : `(SELECT
mandant_id
FROM dbp_view.v_mandant_1)`,
   inArray : [],
   inValue : MANDANT_ID
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `ACHTUNG: eingegebene mandant_id existiert nicht !!!`;
}

var sql_stmt = `SELECT
               wup_id
               FROM dbp_view.v_wup_1 
               WHERE wup_id = ?
               GROUP BY wup_id`;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[WUP_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() == 0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `ACHTUNG: eingegebene wup_id existiert nicht in der Tabelle wup_1 !!!`;
	}



var resultSetCounter = 0;
var tablelist = new Array;
//Ausgabe des ändernden Satzes (VORHER)
var procname = `dbp_macro.m_update_l_bon_wup_`;
var sql_command = `select current_session() || '_' || to_varchar(current_timestamp, 'yyyymmddhh24missss')`;
var stmt = snowflake.createStatement({
   sqlText : sql_command
});
var res = stmt.execute();
res.next();
var sessionid = procname + res.getColumnValue(1);
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
//Ausgabe des ändernden Satzes (VORHER)
var setname = `SELECT
'VORHER' AS Status_1,
v01.*
FROM dbp_msi_v_view.v_l_bon_wup_1 v01
WHERE v01.mandant_id = ? AND v01.wup_id IN (?)`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WUP_ID]
}).execute();
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
//bestehenden Satz updaten
var sql_stmt = `UPDATE dbp_msi_data.l_bon_wup_1 SET
bda_anym_fg = 0
, gesperrt_fg = 0
, dat = CURRENT_DATE
, user_id = USER
WHERE mandant_id = ? AND ? IN (?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WUP_ID,WUP_ID]
}).execute();
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
//Ausgabe des ändernden Satzes (NACHHER)
var setname = `SELECT
'NACHHER' AS Status_1,
v01.*
FROM dbp_msi_v_view.v_l_bon_wup_1 v01
WHERE v01.mandant_id = ? AND v01.wup_id IN (?)`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,WUP_ID]
}).execute();
return tablelist;
 
$$;

