
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


CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.P_V_SEC_SECURITY_ROLE_DDL_REPLACE()
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
                                SELECT distinct
                                   dashboard_name AS dashboard_name
                                 , RANK() OVER (ORDER BY dashboard_name) AS dashboard_id
                                FROM P_LEW_MART_MSI.t_sec_role_acl_dash_act_1
                                WHERE
                                EXISTS (
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
                                listagg(dashboard_name,  ',\n') 
                                    WITHIN GROUP (ORDER BY dashboard_id) AS column_list_1
                                ,listagg('CASE WHEN sda.' || dashboard_name || ' = 1 THEN sro.' || dashboard_name || ' ELSE 0 END AS ' || dashboard_name,  ',\n') 
                                    WITHIN GROUP (ORDER BY dashboard_id) AS column_list_2
                                ,listagg('MAX(CASE WHEN dashboard_name = ''' || dashboard_name || ''' THEN dashboard_active_fg ELSE 0 END) AS ' || dashboard_name,  ',\n') 
                                    WITHIN GROUP (ORDER BY dashboard_id) AS column_list_3    
                                FROM cte_dash
                            )
                            SELECT 
                            *
                            FROM cte_list
                            WHERE 
                            column_list_1 <> ''
                            --------------------------------------------------------------
                            `                    
                  };

    /* Select operation */     
    res = snowflake.createStatement({sqlText: add_dashboard.sql}).execute();        

    // if no data there is no run
    while (res.next())  {
    
        l_column_list_1 = res.getColumnValue(1);
        l_column_list_2 = res.getColumnValue(2);
        l_column_list_3 = res.getColumnValue(3);
        

        l_sql = `CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SEC_SECURITY_ROLE_1
(
security_role_id,
security_role_desc,
` + l_column_list_1 + `
)
AS
SELECT
sro.security_role_id,
sro.security_role_desc,
` + l_column_list_2 + `
FROM P_LEW_MART_MSI.t_sec_sec_role_acl_1 sro 
CROSS JOIN (SELECT
` + l_column_list_3 + `
FROM P_LEW_MART_MSI.v_sec_role_acl_dash_act_1 sdx ) sda
`
            
      try {  
      
        /* Apply operation */
        var stmt = snowflake.createStatement({sqlText: l_sql});
        stmt.execute();
        l_output.push({column_list: l_column_list_1, QueryId: stmt.getQueryId()}); 
    
      }
      catch (err)  {
      
          l_output.push({sql: l_sql, msg : err.message});
      }

    }           

    /* return number of rows applied and query_id */
    return JSON.stringify(l_output);
$$
;
