CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPD_SORTIMENT_LEISTUNG_A_FILLTEMP_U(USER VARCHAR, MATCHING_ID VARCHAR, ART_ID VARCHAR, GTIN VARCHAR, STK_RE_PFLEGE VARCHAR, VORSCHLAG VARCHAR, PRODUKTWISSEN_PFLEGE VARCHAR, LIEFERANTENWISSEN_PFLEGE VARCHAR, LISTUNG_SST_PFLEGE VARCHAR, OST_BASIS_PFLEGE VARCHAR, OST_GROSS_PFLEGE VARCHAR, SUED_OST_PFLEGE VARCHAR, SUED_WEST_PFLEGE VARCHAR, WEST_PFLEGE VARCHAR, NORD_PFLEGE VARCHAR, KJMO VARCHAR, N_K_ARTIKEL VARCHAR, NL_ART_BEZ VARCHAR, KJWO_UPDATE VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS ' 
sql=`INSERT  INTO  PUBLIC.INPUT_TABLE_EK_SORT_U 
(USER,MATCHING_ID,  ART_ID,  GTIN,  STK_RE_PFLEGE,  VORSCHLAG,  PRODUKTWISSEN_PFLEGE,  LIEFERANTENWISSEN_PFLEGE,  LISTUNG_SST_PFLEGE,  OST_BASIS_PFLEGE,  OST_GROSS_PFLEGE,  SUED_OST_PFLEGE,  SUED_WEST_PFLEGE,  WEST_PFLEGE,  NORD_PFLEGE,  KJMO,  N_K_ARTIKEL,  NL_ART_BEZ,  KJWO_UPDATE) 
VALUES(''`  +  USER  +  `'',  ''`  +  MATCHING_ID  +  `'',  ''`  +  ART_ID  +  `'',  ''`  +  GTIN  +  `'',  ''`  +  STK_RE_PFLEGE  +  `'',  ''`  +  VORSCHLAG  +  `'',  ''`  +  PRODUKTWISSEN_PFLEGE  +  `'',  ''`  +  LIEFERANTENWISSEN_PFLEGE  +  `'',  ''`  +  LISTUNG_SST_PFLEGE  +  `'',  ''`  +  OST_BASIS_PFLEGE  +  `'',  ''`  +  OST_GROSS_PFLEGE  +  `'',  ''`  +  SUED_OST_PFLEGE  +  `'',  ''`  +  SUED_WEST_PFLEGE  +  `'',  ''`  +  WEST_PFLEGE  +  `'',  ''`  +  NORD_PFLEGE  +  `'',  ''`  +  KJMO  +  `'',  ''`  +  N_K_ARTIKEL  +  `'',  ''`  +  NL_ART_BEZ  +  `'',  ''`  +  KJWO_UPDATE  +  `'');;` 
                                    sql  =  sql.replace(/''undefined''/g,  "NULL") 
                                    sql_stmt  =  snowflake.createStatement({sqlText:  sql}); 
                                    sql_stmt.execute(); 
                                    
      var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();
';