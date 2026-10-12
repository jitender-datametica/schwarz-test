CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_msi_user (user_id CHAR(30), msi_produkt_bez VARCHAR(10))
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
   var sql_stmt = `SELECT USER_ID 
                  FROM dbp_security.l_msi_user
	               WHERE MSI_PRODUKT_BEZ = ? 
                  AND USER_ID = ? `;
	var stmt = snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[MSI_PRODUKT_BEZ, USER_ID]
	});
	var res = stmt.execute();
	if (res.getRowCount() !=0) {
	   var sql_stmt = `ROLLBACK`;
	   var stmt = snowflake.createStatement({
	      sqlText : sql_stmt
	   });
	   var res = stmt.execute();
	   return `ACHTUNG: Eingegebener LDAP existiert bereits`;
	}
	var sql_stmt = `INSERT INTO dbp_security.l_msi_user (USER_ID,MSI_PRODUKT_BEZ)
                   SELECT upper(substr(trim(?),1, 2)) || lower(substr(trim(?), 3, length(trim(?)) - 2))
				   		  , ?`;
	snowflake.createStatement({
	   sqlText : sql_stmt,
       binds:[USER_ID,USER_ID,USER_ID,MSI_PRODUKT_BEZ]
	}).execute();


	var sql_commit = `COMMIT;`
    snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
$$;