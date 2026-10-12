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

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.p_sec_sec_role_acl_update(OUT out_param STRING)
BEGIN
 /* Initialisation */
DECLARE res ARRAY<JSON>;
DECLARE l_output ARRAY<STRING>; 
DECLARE add_dashboard STRUCT<sql STRING>;
DECLARE l_dashboard STRING;
DECLARE l_authorized STRING;
DECLARE l_security_role_desc STRING;
DECLARE l_sql STRING;
DECLARE l_bind ARRAY<STRING>; 
DECLARE stmt STRING;
DECLARE iterator_res INT64 DEFAULT 0;
/* Initialisation */

SET l_output  =  [];
/* Initialisation */

SET add_dashboard  =  STRUCT('''SELECT REPLACE(dashboard_name, " ", "_") AS dashboard_name,  authorized,  security_role_desc FROM p_lew_mart_msi.t_sec_role_acl_load WHERE change_type = "UPDATE_ACCESS"  AND EXISTS (SELECT 1 FROM p_lew_mart_msi.t_sec_role_acl_load   WHERE change_type LIKE "UPDATE_ACCESS") ''' as sql);
/* Select operation */


EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'dashboard_name,authorized,security_role_desc',  add_dashboard.sql)
INTO res ;
-- Loop through the results, processing one row at a time...

WHILE (iterator_res  < ARRAY_LENGTH(res)) DO
    BEGIN
    SET l_dashboard  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    SET l_authorized  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]')    ;
    SET l_security_role_desc  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[2]')    ;
    SET l_sql  =  '''UPDATE p_lew_mart_msi.t_sec_sec_role_acl SET  ''' || l_dashboard || ''' = CAST(@l_authorized AS INTEGER) WHERE security_role_desc = @l_security_role_desc ''';
    
    SET l_bind  =  [CAST(l_authorized AS STRING), CAST(l_security_role_desc AS STRING)]    ;
    /* Apply operation */

    SET stmt  =  l_sql;

    EXECUTE IMMEDIATE (stmt) USING l_authorized AS l_authorized,  l_security_role_desc AS l_security_role_desc;

    /* Pushing execution metadata to output array - Resolved Exception Block */
    SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(STRUCT(l_sql AS sql, @@last_job_id AS QueryId, l_bind AS binds))]);

    SET iterator_res  =  iterator_res  + 1    ;
    END;
END WHILE;
/* return number of rows applied and query_id */

SET out_param  =  TO_JSON_STRING(l_output);
SELECT out_param;
RETURN;
END;