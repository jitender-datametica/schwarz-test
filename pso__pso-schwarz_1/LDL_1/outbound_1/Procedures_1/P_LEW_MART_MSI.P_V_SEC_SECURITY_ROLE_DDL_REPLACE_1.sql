
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

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.p_v_sec_security_role_ddl_replace(OUT out_param STRING)
BEGIN
DECLARE res ARRAY<JSON>;
DECLARE l_output ARRAY<STRING>;
DECLARE add_dashboard STRUCT<sql STRING>;
DECLARE l_column_list_1 STRING;
DECLARE l_column_list_2 STRING;
DECLARE l_column_list_3 STRING;
DECLARE l_sql STRING;
DECLARE stmt STRING;
DECLARE iterator_res INT64 DEFAULT 0;
/* Initialisation */

SET l_output  =  [];
/* Initialisation */

SET add_dashboard  =  STRUCT('''WITH CTE_DASH AS (SELECT DISTINCT dashboard_name,    RANK() OVER (ORDER BY dashboard_name IS NULL, dashboard_name) AS dashboard_id   FROM p_lew_mart_msi.t_sec_role_acl_dash_act_1   WHERE EXISTS (SELECT 1     FROM p_lew_mart_msi.t_sec_role_acl_load_1     WHERE change_type LIKE "ADD_DASHBOARD"      OR change_type LIKE "DELETE_DASHBOARD")), CTE_LIST AS (SELECT STRING_AGG(dashboard_name, ",\\n" ORDER BY      dashboard_id IS NULL, dashboard_id) AS column_list_1,    STRING_AGG("CASE WHEN sda." || dashboard_name || " = 1 THEN sro." || dashboard_name || " ELSE 0 END AS " ||      dashboard_name, ",\\n" ORDER BY dashboard_id IS NULL, dashboard_id) AS column_list_2,    STRING_AGG("MAX(CASE WHEN dashboard_name = '" || dashboard_name || "' THEN dashboard_active_fg ELSE 0 END) AS "        || dashboard_name, ",\\n" ORDER BY dashboard_id IS NULL, dashboard_id) AS column_list_3   FROM CTE_DASH) SELECT column_list_1,    column_list_2,    column_list_3   FROM CTE_LIST WHERE IFNULL(column_list_1, "") <> "" ''' as sql);
/* Select operation */


EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'column_list_1,column_list_2,column_list_3',  add_dashboard.sql)
INTO res ;

WHILE (iterator_res  < ARRAY_LENGTH(res)) DO
    BEGIN
    SET l_column_list_1  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    SET l_column_list_2  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]')    ;
    SET l_column_list_3  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[2]')    ;
    
   
    SET l_sql  =  CONCAT('CREATE OR REPLACE VIEW p_lew_mart_msi.v_sec_security_role_1\n(\nsecurity_role_id,\nsecurity_role_desc,\n', l_column_list_1, '\n)\nAS\nSELECT\nsro.security_role_id,\nsro.security_role_desc,\n', l_column_list_2, '\nFROM p_lew_mart_msi.t_sec_sec_role_acl_1 sro \nCROSS JOIN (SELECT\n', l_column_list_3, '\nFROM p_lew_mart_msi.v_sec_role_acl_dash_act_1 sdx ) sda\n');
    
    BEGIN
    /* Apply operation */
    SET stmt  =  l_sql;

    EXECUTE IMMEDIATE (stmt);
    
    SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(JSON_OBJECT('column_list', l_column_list_1, 'QueryId', 'N/A'))]);
    
    EXCEPTION
    WHEN ERROR THEN
    
    SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(JSON_OBJECT('sql', l_sql, 'msg', @@error.message))]);

    END;
    SET iterator_res  =  iterator_res  + 1    ;
    END;
END WHILE;
/* return number of rows applied and query_id */

SET out_param  =  CONCAT('[', ARRAY_TO_STRING(l_output, ','), ']');
SELECT out_param;
RETURN;
END;

