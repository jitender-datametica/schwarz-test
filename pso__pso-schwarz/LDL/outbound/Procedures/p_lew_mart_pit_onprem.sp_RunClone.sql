/*
// ---------------------------------------------------------------------
// PROCEDURE    :   sp_RunClone(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
// Input        :   pTableType              STRING ((All), Tables, Views, Procedures, Functions, Sequences)
//              pSchema                 STRING 
//              pApplicationName        STRING
//              pModuleName             STRING      
//              pRunClusteringDesc      STRING --> [0] running in sequence
//              pSchemaTRG              STRING --> target Schema assuming schemas on the same DB
//              pMaxRuns                INTEGER
// Return       :   Error + Error Msg or in success case number of processed Tables
// Convert      :   None    
// Description  :   Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
//                 Logging is also enables  but must be enabled! 
// Example      :   Call sp_RunClone('P_LEW_MART_PIT_ONPREM');
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_runclone (
    IN PTABLETYPE STRING,
    IN PSCHEMA STRING,
    IN PAPPLICATIONNAME STRING,
    IN PMODULENAME STRING,
    IN PRUNCLUSTERINGDESC STRING,
    IN PSCHEMATRG STRING,
    IN PMAXRUNS FLOAT64,
    IN PLOGGING BOOL,
    OUT OUT_PARAM STRING
)
BEGIN
    DECLARE _rowcnt INT64 DEFAULT 0;
    DECLARE icnt FLOAT64 DEFAULT 0;
    DECLARE imaxruns FLOAT64 DEFAULT 150;
    DECLARE strtabletype STRING DEFAULT 'ALL';
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmt STRING DEFAULT '';
    DECLARE sqlstmtclone STRING DEFAULT '';
    DECLARE _blogging BOOL DEFAULT FALSE;
    DECLARE res ARRAY<JSON>;
    DECLARE iterator_res INT64 DEFAULT 0;
    
    DECLARE col_sf_schema STRING;
    DECLARE col_name_schema STRING;
    DECLARE col_table_type STRING;
    DECLARE col_sf_name STRING;
    DECLARE col_sql_result STRING;
    DECLARE var_out STRING;


    IF PLOGGING IS NULL THEN
        SET _blogging = FALSE;
    ELSE
        SET _blogging = PLOGGING;
    END IF;

    IF PMAXRUNS IS NULL OR SAFE_CAST(PMAXRUNS AS FLOAT64) IS NULL THEN
        SET PMAXRUNS = imaxruns;
    ELSE
        SET imaxruns = PMAXRUNS;
    END IF;

    -- CHECK INPUT runcluster 
    IF PRUNCLUSTERINGDESC IS NULL OR PRUNCLUSTERINGDESC = '' THEN
        SET PRUNCLUSTERINGDESC = strruncluster;
    ELSE
        SET strruncluster = UPPER(PRUNCLUSTERINGDESC);
    END IF;

    -- CHECK INPUT pTableType
    IF PTABLETYPE IS NULL OR PTABLETYPE = '' THEN
        SET PTABLETYPE = strtabletype;
    ELSE
        SET strtabletype = UPPER(PTABLETYPE);
    END IF;

    SET sqlstmt = '''     
        SELECT
              ddl.sf_schema  
            , ddl.name_schema
            , ddl.table_type    
            , ddl.sf_name 
            , ddl.sql_result
            , ddl._dwh_created_ts           
            , COALESCE(vi.view_sortorder, 1) AS _sort_order
        FROM
        (
            SELECT  
                  sf_schema  
                , name_schema
                , UPPER(TRIM(table_type)) AS table_type
                , sf_name 
                , sql_result
                , CAST(dwh_created_ts AS TIMESTAMP) AS _dwh_created_ts
            FROM `p_lew_mart_pit_onprem.t_cntl_dll_result_tmp`
            WHERE TRUE
                AND sf_schema   = '#PSCHEMA#'
                AND sf_name     IS NOT NULL
                AND sf_name     NOT LIKE 'T_PIT_STORE_DAY_ITEM_WAWI_REAGG'
                AND sf_name     NOT LIKE 'V_PIT_AUTOMATED_TESTING_RULES'
                AND sf_name     NOT LIKE '%_TEST'
                AND
                (   
                    '#PTABLETYPE#' = 'ALL' 
                    OR 
                    '#PTABLETYPE#' = UPPER(TRIM(table_type))
                )               
            QUALIFY ROW_NUMBER() OVER (PARTITION BY sf_schema, name_schema, table_type, deleted_fg ORDER BY _dwh_created_ts DESC) = 1
        ) ddl
        
        LEFT JOIN           
        (
            SELECT
                  column1 AS view_sortorder
                , column2 AS view_name
                , 'VIEW'  AS table_type
            FROM UNNEST([
                  STRUCT(1 AS column1, 'V_PIT_PARAM' AS column2)
                , STRUCT(2, 'V_PIT_SCOPE_COUNTRY_INIT')
                , STRUCT(3, 'V_PIT_ADVERT_MEDIUM')
                , STRUCT(4, 'V_PIT_ADVERT_MEDIUM_GRP')
                , STRUCT(5, 'V_PIT_ADVERT_THEME')
                , STRUCT(6, 'V_PIT_ADV_PERIOD')
                , STRUCT(7, 'V_PIT_ADV_WEEK')
                , STRUCT(8, 'V_PIT_ADV_WEEK_PERIOD')
                , STRUCT(9, 'V_PIT_ADV_WEEK_PREV_WEEKS')
                , STRUCT(10, 'V_PIT_ADV_WEEK_RANGES')
                , STRUCT(11, 'V_PIT_ADV_WEEK_RLTD_TYPE')
                , STRUCT(12, 'V_PIT_ADV_WEEK_START')
                , STRUCT(13, 'V_PIT_APT_ANALYTICS_ADVERT_MEDIUM')
                , STRUCT(14, 'V_PIT_APT_BASE_CLIENT_DAY_ITEM')
                , STRUCT(15, 'V_PIT_APT_BASE_CLIENT_DAY_ITEM_DENORM')
                , STRUCT(16, 'V_PIT_APT_BASE_CLIENT_PROMOTIONPERIOD_ITEM_DENORM')
                , STRUCT(17, 'V_PIT_APT_CORE_ITEM_PROMOTION')
                , STRUCT(18, 'V_PIT_APT_CORE_ADVERT_THEME_CLIENT')
                , STRUCT(19, 'V_PIT_APT_CORE_ITEM_PROMOTION_MEDIUM')
                , STRUCT(20, 'V_PIT_APT_CORE_ADVERT_MEDIUM_CLIENT')
                , STRUCT(21, 'V_PIT_ITEM_CLIENT_DAY_HIST')
                , STRUCT(22, 'V_PIT_BASE_ADV_WEEK_ORIG_ITEM')
                , STRUCT(23, 'V_PIT_BASE_CATEGORY_ALL')
                , STRUCT(24, 'V_PIT_BASE_CATEGORY_ITEM')
                , STRUCT(25, 'V_PIT_BASE_MEDIUM_ALL')
                , STRUCT(26, 'V_PIT_BASE_MEDIUM_ITEM')
                , STRUCT(27, 'V_PIT_BASE_PERIOD_ALL')
                , STRUCT(28, 'V_PIT_BASE_PERIOD_ITEM')
                , STRUCT(29, 'V_PIT_BASE_THEME_ALL')
                , STRUCT(30, 'V_PIT_BASE_THEME_ITEM')
                , STRUCT(31, 'V_PIT_DAY_ITEM_STORE_ADV_CNT')
                , STRUCT(32, 'V_PIT_DAY_ITEM_STORE_CNT')
                , STRUCT(33, 'V_PIT_ETL_LOGGING_RUN')
                , STRUCT(34, 'V_PIT_INTEGRAL_SALES_STORE_DAY_ITEM')
                , STRUCT(35, 'V_PIT_ITEMGROUP_INTERNATIONAL')
                , STRUCT(36, 'V_PIT_ITEM_CLIENT_DAY_CURRENT')
                , STRUCT(37, 'V_PIT_ITEM')
                , STRUCT(38, 'V_PIT_ITEM_FAMILYGROUP')
                , STRUCT(39, 'V_PIT_SUBITEMGROUP')
                , STRUCT(40, 'V_PIT_MSI_DRILL_ALL_ITEM')
                , STRUCT(41, 'V_PIT_MSI_DRILL_DETAIL')
                , STRUCT(42, 'V_PIT_MSI_DRILL_MEDIUM')
                , STRUCT(43, 'V_PIT_MSI_DRILL_THEME')
                , STRUCT(44, 'V_PIT_MSI_DRILL_UWG')
                , STRUCT(45, 'V_PIT_MSI_DRILL_UWG_ITEM')
                , STRUCT(46, 'V_PIT_PV_SALES_STORE_DAY_ITEM')
                , STRUCT(47, 'V_PIT_REPORTS_TOC')
                , STRUCT(48, 'V_PIT_SCOPE_COUNTRY_INIT')
                , STRUCT(49, 'V_PIT_SCOPE_COUNTRY_PARAM')
                , STRUCT(50, 'V_PIT_SCOPE_COUNTRY_PARAM_COUNTRY')
                , STRUCT(51, 'V_PIT_SCOPE_COUNTRY_PARAM_LOG')
                , STRUCT(52, 'V_PIT_STORE_DAY_ITEM_PV')
                , STRUCT(53, 'V_PIT_VERSION_INFO')
                , STRUCT(54, 'V_PIT_WEEK_ITEM_PERIOD_PV')
                , STRUCT(55, 'V_PIT_WTD_ADV_WEEK')
            ])
        ) vi
        ON TRUE 
            AND ddl.table_type  = vi.table_type
            AND ddl.sf_name     = vi.view_name
        
        ORDER BY ddl.table_type, _sort_order, ddl._dwh_created_ts 
        
    ''';

    -- Variable Substitution
    SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMA#', LOWER(PSCHEMA));
    SET sqlstmt = REPLACE(sqlstmt, '#PTABLETYPE#', UPPER(PTABLETYPE));

    -- Retrieve from all uses tables
    BEGIN
        EXECUTE IMMEDIATE CONCAT('SELECT ARRAY_AGG(JSON_ARRAY(sf_schema, name_schema, table_type, sf_name, sql_result)) FROM (', sqlstmt, ')') INTO res;
    EXCEPTION WHEN ERROR THEN
        SET msg = CONCAT('P_RUNCLONE: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
        RAISE USING MESSAGE = msg;
    END;

    SET _rowcnt = ARRAY_LENGTH(res);

    IF _blogging IS TRUE THEN
        BEGIN
            CALL p_lew_mart_pit_onprem.sp_startmodulelogging(
                PAPPLICATIONNAME,
                PMODULENAME,
                strruncluster,
                p_lew_mart_pit_onprem.querytag(PAPPLICATIONNAME, PMODULENAME, NULL),
                var_out
            );
        EXCEPTION WHEN ERROR THEN
            SET msg = CONCAT('P_RUNCLONE: sp_startmodulelogging FAILED MESSAGE: ', @@error.message);
            RAISE USING MESSAGE = msg;
        END;
    END IF;

    SET iterator_res = 0;
    SET icnt = 0;

    WHILE (iterator_res < COALESCE(_rowcnt, 0) AND icnt < imaxruns) DO
        BEGIN
            SET col_sf_schema = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');
            SET col_name_schema = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]');
            SET col_table_type = UPPER(JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[2]'));
            SET col_sf_name = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[3]');
            SET col_sql_result = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[4]');

            SET sqlstmt = '';
            IF col_table_type = 'TABLE' OR col_table_type = 'SEQUENCE' OR col_table_type = 'VIEW' THEN
                SET sqlstmt = 'DROP #TABLE_TYPE# IF EXISTS #PSCHEMATRG#.#SF_NAME#;';
            END IF;

            -- Variable Substitution
            SET sqlstmt = REPLACE(sqlstmt, '#TABLE_TYPE#', col_table_type);
            SET sqlstmt = REPLACE(sqlstmt, '#PSCHEMATRG#', LOWER(PSCHEMATRG));
            SET sqlstmt = REPLACE(sqlstmt, '#SF_NAME#', LOWER(col_sf_name));

            SET sqlstmtclone = '';
            IF col_table_type = 'TABLE' OR col_table_type = 'SEQUENCE' THEN
                SET sqlstmtclone = 'CREATE #TABLE_TYPE# IF NOT EXISTS #PSCHEMATRG#.#SF_NAME# CLONE #PSCHEMA#.#SF_NAME#;';
            ELSEIF col_table_type = 'VIEW' OR col_table_type = 'FUNCTION' THEN
                SET sqlstmtclone = col_sql_result;
            ELSE
                SET sqlstmtclone = 'SELECT CURRENT_DATE("Europe/Berlin");';
            END IF;

            -- Variable Substitution
            SET sqlstmtclone = REPLACE(sqlstmtclone, '#PSCHEMA#', LOWER(PSCHEMA));
            SET sqlstmtclone = REPLACE(sqlstmtclone, '#PSCHEMATRG#', LOWER(PSCHEMATRG));
            SET sqlstmtclone = REPLACE(sqlstmtclone, '#TABLE_TYPE#', col_table_type);
            SET sqlstmtclone = REPLACE(sqlstmtclone, '#SF_NAME#', LOWER(col_sf_name));
            SET sqlstmtclone = REPLACE(sqlstmtclone, '#SQL_RESULT#', LOWER(col_sql_result));

            SET sqlstmtclone = REPLACE(sqlstmtclone, 'CREATE OR REPLACE VIEW ', CONCAT('CREATE OR REPLACE VIEW ', LOWER(PSCHEMATRG), '.'));
            SET sqlstmtclone = REPLACE(sqlstmtclone, 'CREATE OR REPLACE FUNCTION ', CONCAT('CREATE OR REPLACE FUNCTION ', LOWER(PSCHEMATRG), '.'));

            IF _blogging IS TRUE THEN
                BEGIN
                    CALL p_lew_mart_pit_onprem.sp_startcomponentlogging(
                        PAPPLICATIONNAME,
                        PMODULENAME,
                        CONCAT(col_table_type, ' - ', col_sf_name),
                        strruncluster,
                        p_lew_mart_pit_onprem.querytag(PAPPLICATIONNAME, PMODULENAME, NULL),
                        var_out
                    );
                EXCEPTION WHEN ERROR THEN
                    SET msg = CONCAT('P_RunClone: sp_startcomponentlogging FAILED MESSAGE: ', @@error.message);
                    RAISE USING MESSAGE = msg;
                END;
            END IF;

            BEGIN
                IF col_table_type = 'TABLE' OR col_table_type = 'SEQUENCE' OR col_table_type = 'VIEW' THEN
                    EXECUTE IMMEDIATE sqlstmt;
                END IF;
                
                IF col_table_type = 'TABLE' OR col_table_type = 'VIEW' OR col_table_type = 'FUNCTION' THEN
                    EXECUTE IMMEDIATE sqlstmtclone;
                END IF;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('P_RunClone: [', sqlstmtclone, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            IF _blogging IS TRUE THEN
                BEGIN
                    CALL p_lew_mart_pit_onprem.sp_endcomponentlogging(
                        PAPPLICATIONNAME,
                        PMODULENAME,
                        CONCAT(col_table_type, ' - ', col_sf_name),
                        strruncluster,
                        '1',
                        var_out
                    );
                EXCEPTION WHEN ERROR THEN
                    SET msg = CONCAT('P_RunClone: sp_endcomponentlogging FAILED MESSAGE: ', @@error.message);
                    RAISE USING MESSAGE = msg;
                END;
            END IF;

            SET icnt = icnt + 1;
            SET iterator_res = iterator_res + 1;
        END;
    END WHILE;

    IF _blogging IS TRUE THEN
        BEGIN
            CALL p_lew_mart_pit_onprem.sp_endmodulelogging(
                PAPPLICATIONNAME,
                PMODULENAME,
                strruncluster,
                var_out
            );
        EXCEPTION WHEN ERROR THEN
            SET msg = CONCAT('P_RUNCLONE: sp_endmodulelogging FAILED MESSAGE: ', @@error.message);
            RAISE USING MESSAGE = msg;
        END;
    END IF;

    SET OUT_PARAM = CAST(COALESCE(_rowcnt, 0) AS STRING);
END;