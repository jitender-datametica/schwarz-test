CREATE OR REPLACE FUNCTION KFL_PRODUCTION.PUBLIC.MONTHS_BETWEEN_UDF2("DATE1" VARCHAR(16777216), "DATE2" VARCHAR(16777216))
RETURNS FLOAT
LANGUAGE JAVASCRIPT
AS '
  
  
    var sqlNewText = "SELECT IFF(DAY(''" + DATE1 + "''::DATE) >= DAY (''" + DATE2 + "''::DATE), DATEDIFF(''month'', ''" + DATE2 + "''::DATE, ''" + DATE1 + "''::DATE), DATEDIFF(''month'', ''" + DATE2 + "''::DATE, ''" + DATE1 + "''::DATE) -1) + " + 
                     "IFF(DAY(''" + DATE1 + "''::DATE) >= DAY(''" + DATE2 + "''::DATE), (GREATEST(DAY(''" + DATE1 + "''::DATE), DAY(''" + DATE2 + "''::DATE)) - LEAST(DAY(''" + DATE1 + "''::DATE), day(''" + DATE2 + "''::DATE))) / 31 " + 
                     " ,1 - (GREATEST(DAY(''" + DATE1 + "''::DATE), DAY(''" + DATE2 + "''::DATE)) - LEAST(DAY(''" + DATE1 + "''::DATE), DAY(''" + DATE2 + "''::DATE))) / 31);";
                     
    
  	var statement = snowflake.createStatement( {sqlText: sqlNewText} );
  	var rs_1 = statement.execute();
  
    rs.next();
    var myValue = rs.getColumnValue(1);

    return myValue;
    
  ';