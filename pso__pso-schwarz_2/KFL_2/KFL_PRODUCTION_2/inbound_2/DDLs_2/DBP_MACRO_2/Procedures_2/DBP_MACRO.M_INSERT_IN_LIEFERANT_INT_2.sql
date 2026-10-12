CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_in_lieferant_int (LIEF_NAME VARCHAR(40))
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
      sqlText : `(SELECT lief_name
                  FROM dbp_data.in_lieferant_int_2)`,
      inArray : [],
      inValue : LIEF_NAME
   })) {
         var sql_stmt = `ROLLBACK`;
         var stmt = snowflake.createStatement({
            sqlText : sql_stmt,
            binds : []
         });
         var res = stmt.execute();
         return `ACHTUNG: eingegebener Int. Lieferant existiert bereits.`;
}

   var sql_stmt = `INSERT INTO dbp_data.in_lieferant_int_2 (IN_LIEF_ID_INT ,LIEF_NAME)
                   SELECT COALESCE(MAX(in_lief_id_int),0) +1
                           ,?
                  FROM dbp_data.in_lieferant_int_2`;
      snowflake.createStatement({
         sqlText : sql_stmt,
         binds : [LIEF_NAME]
      }).execute();

   var sql_commit = `COMMIT;`
     snowflake.createStatement({
   	   sqlText : sql_commit
   	}).execute();

$$;