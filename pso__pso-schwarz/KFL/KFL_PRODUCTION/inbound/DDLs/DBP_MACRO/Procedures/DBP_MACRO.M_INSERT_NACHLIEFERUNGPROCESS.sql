CREATE OR REPLACE PROCEDURE DBP_MACRO.M_INSERT_NACHLIEFERUNGPROCESS(MANDANT_ID FLOAT, GP_EXP_NAME VARCHAR(16777216), DAT_START VARCHAR(16777216), ANZAHL_DATEIEN FLOAT, LDAP_USER VARCHAR(16777216), WUP_ID FLOAT, ART_ID FLOAT, REQUEST_ID FLOAT)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS 
'
var sql_stmt = `INSERT INTO dbp_msi_data.ts_nachlieferung (NACHLIEFERUNG_REQUEST_ID, GP_EXP_NAME, MANDANT_ID, WUP_ID, ART_ID, DAT_START, 
                                                           ANZAHL_DATEIEN, ACTIVE_FG, LDAP_USER, DATZEIT_INSERT, TD_UPDATE, TD_INSERT)
                  VALUES ( :1 // REQUEST_ID
						  ,:2 // GP_EXP_NAME
						  ,:3 // MANDANT_ID
						  ,:4 // WUP_ID
                          ,:5 // ART_ID
						  ,:6 // DAT_START
						  ,:7 // ANZAHL_DATEIEN
						  , 1
                          ,:8 // LDAP
						  ,CURRENT_TIMESTAMP()
						  ,CURRENT_TIMESTAMP()
						  ,CURRENT_TIMESTAMP()
                          )`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [REQUEST_ID, GP_EXP_NAME, MANDANT_ID, WUP_ID, ART_ID, DAT_START, ANZAHL_DATEIEN, LDAP_USER].map(function(x){return x === undefined ? null : x})
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
'
;