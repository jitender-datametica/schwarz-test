/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2021
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_RunDDLBackup
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#-------------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_runddlbackup (
    IN PTABLETYPE STRING, 
    IN PSCHEMA STRING, 
    IN PAPPLICATIONNAME STRING, 
    IN PMODULENAME STRING, 
    IN PRUNCLUSTERINGDESC STRING, 
    IN PMAXRUNS FLOAT64, 
    IN PLOGGING BOOL,
    OUT OUT_PARAM STRING
)
BEGIN

-- ---------------------------------------------------------------------
-- PROCEDURE  : sp_RunDDLBackup(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
-- Input    :   pTableType        STRING ((All), Tables, Views, Procedures, Functions, Sequences)
--        pSchema         STRING 
--        pApplicationName    STRING
--        pModuleName       STRING    
--          pRunClusteringDesc      STRING --> [0] running in sequence
--          pMaxRuns        INTEGER
-- Return   : Error + Error Msg or in success case number of processed Tables
-- Convert    : None    
-- Description  :   Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
--                 Logging is also enables  but must be enabled! 
-- Example    : Call sp_RunDDLBackup('P_LEW_MART_PIT_ONPREM');
-- ------------------------------------------------------------------------
-- # History:
-- #  1.0  2021-07-01 Andreas Kurz    Initial version

    DECLARE _rowcnt INT64 DEFAULT 0;
    DECLARE icnt INT64 DEFAULT 0;
    DECLARE imaxruns INT64 DEFAULT 150;
    DECLARE strtabletype STRING DEFAULT 'ALL';
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE sqlcode INT64 DEFAULT 0;
    DECLARE sqlstate STRING DEFAULT '00000';
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmtlogstart STRING DEFAULT '';
    DECLARE sqlstmtlogend STRING DEFAULT '';
    DECLARE sqlstmt STRING DEFAULT '';
    DECLARE _blogging BOOL;
    DECLARE res ARRAY<JSON>;
    DECLARE iterator_res INT64 DEFAULT 0;
    DECLARE out_param_1 STRING;
    IF PLOGGING IS NULL THEN
        SET _blogging = FALSE;
    ELSE
        SET _blogging = PLOGGING;
    END IF;
    
    IF PMAXRUNS IS NULL THEN 
        SET PMAXRUNS = imaxruns; 
    ELSE
        SET imaxruns = CAST(PMAXRUNS AS INT64);
    END IF;
    
    -- CHECK INPUT runcluster 
    IF PRUNCLUSTERINGDESC = '' OR PRUNCLUSTERINGDESC IS NULL THEN 
        SET PRUNCLUSTERINGDESC = strruncluster; 
    ELSE
        SET strruncluster = UPPER(PRUNCLUSTERINGDESC);
    END IF; 
    
    -- CHECK INPUT pTableType
    IF PTABLETYPE = '' OR PTABLETYPE IS NULL THEN 
        SET PTABLETYPE = strtabletype; 
    ELSE
        SET strtabletype = UPPER(PTABLETYPE);
    END IF;

    SET sqlstmt = '';
    SET sqlstmt = """
      SELECT 
        /* Extract Tables */
        CONCAT(table_schema, '.', table_name)  AS name_schema
        , table_name  AS sf_name
        , 'Table' AS _table_type
        , CONCAT("(SELECT ddl FROM `#PSCHEMA#`.INFORMATION_SCHEMA.TABLES WHERE table_name = '", table_name, "')") AS sql_getddl
        , CONCAT("DESC TABLE ", table_schema, '.', table_name, ";") AS sql_describe
        , CONCAT("DROP TABLE IF EXISTS ", table_schema, '.', table_name, ";") AS sql_drop         
        , "-1"  AS recnbr
        , "" AS owner
        , "" AS comment
        , CAST(creation_time AS STRING) AS dwh_created_ts
        , CONCAT("Last altered  TS: ", CAST(creation_time AS STRING)) AS annotation
      FROM `#PSCHEMA#`.INFORMATION_SCHEMA.TABLES 
      WHERE TRUE 
        AND table_type = 'BASE TABLE'
        AND UPPER(table_name)   LIKE 'T_%' 
        AND NOT
        (   
          UPPER(table_name)   LIKE 'TT%' 
          OR UPPER(table_name) LIKE '%_TMP'
          OR UPPER(table_name) LIKE '%_TEST'          
          OR UPPER(table_name) LIKE '@%'
          OR UPPER(table_name) LIKE 'T_PIT_STORE_DAY_ITEM_WAWI_REAGG'         
        )
        AND
        ( 
          '#PTABLETYPE#' = 'ALL' 
          OR '#PTABLETYPE#' = 'TABLE'
        )
        
      UNION ALL
      
        /* Extract Views */
      SELECT 
        CONCAT(table_schema, '.', table_name)  AS name_schema
        , table_name  AS sf_name
        , 'View' AS _table_type
        , CONCAT("(SELECT ddl FROM `#PSCHEMA#`.INFORMATION_SCHEMA.TABLES WHERE table_name = '", table_name, "')") AS sql_getddl
        , CONCAT("DESC VIEW ", table_schema, '.', table_name, ";") AS sql_describe 
        , CONCAT("DROP VIEW IF EXISTS ", table_schema, '.', table_name, ";") AS sql_drop
        , "-1"  AS recnbr
        , "" AS owner 
        , "" AS comment
        , CAST(creation_time AS STRING) AS dwh_created_ts
        , CONCAT("Last altered  TS: ", CAST(creation_time AS STRING)) AS annotation
      FROM `#PSCHEMA#`.INFORMATION_SCHEMA.TABLES 
      WHERE TRUE 
        AND table_type = 'VIEW'
        AND UPPER(table_name)   LIKE 'V_%' 
        AND UPPER(table_name)   NOT LIKE 'TT%' 
        AND UPPER(table_name)   NOT LIKE '%_TMP'
        AND UPPER(table_name)   NOT LIKE 'V_PIT_AUTOMATED_TESTING_RULES'
        AND UPPER(table_name)   NOT LIKE '@%'         
        AND 
        ( 
          '#PTABLETYPE#' = 'ALL' 
          OR '#PTABLETYPE#' = 'VIEW'
        )
        
      UNION ALL
      
      SELECT 
        /* Extract Functions */                   
        CONCAT(routine_schema, '.', routine_name)  AS name_schema
        , routine_name  AS sf_name
        , 'Function' AS _table_type
        , CONCAT("(SELECT ddl FROM `#PSCHEMA#`.INFORMATION_SCHEMA.ROUTINES WHERE routine_name = '", routine_name, "')") AS sql_getddl
        , CONCAT("DESC FUNCTION ", routine_schema, '.', routine_name, ";") AS sql_describe  
        , CONCAT("DROP FUNCTION IF EXISTS ", routine_schema, '.', routine_name, ";") AS sql_drop
        , "-1"  AS recnbr
        , "" AS owner 
        , "" AS comment
        , CAST(created AS STRING) AS dwh_created_ts
        , CONCAT("Last altered  TS: ", CAST(last_altered AS STRING), "| Function Language: ", IFNULL(routine_type, ''), "| Function Return Data Type: ", IFNULL(data_type, '')) AS annotation       
      FROM `#PSCHEMA#`.INFORMATION_SCHEMA.ROUTINES
      WHERE TRUE 
        AND routine_type = 'FUNCTION'
        AND UPPER(routine_name)    NOT LIKE 'TT%'         
        AND UPPER(routine_name)   NOT LIKE '%_TMP'  
        AND UPPER(routine_name)   NOT LIKE '@%' 
        AND
        ( 
          '#PTABLETYPE#' = 'ALL' 
          OR '#PTABLETYPE#' = 'FUNCTION'
        )
        
      UNION ALL
      
      SELECT 
        /* Extract Procedures */
        CONCAT(routine_schema, '.', routine_name)  AS name_schema
        , routine_name  AS sf_name
        , 'Procedure' AS _table_type
        , CONCAT("(SELECT ddl FROM `#PSCHEMA#`.INFORMATION_SCHEMA.ROUTINES WHERE routine_name = '", routine_name, "')") AS sql_getddl
        , CONCAT("DESC PROCEDURE ", routine_schema, '.', routine_name, ";") AS sql_describe 
        , CONCAT("DROP PROCEDURE IF EXISTS ", routine_schema, '.', routine_name, ";") AS sql_drop
        , "-1"  AS recnbr            
        , "" AS owner 
        , "" AS comment
        , CAST(created AS STRING) AS dwh_created_ts
        , CONCAT("Last altered  TS: ", CAST(last_altered AS STRING), "| Procedure Language: ", IFNULL(routine_type, ''), "| Procedure Return Data Type: ", IFNULL(data_type, '')) AS annotation                    
      FROM `#PSCHEMA#`.INFORMATION_SCHEMA.ROUTINES
      WHERE TRUE 
        AND routine_type = 'PROCEDURE'
        AND UPPER(routine_name)    NOT LIKE 'TT%'
        AND UPPER(routine_name)   NOT LIKE '%_TMP'
        AND UPPER(routine_name)   NOT LIKE '@%'           
        AND
        ( 
          '#PTABLETYPE#' = 'ALL' 
          OR '#PTABLETYPE#' = 'PROCEDURE'
        )       
        
      UNION ALL
        
      SELECT 
          /* Extract Sequence (Mapped to dummy fallback as Sequences are handled differently in BQ) */
        CONCAT('#PSCHEMA#', '.dummy_sequence')  AS name_schema
        , 'dummy_sequence'  AS sf_name
        , 'Sequence' AS _table_type
        , CONCAT("( '' AS ddl)") AS sql_getddl
        , CONCAT("DESC SEQUENCE ", '#PSCHEMA#', '.dummy_sequence', ";") AS sql_describe 
        , CONCAT("DROP SEQUENCE IF EXISTS ", '#PSCHEMA#', '.dummy_sequence', ";") AS sql_drop
        , "-1"  AS recnbr            
        , "" AS owner 
        , "" AS comment
        , CAST(CURRENT_TIMESTAMP() AS STRING) AS dwh_created_ts
        , CONCAT("Last altered  TS: ", CAST(CURRENT_TIMESTAMP() AS STRING)) AS annotation 
      FROM (SELECT 1)
      WHERE FALSE
          AND
        ( 
          '#PTABLETYPE#' = 'ALL' 
          OR '#PTABLETYPE#' = 'SEQUENCE'
        )
    """;
    
    -- Variable Substitution
    SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(PSCHEMA));
    SET sqlstmt = REPLACE(sqlstmt, '#PTABLETYPE#', strtabletype);
    
    -- Retrieve from all uses tables
    BEGIN
        -- Changed FORMAT to CONCAT to avoid dynamic SQL failing when seeing % wildcards in the query
        EXECUTE IMMEDIATE CONCAT(
            'SELECT ARRAY_AGG(JSON_ARRAY(name_schema, sf_name, _table_type, sql_getddl, sql_describe, sql_drop, recnbr, owner, comment, dwh_created_ts, annotation)) ',
            'FROM (', sqlstmt, ')'
        ) INTO res;
    EXCEPTION WHEN ERROR THEN
        SET msg = CONCAT('p_runddlbackup: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
        RAISE USING MESSAGE = msg;
    END;

    -- Loop all results
    SET _rowcnt = IFNULL(ARRAY_LENGTH(res), 0);


    
    WHILE (iterator_res < IFNULL(ARRAY_LENGTH(res), 0) AND icnt < imaxruns) DO
        BEGIN
            DECLARE col1_nameschema STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');
            DECLARE col2_sfname STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]');
            DECLARE col3_tabletype STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[2]');
            DECLARE col4_sqlgetddl STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[3]');
            DECLARE col5_sqldescribe STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[4]');
            DECLARE col6_sqldrop STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[5]');
            DECLARE col7_recnbr STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[6]');
            DECLARE col8_owner STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[7]');
            DECLARE col9_comment STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[8]');
            DECLARE col10_dwhcreatedts STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[9]');
            DECLARE col11_annotation STRING DEFAULT JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[10]');
            
            SET sqlstmt = '';
            SET sqlstmt = """
        INSERT INTO p_lew_mart_pit_onprem.t_cntl_dll_result_tmp
        (
              sf_schema             
          , name_schema     
          , table_type  
          , sf_name
          , owner 
          , recnbr
          , description
          , created_ts
          , annotation
          , sql_getddl        
          , sql_describe      
          , sql_drop          
          , sql_result
        ) 
        SELECT
            "#PSCHEMA#"           AS sf_schema
          , "#FILE#"            AS name_schema
          , "#TYPE#"            AS table_type
          , "#SF_NAME#"         AS sf_name
          , "#OWNER#"           AS owner
          , CAST(#ROW_COUNT# AS STRING)             AS recnbr
          , "#COMMENT#"           AS description
          , "#DWH_CREATED_TS#"      AS created_ts
          , "#ANNOTATION#"        AS annotation
          , CONCAT('SELECT ', "#GETDDL#") AS sql_getddl 
          , "#DESCRIBE#"          AS sql_describe
          , "#DROP#"            AS sql_drop
          , REGEXP_REPLACE(
            UPPER(#SQL_CMD#)
            ,"#PSCHEMA#.","")       AS sql_result
      """;
    
            -- Variable Substitution - Using safe double quote escaping internally for valid SQL concatenation.
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', UPPER(PSCHEMA));      
            SET sqlstmt = REPLACE(sqlstmt, '#FILE#', REPLACE(UPPER(col1_nameschema), '"', '\\"'));
            SET sqlstmt = REPLACE(sqlstmt, '#TYPE#', REPLACE(UPPER(col3_tabletype), '"', '\\"'));     
            SET sqlstmt = REPLACE(sqlstmt, '#SF_NAME#', REPLACE(UPPER(col2_sfname), '"', '\\"'));   
            SET sqlstmt = REPLACE(sqlstmt, '#OWNER#', REPLACE(UPPER(col8_owner), '"', '\\"'));
            SET sqlstmt = REPLACE(sqlstmt, '#ROW_COUNT#', col7_recnbr);
            SET sqlstmt = REPLACE(sqlstmt, '#COMMENT#', REPLACE(UPPER(col9_comment), '"', '\\"'));
            SET sqlstmt = REPLACE(sqlstmt, '#ANNOTATION#', REPLACE(UPPER(col11_annotation), '"', '\\"'));     
            SET sqlstmt = REPLACE(sqlstmt, '#DWH_CREATED_TS#', REPLACE(UPPER(col10_dwhcreatedts), '"', '\\"'));
            SET sqlstmt = REPLACE(sqlstmt, '#GETDDL#', REPLACE(UPPER(col4_sqlgetddl), '"', '\\"'));   
            SET sqlstmt = REPLACE(sqlstmt, '#DESCRIBE#', REPLACE(UPPER(col5_sqldescribe), '"', '\\"'));
            SET sqlstmt = REPLACE(sqlstmt, '#DROP#', REPLACE(UPPER(col6_sqldrop), '"', '\\"'));   
            SET sqlstmt = REPLACE(sqlstmt, '#SQL_CMD#', col4_sqlgetddl);              
        
            SET sqlstmtlogstart = CONCAT("CALL sp_startcomponentlogging('", PAPPLICATIONNAME, "','", PMODULENAME, "','", col2_sfname, " - ", col1_nameschema, "', '", strruncluster, "', p_lew_mart_pit_onprem.querytag('", PAPPLICATIONNAME, "','", PMODULENAME, "', NULL));");

            SET sqlstmtlogend = CONCAT("CALL sp_endcomponentlogging('", PAPPLICATIONNAME, "','", PMODULENAME, "','", col2_sfname, " - ", col1_nameschema, "', '", strruncluster, "', '1');");
  
            IF _blogging IS TRUE THEN
                BEGIN
                    -- Call sp_startcomponentlogging directly since dynamic execute immediate for CALL is requested to be natively executed
                    CALL p_lew_mart_pit_onprem.sp_startcomponentlogging(PAPPLICATIONNAME, PMODULENAME, CONCAT(col2_sfname, ' - ', col1_nameschema), strruncluster, p_lew_mart_pit_onprem.querytag(PAPPLICATIONNAME, PMODULENAME, NULL),out_param_1);
                EXCEPTION WHEN ERROR THEN
                    SET msg = CONCAT('p_runddlbackup: sp_startcomponentlogging FAILED MESSAGE: ', @@error.message);
                    RAISE USING MESSAGE = msg;
                END;
            END IF;

            BEGIN
                EXECUTE IMMEDIATE sqlstmt;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('p_runddlbackup: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            IF _blogging IS TRUE THEN
                BEGIN
                    -- Call sp_endcomponentlogging directly
                    CALL p_lew_mart_pit_onprem.sp_endcomponentlogging(PAPPLICATIONNAME, PMODULENAME, CONCAT(col2_sfname, ' - ', col1_nameschema), strruncluster, '1',out_param_1);
                EXCEPTION WHEN ERROR THEN
                    SET msg = CONCAT('p_runddlbackup: sp_endcomponentlogging FAILED MESSAGE: ', @@error.message);
                    RAISE USING MESSAGE = msg;
                END;
            END IF; 
            
            SET icnt = icnt + 1;
            SET iterator_res = iterator_res + 1;
            
        END;
    END WHILE; 

    BEGIN
        
    EXCEPTION WHEN ERROR THEN
        SET msg = CONCAT('p_runddlbackup: [COMMIT] SQLSTATE: FAILED MESSAGE: ', @@error.message);
        RAISE USING MESSAGE = msg;
    END;
    
    SET OUT_PARAM = CAST(COALESCE(_rowcnt, 0) AS STRING);
END;


