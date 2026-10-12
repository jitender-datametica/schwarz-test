/*
-- // ---------------------------------------------------------------------
-- // PROCEDURE	:	sp_RunBFExecutionWrapper(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING)
-- // Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
-- // 				pSchema 				STRING
-- // 				pApplicationName 		STRING
-- // 				pModuleName 			STRING 		
-- //     			pRunClusteringDesc    	STRING --> [0] running in sequence
-- // Return		:	Error + Error Msg or in success case number of processed Tables
-- // Convert		:	None    
-- // Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
-- //                 Logging is also enables  but must be enabled! 
-- // Example		:	CALL P_LEW_MART_PIT_ONPREM.sp_RunPrepareAutoRun (4,'P_LEW_MART_PIT_ONPREM', '2021-07-30','2021-09-01',202130,202135);
-- // ------------------------------------------------------------------------
-- // # History:
-- // #  1.0  2021-07-01 Andreas Kurz    	Initial version
-- // #  1.3  2021-11-08 Andreas Kurz		Added additional logging
*/

CREATE OR REPLACE PROCEDURE ldl_p_lew_mart_pit_onprem.sp_runprepareautorun (
    pSchema STRING,
    pPitManualRunFg FLOAT64,
    pCntAdvWeekReagg FLOAT64,
    pAPTPeriodOnlyFg FLOAT64,
    pRestrictActionTypeList STRING,
    pApplicationName STRING,
    pModuleName STRING,
    pRunClusteringDesc STRING
)
BEGIN
    DECLARE v_row_cnt INT64 DEFAULT 0;
    DECLARE msg STRING DEFAULT '';
    DECLARE iMaxRunsAdvWeek INT64 DEFAULT 150;
    DECLARE strRunCluster STRING DEFAULT '[0]';
    DECLARE sqlStmt STRING DEFAULT '';
    DECLARE v_CntAdvWeekReagg FLOAT64;
    DECLARE v_ProcArgs STRING;
    
    
    DECLARE v_out_log_result STRING DEFAULT ''; 
    DECLARE v_log_app STRING DEFAULT '';
    DECLARE v_log_mod STRING DEFAULT '';
    DECLARE v_log_querytag STRING DEFAULT '';

    
    IF (pPitManualRunFg IS NULL OR pPitManualRunFg NOT IN (0, 3)) THEN 
        RAISE USING MESSAGE = 'Missing parameter pPitManualRunFg or not a number: Mandatory Parameter must be in (0,3)';
    END IF;

    IF (pCntAdvWeekReagg IS NULL OR pCntAdvWeekReagg < 1 OR pCntAdvWeekReagg > iMaxRunsAdvWeek) THEN 
        SET v_CntAdvWeekReagg = iMaxRunsAdvWeek;
    ELSE
        SET v_CntAdvWeekReagg = pCntAdvWeekReagg;
    END IF;

    IF (pRestrictActionTypeList IS NULL OR pRestrictActionTypeList = '') THEN 
        RAISE USING MESSAGE = 'Missing Parameter pRestrictActionTypeList To or not a number';
    END IF;

    IF (pRunClusteringDesc IS NULL OR pRunClusteringDesc = '') THEN 
        SET strRunCluster = '[0]';
    ELSE
        SET strRunCluster = UPPER(pRunClusteringDesc);
    END IF;

    -- Safely format strings before usage
    SET v_log_app = UPPER(IFNULL(pApplicationName, 'UNKNOWN_APP'));
    SET v_log_mod = UPPER(IFNULL(pModuleName, 'UNKNOWN_MOD'));

    
    SET v_ProcArgs = SUBSTR(CONCAT(
        'sp_RunPrepareAutoRun(', 
        IFNULL(pSchema, 'NULL'), ', ', 
        IFNULL(CAST(pPitManualRunFg AS STRING), 'NULL'), ', ', 
        IFNULL(CAST(v_CntAdvWeekReagg AS STRING), 'NULL'), ', ', 
        IFNULL(CAST(pAPTPeriodOnlyFg AS STRING), 'NULL'), ', ', 
        IFNULL(pRestrictActionTypeList, 'NULL'), 
        ')'
    ), 1, 1000);

    
    BEGIN
        SET v_log_querytag = IFNULL(
            ldl_p_lew_mart_pit.f_querytag(v_log_app, v_log_mod, ''), 
            'UNKNOWN_TAG'
        );
    EXCEPTION WHEN ERROR THEN
        SET v_log_querytag = 'ERROR_GENERATING_TAG';
    END;

    
    CALL ldl_p_lew_mart_pit_onprem.sp_startcomponentlogging(
        v_log_app,
        v_log_mod,
        v_ProcArgs,
        strRunCluster,
        v_log_querytag,
        v_out_log_result 
    );

    
    SET sqlStmt = """
        UPDATE #PSCHEMA#.t_pit_scope_country_param AS T
        SET
              DWH_VALID_TO  = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)
            , DWH_UPDATED   = CURRENT_DATETIME()
            , CURRENT_FG    = 0
        WHERE T.PARAM_ID IN (42, 13, 52, 53)
          AND T.DELETED_FG = 0
          AND T.CURRENT_FG = 1
          AND STRUCT(T.CLIENT_ID, T.PARAM_ID, T.VERSION_NR) IN (
              SELECT AS STRUCT CLIENT_ID, PARAM_ID, VERSION_NR
              FROM #PSCHEMA#.t_pit_scope_country_param
              WHERE PARAM_ID IN (42, 13, 52, 53) AND DELETED_FG = 0 AND CURRENT_FG = 1
              QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
          );
    """;
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', IFNULL(pSchema, 'INVALID_SCHEMA'));

    BEGIN
        EXECUTE IMMEDIATE sqlStmt;
        SET v_row_cnt = v_row_cnt + @@row_count;
    EXCEPTION WHEN ERROR THEN
        RAISE USING MESSAGE = CONCAT('P_RUNPREPAREAUTORUN UPDATE parameters failed [', sqlStmt, ']: ', IFNULL(NULLIF(@@error.message, 'NULL'), 'Unknown error'));
    END;

    
    SET sqlStmt = """
        INSERT INTO #PSCHEMA#.t_pit_scope_country_param
        (
              CLIENT_ID, PARAM_ID, PARAM_NAME, PARAM_VALUE, PARAM_VALUE_CHAR
            , DWH_VALID_FROM, DWH_VALID_TO, VERSION_NR, CURRENT_FG
        )
        SELECT
              PA.CLIENT_ID, PA.PARAM_ID, PAR.PARAM_NAME
            , #PPITMANUALRUNFG# AS PARAM_VALUE
            , CAST(#PPITMANUALRUNFG# AS STRING) AS PARAM_VALUE_CHAR
            , CURRENT_DATE() AS DWH_VALID_FROM
            , CAST('9999-12-31' AS DATE) AS DWH_VALID_TO
            , CAST(PA.VERSION_NR + 1 AS INT64) AS VERSION_NR
            , 1 AS CURRENT_FG
        FROM (
            SELECT CLIENT_ID, PARAM_ID, VERSION_NR
            FROM #PSCHEMA#.t_pit_scope_country_param
            WHERE PARAM_ID = 42 AND DELETED_FG = 0
            QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
        ) AS PA
        INNER JOIN (
            SELECT DISTINCT PARAM_ID, PARAM_NAME
            FROM #PSCHEMA#.t_pit_scope_country_param_ref
            WHERE PARAM_ID = 42
        ) AS PAR ON PA.PARAM_ID = PAR.PARAM_ID;
    """;
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', IFNULL(pSchema, 'INVALID_SCHEMA'));
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PPITMANUALRUNFG#', CAST(pPitManualRunFg AS STRING));

    BEGIN
        EXECUTE IMMEDIATE sqlStmt;
        SET v_row_cnt = v_row_cnt + @@row_count;
    EXCEPTION WHEN ERROR THEN
        RAISE USING MESSAGE = CONCAT('P_RUNPREPAREAUTORUN INSERT param 42 failed [', sqlStmt, ']: ', IFNULL(NULLIF(@@error.message, 'NULL'), 'Unknown error'));
    END;

    
    SET sqlStmt = """
        INSERT INTO #PSCHEMA#.t_pit_scope_country_param
        (
              CLIENT_ID, PARAM_ID, PARAM_NAME, PARAM_VALUE, PARAM_VALUE_CHAR
            , DWH_VALID_FROM, DWH_VALID_TO, VERSION_NR, CURRENT_FG
        )
        SELECT
              PA.CLIENT_ID, PA.PARAM_ID, PAR.PARAM_NAME
            , #PCNTADVWEEKREAGG# AS PARAM_VALUE
            , CAST(#PCNTADVWEEKREAGG# AS STRING) AS PARAM_VALUE_CHAR
            , CURRENT_DATE() AS DWH_VALID_FROM
            , CAST('9999-12-31' AS DATE) AS DWH_VALID_TO
            , CAST(PA.VERSION_NR + 1 AS INT64) AS VERSION_NR
            , 1 AS CURRENT_FG
        FROM (
            SELECT CLIENT_ID, PARAM_ID, VERSION_NR
            FROM #PSCHEMA#.t_pit_scope_country_param
            WHERE PARAM_ID = 13 AND DELETED_FG = 0
            QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
        ) AS PA
        INNER JOIN (
            SELECT DISTINCT PARAM_ID, PARAM_NAME
            FROM #PSCHEMA#.t_pit_scope_country_param_ref
            WHERE PARAM_ID = 13
        ) AS PAR ON PA.PARAM_ID = PAR.PARAM_ID;
    """;
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', IFNULL(pSchema, 'INVALID_SCHEMA'));
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PCNTADVWEEKREAGG#', CAST(v_CntAdvWeekReagg AS STRING));

    BEGIN
        EXECUTE IMMEDIATE sqlStmt;
        SET v_row_cnt = v_row_cnt + @@row_count;
    EXCEPTION WHEN ERROR THEN
        RAISE USING MESSAGE = CONCAT('P_RUNPREPAREAUTORUN INSERT param 13 failed [', sqlStmt, ']: ', IFNULL(NULLIF(@@error.message, 'NULL'), 'Unknown error'));
    END;

    
    SET sqlStmt = """
        INSERT INTO #PSCHEMA#.t_pit_scope_country_param
        (
              CLIENT_ID, PARAM_ID, PARAM_NAME, PARAM_VALUE, PARAM_VALUE_CHAR
            , DWH_VALID_FROM, DWH_VALID_TO, VERSION_NR, CURRENT_FG
        )
        SELECT
              PA.CLIENT_ID, PA.PARAM_ID, PAR.PARAM_NAME
            , #PAPTPERIODONLYFG# AS PARAM_VALUE
            , CAST(#PAPTPERIODONLYFG# AS STRING) AS PARAM_VALUE_CHAR
            , CURRENT_DATE() AS DWH_VALID_FROM
            , CAST('9999-12-31' AS DATE) AS DWH_VALID_TO
            , CAST(PA.VERSION_NR + 1 AS INT64) AS VERSION_NR
            , 1 AS CURRENT_FG
        FROM (
            SELECT CLIENT_ID, PARAM_ID, VERSION_NR
            FROM #PSCHEMA#.t_pit_scope_country_param
            WHERE PARAM_ID = 53 AND DELETED_FG = 0
            QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
        ) AS PA
        INNER JOIN (
            SELECT DISTINCT PARAM_ID, PARAM_NAME
            FROM #PSCHEMA#.t_pit_scope_country_param_ref
            WHERE PARAM_ID = 53
        ) AS PAR ON PA.PARAM_ID = PAR.PARAM_ID;
    """;
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', IFNULL(pSchema, 'INVALID_SCHEMA'));
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PAPTPERIODONLYFG#', CAST(pAPTPeriodOnlyFg AS STRING));

    BEGIN
        EXECUTE IMMEDIATE sqlStmt;
        SET v_row_cnt = v_row_cnt + @@row_count;
    EXCEPTION WHEN ERROR THEN
        RAISE USING MESSAGE = CONCAT('P_RUNPREPAREAUTORUN INSERT param 53 failed [', sqlStmt, ']: ', IFNULL(NULLIF(@@error.message, 'NULL'), 'Unknown error'));
    END;

    
    SET sqlStmt = """
        INSERT INTO #PSCHEMA#.t_pit_scope_country_param
        (
              CLIENT_ID, PARAM_ID, PARAM_NAME, PARAM_VALUE, PARAM_VALUE_CHAR
            , DWH_VALID_FROM, DWH_VALID_TO, VERSION_NR, CURRENT_FG
        )
        SELECT 
              PA.CLIENT_ID, PA.PARAM_ID, PAR.PARAM_NAME
            , NULL AS PARAM_VALUE
            , '#PRESTRICTACTIONTYPELIST#' AS PARAM_VALUE_CHAR
            , CURRENT_DATE() AS DWH_VALID_FROM
            , CAST('9999-12-31' AS DATE) AS DWH_VALID_TO
            , CAST(PA.VERSION_NR + 1 AS INT64) AS VERSION_NR
            , 1 AS CURRENT_FG
        FROM (
            SELECT CLIENT_ID, PARAM_ID, VERSION_NR
            FROM #PSCHEMA#.t_pit_scope_country_param
            WHERE PARAM_ID = 52 AND DELETED_FG = 0
            QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
        ) AS PA
        INNER JOIN (
            SELECT DISTINCT PARAM_ID, PARAM_NAME
            FROM #PSCHEMA#.t_pit_scope_country_param_ref
            WHERE PARAM_ID = 52
        ) PAR ON PA.PARAM_ID = PAR.PARAM_ID;
    """;
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', IFNULL(pSchema, 'INVALID_SCHEMA'));
    SET sqlStmt = REGEXP_REPLACE(sqlStmt, '#PRESTRICTACTIONTYPELIST#', IFNULL(pRestrictActionTypeList, ''));

    BEGIN
        EXECUTE IMMEDIATE sqlStmt;
        SET v_row_cnt = v_row_cnt + @@row_count;
    EXCEPTION WHEN ERROR THEN
        RAISE USING MESSAGE = CONCAT('P_RUNPREPAREAUTORUN INSERT param 52 failed [', sqlStmt, ']: ', IFNULL(NULLIF(@@error.message, 'NULL'), 'Unknown error'));
    END;

    -- Log End
    BEGIN
        
        DECLARE v_row_cnt_str STRING;
        SET v_row_cnt_str = CAST(v_row_cnt AS STRING);

        CALL ldl_p_lew_mart_pit_onprem.sp_endcomponentlogging(
            v_log_app,
            v_log_mod,
            v_ProcArgs,
            strRunCluster,
            v_row_cnt_str,    -- 5th parameter passed as a clean variable instead of CAST()
            v_out_log_result  -- 6th parameter passed as a clean variable (reuses the OUT variable from log start)
        );
    EXCEPTION WHEN ERROR THEN
        RAISE USING MESSAGE = CONCAT('P_RUNPREPAREAUTORUN Logging End failed: ', IFNULL(NULLIF(@@error.message, 'NULL'), 'Unknown error'));
    END;

    -- Return final row count matching Snowflake output type
    SELECT CAST(v_row_cnt AS STRING) AS result;
END;