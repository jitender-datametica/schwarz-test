CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_l_bis_ldap (MA_LDAP CHAR(10))
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
if (InFunc({
   sqlText : `(SELECT
ma_ldap
FROM dbp_security.l_bis_ldap)`,
   inArray : [],
   inValue : MA_LDAP
})) {
   var sql_stmt = `ROLLBACK`;
   var stmt = snowflake.createStatement({
      sqlText : sql_stmt,
      binds : []
   });
   var res = stmt.execute();
   return `ACHTUNG: eingegebener Einkäufer (LDAP) existiert bereits.`;
}
var sql_stmt = `INSERT INTO dbp_security.l_bis_ldap (MA_LDAP) VALUES (?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [MA_LDAP]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$
   ;

