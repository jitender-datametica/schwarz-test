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

CREATE OR REPLACE PROCEDURE ldl_production_p_lew_mart_msi.p_sec_role_acl_ddl_alter_dashboard(OUT out_param STRING)
BEGIN
    DECLARE res ARRAY<JSON>;
    DECLARE l_output ARRAY<STRING> DEFAULT [];
    DECLARE add_dashboard STRUCT<sql STRING>;
    DECLARE iterator_res INT64 DEFAULT -1;

    /* Initialisation */
    SET l_output = [];

    /* Initialisation */
    /* Note: 
       1. Changed information_schema path to: ldl_production_p_lew_mart_msi.INFORMATION_SCHEMA.COLUMNS
       2. Replaced Javascript 'dashboard_name_underscore' logic directly into SQL query
    */
    SET add_dashboard = STRUCT('''
                            --------------------------------------------------------------   
                            SELECT   
                            change_type
                            ,REPLACE(dashboard_name,' ','_') AS dashboard_name_underscore 
                            FROM ldl_production_p_lew_mart_msi.t_sec_role_acl_load
                            WHERE 
                            (
                                change_type = 'ADD_DASHBOARD'
                                AND REPLACE(dashboard_name,' ','_') NOT IN (
                                                               SELECT 
                                                               column_name
                                                               FROM ldl_production_p_lew_mart_msi.INFORMATION_SCHEMA.COLUMNS
                                                               WHERE 
                                                               table_name = 'T_SEC_SEC_ROLE_ACL'
                                                               )
                            )    
                            UNION ALL 
                            
                            SELECT 
                            change_type
                            ,REPLACE(dashboard_name,' ','_') AS dashboard_name_underscore 
                            FROM ldl_production_p_lew_mart_msi.t_sec_role_acl_load
                            WHERE 
                            (
                                change_type = 'DROP_DASHBOARD'
                                AND REPLACE(dashboard_name,' ','_') IN (
                                                               SELECT 
                                                               column_name
                                                               FROM ldl_production_p_lew_mart_msi.INFORMATION_SCHEMA.COLUMNS
                                                               WHERE 
                                                               table_name = 'T_SEC_SEC_ROLE_ACL'
                                                               )
                            )
                            ORDER BY 1
                            --------------------------------------------------------------
                            ''' as sql);

    /* Select operation*/     
    EXECUTE IMMEDIATE format("""
        SELECT ARRAY_AGG(JSON_ARRAY(%s))
        FROM (%s)
    """, 'change_type, dashboard_name_underscore', add_dashboard.sql) INTO res;

    WHILE (iterator_res < (ARRAY_LENGTH(res) - 1)) DO
        BEGIN
            DECLARE l_change_type STRING;
            DECLARE l_dashboard   STRING;
            DECLARE l_sql         STRING;
    
            SET iterator_res = iterator_res + 1;

            SET l_change_type = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');
            SET l_dashboard   = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]');
        
            IF l_change_type = 'ADD_DASHBOARD' THEN
                SET l_sql = "ALTER TABLE ldl_production_p_lew_mart_msi.t_sec_sec_role_acl ADD COLUMN " || l_dashboard || " INTEGER DEFAULT 0 NOT NULL";
            ELSEIF l_change_type = 'DROP_DASHBOARD' THEN
                SET l_sql = "ALTER TABLE ldl_production_p_lew_mart_msi.t_sec_sec_role_acl DROP COLUMN " || l_dashboard;
            END IF;
   
            BEGIN
                /* Apply operation */
                EXECUTE IMMEDIATE l_sql;
            
                SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(STRUCT(l_sql AS sql, @@last_job_id AS QueryId))]);
            EXCEPTION WHEN ERROR THEN
                SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(STRUCT(l_sql AS sql, @@error.message AS msg))]);
            END;

        END;           
    END WHILE;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(l_output);
    SELECT out_param;
END;