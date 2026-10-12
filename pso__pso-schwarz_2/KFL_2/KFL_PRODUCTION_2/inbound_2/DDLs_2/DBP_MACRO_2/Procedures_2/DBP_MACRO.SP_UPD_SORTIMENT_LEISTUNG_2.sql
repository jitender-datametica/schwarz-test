CREATE OR REPLACE PROCEDURE DBP_MACRO.SP_UPD_SORTIMENT_LEISTUNG_2(USER VARCHAR)
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS ' 
sql=`SELECT count(*)
      FROM PUBLIC.INPUT_TABLE_EK_SORT_U_2
      WHERE USER = ''` + USER + `''` 
                                    sql  =  sql.replace(/''undefined''/g,  "NULL") 
                                    sql_stmt  =  snowflake.createStatement({sqlText:  sql}); 
                                    res = sql_stmt.execute(); 
                                    res.next();
                                    count = res.getColumnValue(1)

/*if(count == 1){
sql=`CALL dbp_macro.sp_upd_sortiment_leistung_rowwise(''`  +  MATCHING_ID  +  `'',  ''`  +  ART_ID  +  `'',  ''`  +  GTIN  +  `'',  ''`  +  STK_RE_PFLEGE  +  `'',  ''`  +  VORSCHLAG  +  `'',  ''`  +  PRODUKTWISSEN_PFLEGE  +  `'',  ''`  +  LIEFERANTENWISSEN_PFLEGE  +  `'',  ''`  +  LISTUNG_SST_PFLEGE  +  `'',  ''`  +  OST_BASIS_PFLEGE  +  `'',  ''`  +  OST_GROSS_PFLEGE  +  `'',  ''`  +  SUED_OST_PFLEGE  +  `'',  ''`  +  SUED_WEST_PFLEGE  +  `'',  ''`  +  WEST_PFLEGE  +  `'',  ''`  +  NORD_PFLEGE  +  `'',  ''`  +  KJMO  +  `'',  ''`  +  N_K_ARTIKEL  +  `'',  ''`  +  NL_ART_BEZ  +  `'',  ''`  +  KJWO_UPDATE  +  `'')`;
sql  =  sql.replace(/''undefined''/g,  "NULL") 
                                    sql_stmt  =  snowflake.createStatement({sqlText:  sql}); 
                                    res = sql_stmt.execute(); 
                                    
                                    }*/
if (count != 0) {


if(count <= 2){

    i = 1
    while(i <= count){
    
    sql = `WITH cte AS 
(SELECT
    row_number() over(ORDER BY matching_id) AS row_num,
    MATCHING_ID,
    ART_ID,
    GTIN,
    STK_RE_PFLEGE,
    VORSCHLAG,
    PRODUKTWISSEN_PFLEGE,
    LIEFERANTENWISSEN_PFLEGE,
    LISTUNG_SST_PFLEGE,
    OST_BASIS_PFLEGE,
    OST_GROSS_PFLEGE,
    SUED_OST_PFLEGE,
    SUED_WEST_PFLEGE,
    WEST_PFLEGE,
    NORD_PFLEGE,
    KJMO,
    N_K_ARTIKEL,
    NL_ART_BEZ,
    KJWO_UPDATE
FROM
    PUBLIC.INPUT_TABLE_EK_SORT_U_2
WHERE USER = ''` + USER + `''
) 
SELECT MATCHING_ID,
    ART_ID,
    GTIN,
    STK_RE_PFLEGE,
    VORSCHLAG,
    PRODUKTWISSEN_PFLEGE,
    LIEFERANTENWISSEN_PFLEGE,
    LISTUNG_SST_PFLEGE,
    OST_BASIS_PFLEGE,
    OST_GROSS_PFLEGE,
    SUED_OST_PFLEGE,
    SUED_WEST_PFLEGE,
    WEST_PFLEGE,
    NORD_PFLEGE,
    KJMO,
    N_K_ARTIKEL,
    NL_ART_BEZ,
    KJWO_UPDATE
FROM cte
where row_num = ` + i.toString() + `;`
 
sql = sql.replace(/''undefined''/g, "NULL")
sql_stmt = snowflake.createStatement({sqlText: sql});
res = sql_stmt.execute();
res.next()
 
MATCHING_ID = res.getColumnValue(1)
ART_ID = res.getColumnValue(2)
GTIN = res.getColumnValue(3)
STK_RE_PFLEGE = res.getColumnValue(4)
VORSCHLAG = res.getColumnValue(5)
PRODUKTWISSEN_PFLEGE = res.getColumnValue(6)
LIEFERANTENWISSEN_PFLEGE = res.getColumnValue(7)
LISTUNG_SST_PFLEGE = res.getColumnValue(8)
OST_BASIS_PFLEGE = res.getColumnValue(9)
OST_GROSS_PFLEGE = res.getColumnValue(10)
SUED_OST_PFLEGE = res.getColumnValue(11)
SUED_WEST_PFLEGE = res.getColumnValue(12)
WEST_PFLEGE = res.getColumnValue(13)
NORD_PFLEGE = res.getColumnValue(14)
KJMO = res.getColumnValue(15)
N_K_ARTIKEL = res.getColumnValue(16)
NL_ART_BEZ = res.getColumnValue(17)
KJWO_UPDATE = res.getColumnValue(18)

sql=`CALL dbp_macro.sp_upd_sortiment_leistung_by_row(''`  +  MATCHING_ID  +  `'',  ''`  +  ART_ID  +  `'',  ''`  +  GTIN  +  `'',  ''`  +  STK_RE_PFLEGE  +  `'',  ''`  +  VORSCHLAG  +  `'',  ''`  +  PRODUKTWISSEN_PFLEGE  +  `'',  ''`  +  LIEFERANTENWISSEN_PFLEGE  +  `'',  ''`  +  LISTUNG_SST_PFLEGE  +  `'',  ''`  +  OST_BASIS_PFLEGE  +  `'',  ''`  +  OST_GROSS_PFLEGE  +  `'',  ''`  +  SUED_OST_PFLEGE  +  `'',  ''`  +  SUED_WEST_PFLEGE  +  `'',  ''`  +  WEST_PFLEGE  +  `'',  ''`  +  NORD_PFLEGE  +  `'',  ''`  +  KJMO  +  `'',  ''`  +  N_K_ARTIKEL  +  `'',  ''`  +  NL_ART_BEZ  +  `'',  ''`  +  KJWO_UPDATE  +  `'')`;
sql  =  sql.replace(/''undefined''/g,  "NULL") 
                                    sql_stmt  =  snowflake.createStatement({sqlText:  sql}); 
                                    res = sql_stmt.execute(); 
    
     i = i + 1
     
     
    }

}

else{
 sql=`CALL dbp_macro.sp_upd_sortiment_leistung_by_batch(''` + USER + `'')`;
 sql  =  sql.replace(/''undefined''/g,  "NULL") 
                                    sql_stmt  =  snowflake.createStatement({sqlText:  sql}); 
                                    res = sql_stmt.execute(); 
                                    
}


sql=`DELETE FROM PUBLIC.INPUT_TABLE_EK_SORT_U_2
    WHERE user = ''`+ USER + `'';`;
                  sql = sql.replace(/''''undefined''''/g, "NULL")
                  sql_stmt = snowflake.createStatement({sqlText: sql});
                  sql_stmt.execute();   
}

';