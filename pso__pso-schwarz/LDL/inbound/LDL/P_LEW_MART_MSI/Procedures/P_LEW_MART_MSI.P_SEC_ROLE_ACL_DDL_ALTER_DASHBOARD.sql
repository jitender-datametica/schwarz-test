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


CREATE OR REPLACE PROCEDURE P_LEW_MART_MSI.P_SEC_ROLE_ACL_DDL_ALTER_DASHBOARD()
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
                             SELECT   
                             change_type
                             ,REPLACE(dashboard_name,' ','_') AS dashboard_name_underscore 
                             FROM P_LEW_MART_MSI.t_sec_role_acl_load
                             WHERE 
                             (
                                 change_type = 'ADD_DASHBOARD'
                                 AND dashboard_name_underscore NOT IN (
                                                                SELECT 
                                                                column_name
                                                                FROM information_schema.columns
                                                                WHERE 
                                                                table_schema = 'P_LEW_MART_MSI'  
                                                                AND table_name = 'T_SEC_SEC_ROLE_ACL'
                                                                )
                             )    
                             UNION ALL 
                             
                             SELECT 
                             change_type
                             ,REPLACE(dashboard_name,' ','_') AS dashboard_name_underscore 
                             FROM P_LEW_MART_MSI.t_sec_role_acl_load
                             WHERE 
                             (
                                 change_type = 'DROP_DASHBOARD'
                                 AND dashboard_name_underscore IN (
                                                                SELECT 
                                                                column_name
                                                                FROM information_schema.columns
                                                                WHERE 
                                                                table_schema = 'P_LEW_MART_MSI'  
                                                                AND table_name = 'T_SEC_SEC_ROLE_ACL'
                                                                )
                             )
                             ORDER BY 1
                             --------------------------------------------------------------
                             `                    
                  };

    /* Select operation */     
    res = snowflake.createStatement({sqlText: add_dashboard.sql}).execute();        

    // Loop through the results, processing one row at a time... 
    while (res.next())  {
    
        l_change_type = res.getColumnValue(1);
        l_dashboard   = res.getColumnValue(2);
        
    
        if(l_change_type == 'ADD_DASHBOARD')
            l_sql = "ALTER TABLE P_LEW_MART_MSI.t_sec_sec_role_acl ADD COLUMN " + l_dashboard + " NUMBER(38,0) NOT NULL DEFAULT 0"
        else if(l_change_type == 'DROP_DASHBOARD')
            l_sql = "ALTER TABLE P_LEW_MART_MSI.t_sec_sec_role_acl DROP COLUMN " + l_dashboard
   
           
                
        /* Apply operation */
        var stmt = snowflake.createStatement({sqlText: l_sql});
        stmt.execute();
    
        l_output.push({sql: l_sql, QueryId: stmt.getQueryId()}); 
    }           

    /* return number of rows applied and query_id */
    return JSON.stringify(l_output);
$$
;

