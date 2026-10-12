/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-22 Pawel Wieczork          ITS0012223 Initial version
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.P_SEC_SEC_ROLE_ACL_UPDATE()
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
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
                                SELECT 
                                 REPLACE(dashboard_name,' ','_') AS dashboard_name
                                ,authorized 
                                ,security_role_desc 
                                FROM P_LEW_MART_MSI.t_sec_role_acl_load_1
                                WHERE 
                                change_type = 'UPDATE_ACCESS'
                                AND EXISTS (
                                    SELECT 1
                                    FROM P_LEW_MART_MSI.t_sec_role_acl_load_1
                                    WHERE change_type LIKE 'UPDATE_ACCESS'
                                )  
                             --------------------------------------------------------------
                             `                    
                  };
              
    /* Select operation */     
    res = snowflake.createStatement({sqlText: add_dashboard.sql}).execute();        

    // Loop through the results, processing one row at a time... 
    while (res.next())  {

        l_dashboard          = res.getColumnValue(1);
        l_authorized         = res.getColumnValue(2);
        l_security_role_desc = res.getColumnValue(3);

        l_sql= "UPDATE P_LEW_MART_MSI.T_SEC_SEC_ROLE_ACL_1 SET " + l_dashboard + " = :1 WHERE security_role_desc = :2";
        l_bind = [l_authorized, l_security_role_desc];

        /* Apply operation */
        var stmt = snowflake.createStatement({sqlText: l_sql, binds: l_bind});
        stmt.execute();
    
        l_output.push({sql: l_sql, QueryId: stmt.getQueryId(), binds: l_bind}); 
    }           

    /* return number of rows applied and query_id */
    return JSON.stringify(l_output);
$$
;

