/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-22 Pawel Wieczorek          ITS0012223 Initial version
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.P_V_SEC_SEC_ROLE_ACL_DDL_REPLACE()
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
    /* Initialisation */
    var res;
    var l_output = [];

    /* Initialisation */
    var res;
    var add_dashboard = { 
                     sql  : `
                            --------------------------------------------------------------   
                            WITH
                            cte_dash AS (
                                SELECT 
                                 column_name
                                ,ordinal_position
                                FROM information_schema.columns
                                WHERE 
                                table_schema = 'P_LEW_MART_MSI'  
                                AND table_name = 'V_SEC_SECURITY_ROLE_1'
                                AND EXISTS (
                                    SELECT 1 
                                    FROM P_LEW_MART_MSI.t_sec_role_acl_load_1
                                    WHERE 
                                    (
                                    change_type LIKE 'ADD_DASHBOARD'
                                    OR 
                                    change_type LIKE 'DELETE_DASHBOARD'
                                    )
                                )
                            )
                            ,cte_list AS (
                                SELECT
                                listagg(column_name,  ',\n') 
                                    WITHIN GROUP (ORDER BY ordinal_position) AS column_list
                                FROM cte_dash
                            )                            
                            SELECT 
                            *
                            FROM cte_list
                            WHERE 
                            column_list <> ''
                            --------------------------------------------------------------
                            `                    
                  };

    /* Select operation */     
    res = snowflake.createStatement({sqlText: add_dashboard.sql}).execute();        

    // if no data there is no run
    while (res.next())  {
    
        l_column_list = res.getColumnValue(1);

        l_sql = `CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SEC_SEC_ROLE_ACL_1 
(
` + l_column_list + `
)
AS 
SELECT 
` + l_column_list + `
FROM P_LEW_MART_MSI.V_SEC_SECURITY_ROLE_1
`
      try {  
      
        /* Apply operation */
        var stmt = snowflake.createStatement({sqlText: l_sql});
        stmt.execute();
        l_output.push({QueryId: stmt.getQueryId()});
    
      }
      catch (err)  {
      
          l_output.push({sql: l_sql, msg : err.message});
      }
    }           

    /* return number of rows applied and query_id */
    return JSON.stringify(l_output);
$$
;



