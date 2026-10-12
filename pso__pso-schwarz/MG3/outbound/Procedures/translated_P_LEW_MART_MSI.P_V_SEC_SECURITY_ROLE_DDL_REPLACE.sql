CREATE OR REPLACE PROCEDURE ldl_production_p_lew_mart_msi.p_v_sec_security_role_ddl_replace(OUT out_param STRING)
BEGIN
DECLARE res ARRAY<JSON>;
DECLARE l_output ARRAY<STRING(16777216)> DEFAULT [];
DECLARE add_dashboard STRUCT<sql STRING>;
DECLARE iterator_res INT64 DEFAULT -1;
/* Initialisation */
SET l_output  =  [];
/* Initialisation */
SET add_dashboard  =  STRUCT('''
        WITH cte_dash AS (
            SELECT DISTINCT 
                dashboard_name, 
                RANK() OVER (ORDER BY dashboard_name IS NULL, dashboard_name) AS dashboard_id   
            FROM ldl_production_p_lew_mart_msi.t_sec_role_acl_dash_act   
            WHERE EXISTS (
                SELECT 1 
                FROM ldl_production_p_lew_mart_msi.t_sec_role_acl_load     
                WHERE change_type LIKE 'ADD_DASHBOARD' OR change_type LIKE 'DELETE_DASHBOARD'
            )
        ), 
        cte_list AS (
            SELECT 
                STRING_AGG(dashboard_name, ',\\n' ORDER BY dashboard_id IS NULL, dashboard_id) AS column_list_1,    
                STRING_AGG('CASE WHEN sda.' || dashboard_name || ' = 1 THEN sro.' || dashboard_name || ' ELSE 0 END AS ' || dashboard_name, ',\\n' ORDER BY dashboard_id IS NULL, dashboard_id) AS column_list_2,    
                STRING_AGG('MAX(CASE WHEN dashboard_name = \\'' || dashboard_name || '\\' THEN dashboard_active_fg ELSE 0 END) AS ' || dashboard_name, ',\\n' ORDER BY dashboard_id IS NULL, dashboard_id) AS column_list_3   
            FROM cte_dash   
            HAVING column_list_1 <> ''
        ) 
        SELECT * FROM cte_list
    ''' as sql);
/* Select operation */

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'column_list_1,column_list_2,column_list_3',  add_dashboard.sql) INTO res;
-- if no data there is no run
WHILE (iterator_res  < ARRAY_LENGTH(res)) DO
    BEGIN
    DECLARE l_column_list_1 STRING;
    DECLARE l_column_list_2 STRING;
    DECLARE l_column_list_3 STRING;
    DECLARE l_sql STRING;
    SET l_column_list_1  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    SET l_column_list_2  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]')    ;
    SET l_column_list_3  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[2]')    ;
    SET l_sql  =  '''CREATE OR REPLACE VIEW ldl_production_p_lew_mart_msi.v_sec_security_role (security_role_id, security_role_desc, ''' || l_column_list_1 || ''') AS SELECT sro.security_role_id  ,  sro.security_role_desc,  ''' || l_column_list_2 || ''' FROM ldl_production_p_lew_mart_msi.t_sec_sec_role_acl AS sro  INNER JOIN (SELECT ''' || l_column_list_3 || '''   FROM ldl_production_p_lew_mart_msi.v_sec_role_acl_dash_act AS sdx) AS sda ON TRUE ''';
    BEGIN
    DECLARE stmt STRING;
    /* Apply operation */
SET stmt  =  l_column_list_3;

    EXECUTE IMMEDIATE (l_sql);

    SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(STRUCT(l_column_list_1 AS column_list, @@last_job_id AS QueryId))]);
    
    EXCEPTION
    WHEN ERROR THEN
    SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(STRUCT(l_sql AS sql_query, @@error.message AS msg))]);
    END;
    SET iterator_res  =  iterator_res  + 1    ;
    END;
END WHILE;
/* return number of rows applied and query_id */
SET out_param  =  TO_JSON_STRING(l_output);
SELECT out_param;
RETURN;
END;
