CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_user_hr_objekt_id_zu (MANDANT_ID FLOAT, HR_OBJEKT_EBENE1_ID FLOAT, USER_ID VARCHAR(30))
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

var sql_stmt = `SELECT  mandant_id
               FROM dbp_view.v_mandant
	            WHERE mandant_id = ?`;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[MANDANT_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() == 0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `Mandant existiert nicht`;
	}


var sql_stmt = `SELECT
                  hr_objekt_ebene1_id
               FROM dbp_view.v_org_einheit_hierarchie 
               WHERE mandant_id = ?
                 AND HR_OBJEKT_EBENE1_ID = ?
               GROUP BY hr_objekt_ebene1_id`;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[MANDANT_ID, HR_OBJEKT_EBENE1_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() == 0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `Einstiegsebene (hr_objekt_id) existiert nicht`;
	}

var sql_stmt = `SELECT
                user_id
              FROM dbp_security.user_hr_objekt_id_zu
              WHERE user_id = ?
              AND mandant_id = ?
              AND hr_objekt_ebene1_id = ?`;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[USER_ID ,MANDANT_ID ,HR_OBJEKT_EBENE1_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() != 0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `DB-User mit der eingegebenen Einstiegsebene ist bereits in der Zieltabelle vorhanden`;
	}


//Neuen Satz hinzufügen
var sql_stmt = `INSERT INTO dbp_security.user_hr_objekt_id_zu (MANDANT_ID, HR_OBJEKT_EBENE1_ID, USER_ID)
				VALUES (?, ?, ?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MANDANT_ID,HR_OBJEKT_EBENE1_ID,USER_ID]
}).execute();
var resultSetCounter = 0;
var tablelist = new Array;
//Ausgabe des hizugefügten Satzes zur Kontrolle
var procname = `dbp_macro.m_insert_user_hr_objekt_id_zu_`;
var sql_command = `select current_session() || '_' || to_varchar(current_timestamp, 'yyyymmddhh24missss')`;
var stmt = snowflake.createStatement({
   sqlText : sql_command
});
var res = stmt.execute();
res.next();
var sessionid = procname + res.getColumnValue(1);
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
//Ausgabe des hizugefügten Satzes zur Kontrolle
var setname = `SELECT
'neuer User' AS Status,
?,
?,
?
FROM dbp_security.user_hr_objekt_id_zu
WHERE user_id = ?`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [USER_ID,MANDANT_ID,HR_OBJEKT_EBENE1_ID,USER_ID]
}).execute();
return tablelist;
 
$$;

