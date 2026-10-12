CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPD_SORTIMENT_LEISTUNG_KMO_A_FILLTEMP_U(USER VARCHAR, MANDANT_ID VARCHAR, MATCHING_ID VARCHAR, ART_ID VARCHAR, GTIN VARCHAR, STK_RE_PFLEGE VARCHAR, VORSCHLAG VARCHAR, PRODUKTWISSEN_PFLEGE VARCHAR, LIEFERANTENWISSEN_PFLEGE VARCHAR, LISTUNG_SST_PFLEGE VARCHAR, LISTUNG_K_SST_PFLEGE VARCHAR, KJMO VARCHAR, N_K_ARTIKEL VARCHAR, NL_ART_BEZ VARCHAR, KJWO_UPDATE VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
  

sql=`INSERT INTO PUBLIC.INPUT_TABLE_EK_SORT_kmo_U
(user,mandant_id ,matching_id ,art_id ,gtin,stk_re_pflege,vorschlag,produktwissen_pflege,lieferantenwissen_pflege,listung_sst_pflege ,listung_k_sst_pflege ,kjmo ,n_k_artikel ,nl_art_bez ,kjwo_update)
  VALUES(''` + USER + `'', ''` + MANDANT_ID + `'', ''` + MATCHING_ID + `'',''` + ART_ID + `'', ''` + GTIN + `'', ''` + STK_RE_PFLEGE + `'', ''` + VORSCHLAG + `'', ''` + PRODUKTWISSEN_PFLEGE + `'', ''` + LIEFERANTENWISSEN_PFLEGE + `'', ''` + LISTUNG_SST_PFLEGE + `'', ''` + LISTUNG_K_SST_PFLEGE + `'', ''` + KJMO + `'', ''` + N_K_ARTIKEL + `'', ''` + NL_ART_BEZ + `'', ''` + KJWO_UPDATE + `'');;` 
                 sql = sql.replace(/''undefined''/g, "NULL") 
                  sql_stmt = snowflake.createStatement({sqlText: sql}); 
                  sql_stmt.execute(); 
 
 var sql_commit = `COMMIT;`
snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

';