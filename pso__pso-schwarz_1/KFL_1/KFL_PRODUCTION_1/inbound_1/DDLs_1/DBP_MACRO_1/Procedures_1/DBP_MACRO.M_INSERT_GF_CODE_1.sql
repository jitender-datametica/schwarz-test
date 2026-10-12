CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_gf_code (GF_ID FLOAT, MANDANT_ID FLOAT, GF_CODE_1 VARCHAR(10))
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
               FROM dbp_view.v_mandant_1
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
	   return `ACHTUNG: eigegebene mandant_id existiert nicht !!!`;
	}


var sql_stmt = `SELECT  gf_id
               FROM dbp_view.v_gf_1 
               WHERE mandant_id = ?
               AND GF_ID = ?`;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[MANDANT_ID,GF_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() == 0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `ACHTUNG: eingegebene gf_id existiert nicht für den eingegebenen mandant_id in der der Lookuptabelle dbx_data.gf_1 !!!`;
	}

var sql_stmt = `SELECT gf_id
               FROM dbp_security.gf_code_1 
               WHERE gf_id = ?
               AND mandant_id = ?`;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[GF_ID, MANDANT_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() != 0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `ACHTUNG: eingegebene gf_id für den eingegebenen mandant_id ist bereits in der Zieltabelle vorhanden !!!`;
	}

//Neuen Satz hinzufügen
var sql_stmt = `INSERT INTO dbp_security.gf_code_1 (GF_ID, MANDANT_ID, GF_CODE_1)
				VALUES (?, ?, ?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [GF_ID,MANDANT_ID,GF_CODE_1]
}).execute();

//var resultSetCounter = 0;
//var tablelist = new Array;
////Ausgabe des hizugefügten Satzes zur Kontrolle
//var procname = `dbp_macro.m_insert_gf_code_`;
//var sql_command = `select current_session() || '_' || to_varchar(current_timestamp, 'yyyymmddhh24missss')`;
//var stmt = snowflake.createStatement({
//   sqlText : sql_command
//});
//var res = stmt.execute();
//res.next();
//var sessionid = procname + res.getColumnValue(1);
////Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
//
////Ausgabe des hizugefügten Satzes zur Kontrolle
//var setname = `SELECT
//'neuer gf_code_1 für folgenden gf_id & mandant_id generiert' AS Status_1,
//gf_id,
//mandant_id,
//gf_code_1
//FROM dbp_security.gf_code_1
//WHERE gf_id = ? AND mandant_id = ?`;
//var tablename = sessionid + `_` + resultSetCounter++;
////var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;

// Falls das Feature noch gewünscht ist, muss das noch für Snowflake angepasst werden. Im Folgenden ist nur der Ansatz implementiert.
//var sql_stmt = `CREATE TEMPORARY TABLE public.m_insert_gf_code 
//AS 
//SELECT
//'neuer gf_code_1 für folgenden gf_id & mandant_id generiert' AS Status_1,
//gf_id,
//mandant_id,
//gf_code_1
//FROM dbp_security.gf_code_1
//WHERE gf_id = ? AND mandant_id = ?`;
//tablelist.push(tablename);
//var RESULTSET = snowflake.createStatement({
//   sqlText : sql_stmt,
//   binds : [GF_ID,MANDANT_ID]
//}).execute();
//return tablelist;
 
$$;

