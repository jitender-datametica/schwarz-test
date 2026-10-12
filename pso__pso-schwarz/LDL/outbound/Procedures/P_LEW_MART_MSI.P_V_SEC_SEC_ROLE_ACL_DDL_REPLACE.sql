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

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.p_v_sec_sec_role_acl_ddl_replace(OUT out_param STRING)
BEGIN
DECLARE res ARRAY<JSON>;
DECLARE l_output ARRAY<STRING(16777216)>;
DECLARE add_dashboard STRUCT<sql STRING>;
DECLARE l_column_list STRING;
DECLARE l_sql STRING;
DECLARE stmt STRING;
DECLARE iterator_res INT64 DEFAULT -1;
/* Initialisation */

SET l_output  =  [];
/* Initialisation */

SET add_dashboard  =  STRUCT('''
WITH
cte_dash AS (
    SELECT 
     column_name
    ,ordinal_position
    -- BQ requires the dataset prefix before INFORMATION_SCHEMA
    FROM p_lew_mart_msi.INFORMATION_SCHEMA.COLUMNS 
    WHERE table_name = "v_sec_security_role"
    AND EXISTS (
        SELECT 1 
        FROM p_lew_mart_msi.t_sec_role_acl_load
        WHERE 
        (
        change_type LIKE "ADD_DASHBOARD"
        OR 
        change_type LIKE "DELETE_DASHBOARD"
        )
    )
)
                        ,cte_list AS (
                            SELECT
                            STRING_AGG(column_name,  ',\\n' ORDER BY ordinal_position) AS column_list
                            FROM cte_dash
                        )                            
                        SELECT 
                        *
                        FROM cte_list
                        WHERE 
                        column_list <> "" ''' as sql);
/* Select operation */


EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'column_list',  add_dashboard.sql)
INTO res ;
-- if no data there is no run

WHILE (iterator_res  < ARRAY_LENGTH(res)) DO
    BEGIN
    SET l_column_list  =  JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]')    ;
    SET l_sql  =  '''CREATE OR REPLACE VIEW p_lew_mart_msi.v_sec_sec_role_acl 
(
''' || l_column_list || '''
)
AS 
SELECT 
''' || l_column_list || '''
FROM p_lew_mart_msi.v_sec_security_role
''';
    
    BEGIN
        /* Apply operation */
        SET stmt  =  l_sql;

        EXECUTE IMMEDIATE (stmt);

        SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(STRUCT(@@last_job_id AS QueryId))]);
        
    EXCEPTION WHEN ERROR THEN
        SET l_output = ARRAY_CONCAT(l_output, [TO_JSON_STRING(STRUCT(l_sql AS sql, @@error.message AS msg))]);
    END;

    SET iterator_res  =  iterator_res  + 1    ;
    END;
END WHILE;
/* return number of rows applied and query_id */

SET out_param  =  TO_JSON_STRING(l_output);
SELECT out_param;
RETURN;
END;