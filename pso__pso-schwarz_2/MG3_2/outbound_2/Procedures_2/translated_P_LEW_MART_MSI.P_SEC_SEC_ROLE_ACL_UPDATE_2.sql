
CREATE OR REPLACE PROCEDURE ldl_production_p_lew_mart_msi.p_sec_sec_role_acl_update(OUT out_param STRING)
BEGIN
DECLARE res ARRAY<JSON>;
DECLARE l_output ARRAY<STRING(16777216)>;
DECLARE add_dashboard STRUCT<sql STRING>;
DECLARE iterator_res INT64 DEFAULT -1;
/* Initialisation */
SET l_output  =  [];
/* Initialisation */
SET add_dashboard  =  STRUCT('''SELECT REPLACE(dashboard_name, " ", "_") AS dashboard_name,  authorized,  security_role_desc FROM ldl_production_p_lew_mart_msi.t_sec_role_acl_load_2 WHERE change_type = "UPDATE_ACCESS"  AND EXISTS (SELECT 1   FROM ldl_production_p_lew_mart_msi.t_sec_role_acl_load_2   WHERE change_type LIKE "UPDATE_ACCESS") ''' as sql);
/* Select operation */

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'dashboard_name,authorized,security_role_desc',  add_dashboard.sql)
INTO res ;
-- Loop through the results, processing one row at a time...
WHILE (iterator_res  < ARRAY_LENGTH(res)) DO
    BEGIN
    DECLARE l_dashboard STRING;
    DECLARE l_authorized STRING;
    DECLARE l_security_role_desc STRING;
    DECLARE l_sql STRING;
    DECLARE l_bind ARRAY<STRING>;
    DECLARE stmt STRING;
    SET l_dashboard  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    SET l_authorized  = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]')    ;
    SET l_security_role_desc  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[2]')    ;
--     SET l_dashboard  =  'security_role_id';
-- SET l_authorized  =  '1';
-- SET l_security_role_desc='security_role_desc';
    SET l_sql  =  "UPDATE ldl_production_p_lew_mart_msi.t_sec_sec_role_acl_2 SET " ||l_dashboard|| " = @l_authorized WHERE security_role_desc = @l_security_role_desc ";
    SET l_bind  =  [l_authorized, CAST(l_security_role_desc AS STRING)]    ;
    /* Apply operation */
EXECUTE IMMEDIATE l_sql USING CAST(l_bind[OFFSET(0)] AS INT64) AS l_authorized, l_bind[OFFSET(1)] AS l_security_role_desc;

SET l_output = ARRAY_CONCAT(l_output, [
        FORMAT('{"sql": "%s", "binds": ["%s", "%s"]}', 
        l_sql, l_bind[OFFSET(0)], l_bind[OFFSET(1)])
    ]);

    SET iterator_res  =  iterator_res  + 1    ;
    END;
END WHILE;
/* return number of rows applied and query_id */
SET out_param  =  FORMAT('[%s]', ARRAY_TO_STRING(l_output, ','));
SELECT out_param;
RETURN;
END;