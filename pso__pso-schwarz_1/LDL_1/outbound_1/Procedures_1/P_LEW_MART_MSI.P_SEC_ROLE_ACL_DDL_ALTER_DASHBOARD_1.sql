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

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.p_sec_role_acl_ddl_alter_dashboard(OUT out_param STRING)
BEGIN
DECLARE res ARRAY<JSON>;
DECLARE l_output ARRAY<STRING>; 
DECLARE add_dashboard STRUCT<sql STRING>;
DECLARE l_change_type STRING;
DECLARE l_dashboard STRING;
DECLARE l_sql STRING;
DECLARE l_sql_update STRING; -- Added to hold the second statement
DECLARE iterator_res INT64 DEFAULT 0; 

/* Initialisation */
SET l_output  =  [];

/* Initialisation */
SET add_dashboard  =  STRUCT('''
                             SELECT   
                             change_type
                             ,REPLACE(dashboard_name, " ", "_") AS dashboard_name_underscore 
                             FROM p_lew_mart_msi.t_sec_role_acl_load_1
                             WHERE 
                             (
                                 change_type = "ADD_DASHBOARD"
                                 AND REPLACE(dashboard_name, " ", "_") NOT IN (
                                                                SELECT 
                                                                column_name
                                                                FROM p_lew_mart_msi.INFORMATION_SCHEMA.COLUMNS
                                                                WHERE table_name = "t_sec_sec_role_acl_1"
                                                                )
                             )    
                             UNION ALL 
                             
                             SELECT 
                             change_type
                             ,REPLACE(dashboard_name, " ", "_") AS dashboard_name_underscore 
                             FROM p_lew_mart_msi.t_sec_role_acl_load_1
                             WHERE 
                             (
                                 change_type = "DROP_DASHBOARD"
                                 AND REPLACE(dashboard_name, " ", "_") IN (
                                                                SELECT 
                                                                column_name
                                                                FROM p_lew_mart_msi.INFORMATION_SCHEMA.COLUMNS
                                                                WHERE table_name = "t_sec_sec_role_acl_1"
                                                                )
                             )
                             ORDER BY 1 ''' as sql);

/* Select operation */
EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'change_type,dashboard_name_underscore',  add_dashboard.sql)
INTO res ;

-- Loop through the results, processing one row at a time... 
WHILE (iterator_res  < ARRAY_LENGTH(res)) DO
    BEGIN
    SET l_change_type  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    SET l_dashboard  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]')    ;
    
    IF l_change_type = 'ADD_DASHBOARD' THEN
        SET l_sql  =  '''ALTER TABLE p_lew_mart_msi.t_sec_sec_role_acl_1 ADD COLUMN ''' || l_dashboard || ''' INTEGER''';
        SET l_sql_update = '''UPDATE p_lew_mart_msi.t_sec_sec_role_acl_1 SET ''' || l_dashboard || ''' = 0 WHERE ''' || l_dashboard || ''' IS NULL''';
        
        EXECUTE IMMEDIATE (l_sql);
        EXECUTE IMMEDIATE (l_sql_update);
        
        SET l_sql = l_sql || '; ' || l_sql_update;
        
    ELSEIF l_change_type = 'DROP_DASHBOARD' THEN
        SET l_sql  =  '''ALTER TABLE p_lew_mart_msi.t_sec_sec_role_acl_1 DROP COLUMN ''' || l_dashboard;
        
        EXECUTE IMMEDIATE (l_sql);
    END IF;


    SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(STRUCT(l_sql AS sql, @@last_job_id AS QueryId))]); 
    
    SET iterator_res  =  iterator_res  + 1    ;
    END;
END WHILE;

/* return number of rows applied and query_id */
SET out_param  =  TO_JSON_STRING(l_output);
SELECT out_param;
RETURN;
END;
