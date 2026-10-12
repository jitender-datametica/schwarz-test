CREATE OR REPLACE PROCEDURE dbp_macro.m_delete_gf_code (GF_ID FLOAT, MANDANT_ID FLOAT)
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
var sql_stmt = `SELECT gf_id 
                  FROM dbp_security.gf_code_1
	               WHERE gf_id = ? 
                  AND mandant_id = ? `;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[GF_ID, MANDANT_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() ==0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `ACHTUNG: eingegebene gf_id für den eingegebenen mandant_id existiert nicht in der Zieltabelle !!!`;
	}

var resultSetCounter = 0;
var tablelist = new Array;
//Ausgabe des zu löschenden Satzes zur Kontrolle
var procname = `dbp_macro.m_delete_gf_code_`;
var sql_command = `select current_session() || '_' || to_varchar(current_timestamp, 'yyyymmddhh24missss')`;
var stmt = snowflake.createStatement({
   sqlText : sql_command
});
var res = stmt.execute();
res.next();
var sessionid = procname + res.getColumnValue(1);
//Conversion warning - One or more identifiers in this statement were considered parameters by default. Referenced table not found.
//Ausgabe des zu löschenden Satzes zur Kontrolle
var setname = `SELECT
'gelöschter gf_code_1 für folgende gf_id & mandant_id' AS Status_1,
gf_id,
mandant_id
FROM dbp_security.gf_code_1
WHERE gf_id = ? AND mandant_id = ?`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [GF_ID,MANDANT_ID]
}).execute();
//bestehenden Satz löschen
var sql_stmt = `DELETE FROM dbp_security.gf_code_1
WHERE gf_id= ? AND mandant_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [GF_ID,MANDANT_ID]
}).execute();

var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

return tablelist;
 

 
$$;

