CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_runcleanmanualrun(
  IN pSchema STRING, 
  IN pPitManualRunFg FLOAT64, 
  IN pPitmanualCountryList STRING, 
  IN pApplicationName STRING, 
  IN pModuleName STRING, 
  IN pRunClusteringDesc STRING, 
  OUT out_param STRING
)

-- ---------------------------------------------------------------------
-- PROCEDURE	:	sp_RunBFExecutionWrapper(pClient DOUBLE, pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING, pMaxRuns DOUBLE)
-- Input		:   pClientId 				DOUBLE --> -1 ::= All Clients
-- 				pSchema 				STRING
-- 				pApplicationName 		STRING
-- 				pModuleName 			STRING 		
--     			pRunClusteringDesc    	STRING --> [0] running in sequence
--     			pMaxRuns				DOUBLE
-- Return		:	Error + Error Msg or in success case number of processed Tables
-- Convert		:	None    
-- Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
--                 Logging is also enables  but must be enabled! 
-- Example		:	CALL P_LEW_MART_PIT_ONPREM.sp_RunCleanManualRun (4,'P_LEW_MART_PIT_ONPREM', '2021-07-30','2021-09-01',202130,202135);
-- ------------------------------------------------------------------------
-- # History:
-- #  1.0  2021-07-01 Andreas Kurz    	Initial version
-- #  1.3  2021-11-08 Andreas Kurz		Added additional logging
-- #  1.4  2021-12-02 Nikolai Toknov	Change the logic for getting the previous value of the parameters (previous value -> previous value, different from the last value)

BEGIN
  DECLARE _rowCnt BIGNUMERIC DEFAULT 0;
  DECLARE msg STRING DEFAULT '';
  DECLARE strRunCluster STRING DEFAULT '[0]';
  DECLARE sqlStmt STRING DEFAULT '';
  DECLARE strLogDescr STRING DEFAULT '';
  DECLARE output_msg STRING;

  -- Input Validation
  IF pPitManualRunFg IS NULL OR IS_NAN(pPitManualRunFg) = true OR pPitManualRunFg <> 1 THEN
    SET msg = 'Missing parameter pPitManualRunFg or not a number: Mandatory Parameter must be 1)';
    SET out_param = msg;
    RETURN;
  END IF;

  IF pRunClusteringDesc IS NULL OR pRunClusteringDesc = '' OR LENGTH(TRIM(pRunClusteringDesc)) = 0 THEN
    SET strRunCluster = '[0]';
  ELSE
    SET strRunCluster = UPPER(pRunClusteringDesc);
  END IF;
  
  -- Pre-compute description for Logging
  SET strLogDescr = CONCAT('sp_RunCleanManualRun( ', UPPER(pSchema), ', ', CAST(pPitManualRunFg AS STRING), ', ', pPitmanualCountryList, ')');

  -- Log Start
  BEGIN
    CALL ldl_p_lew_mart_pit_onprem.sp_startcomponentlogging(
         UPPER(pApplicationName)
        ,UPPER(pModuleName)
        ,strLogDescr
        ,strRunCluster
        ,ldl_p_lew_mart_pit_onprem.querytag(UPPER(pApplicationName),UPPER(pModuleName), NULL),output_msg
    );
  EXCEPTION WHEN ERROR THEN
    SET msg = CONCAT('P_RUNCLEANMANUALRUN_LogStart [FAILED] MESSAGE: ', @@error.message);
    RAISE USING MESSAGE = msg;
  END;

  -- Use Standard BQ Transaction Control
  BEGIN TRANSACTION;

  -- 1. UPDATE param 42, 43, 13
  BEGIN
    SET sqlStmt = '''UPDATE ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_1 AS t_pit_scope_country_param0 SET
     dwh_valid_to = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY),
     dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME),
     current_fg = 0 FROM (SELECT *
      FROM ldl_p_lew_mart_pit_onprem.t_pit_scope_country_param_1
      WHERE param_id IN (42, 43, 13)
       AND deleted_fg = 0
       AND client_id IN (SELECT ROUND(CAST(value AS BIGNUMERIC), 0) AS client_id
         FROM (SELECT t.seq,
             ORDINALITY + 1 AS index,
            VALUE AS value
           FROM (SELECT 1 AS seq) AS t
            CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t1_1
         WHERE LENGTH(TRIM(t1.value)) > 0
         GROUP BY client_id)
      QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS SRC
    WHERE t_pit_scope_country_param0.param_id = SRC.param_id AND t_pit_scope_country_param0.client_id = SRC.client_id AND
       t_pit_scope_country_param0.version_nr = SRC.version_nr AND t_pit_scope_country_param0.deleted_fg = 0 ''';
       
    SET sqlStmt = REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
    SET sqlStmt = REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
    
    EXECUTE IMMEDIATE sqlStmt;
    SET _rowCnt = _rowCnt + @@row_count;
    
  EXCEPTION WHEN ERROR THEN
    ROLLBACK TRANSACTION;
    SET msg = CONCAT('P_RUNCLEANMANUALRUN_UpdateParams [FAILED] MESSAGE: ', @@error.message);
    RAISE USING MESSAGE = msg;
  END;

  -- 2. Update param 42 pit_manual_run_fg insert new version
  BEGIN
    SET sqlStmt = '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param_1 (client_id, param_id, param_name, param_value,
     param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
    (SELECT DISTINCT PA.client_id,
      PA.param_id,
      PAR.param_name,
       CASE
       WHEN PA_PREV.param_id IS NOT NULL
       THEN PA_PREV.param_value
       ELSE PA.param_value
       END AS param_value,
       CASE
       WHEN PA_PREV.param_id IS NOT NULL
       THEN PA_PREV.param_value_char
       ELSE PA.param_value_char
       END AS param_value_char,
      CURRENT_DATE AS dwh_valid_from,
      PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
       PA.version_nr + 1 AS version_nr,
      1 AS current_fg
     FROM (SELECT *
       FROM #PSCHEMA#.t_pit_scope_country_param_1
       WHERE param_id = 42
        AND deleted_fg = 0
       QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA
      LEFT JOIN (
        SELECT * FROM (
          SELECT *
          FROM #PSCHEMA#.t_pit_scope_country_param_1
          WHERE param_id = 42
            AND deleted_fg = 0
          QUALIFY param_value <> LEAD(param_value) OVER(PARTITION BY client_id, param_id ORDER BY version_nr)
        )
        QUALIFY version_nr = MAX(version_nr) OVER (PARTITION BY client_id, param_id)
      ) AS PA_PREV ON PA.param_id = PA_PREV.param_id
      INNER JOIN (SELECT DISTINCT *
       FROM #PSCHEMA#.t_pit_scope_country_param_ref_1
       WHERE param_id = 42) AS PAR ON PA.param_id = PAR.param_id
      INNER JOIN (SELECT value AS client_id
       FROM (SELECT t8.seq,
           ORDINALITY + 1 AS index,
          VALUE AS value
         FROM (SELECT 1 AS seq) AS t8
          CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t9
       WHERE LENGTH(TRIM(t9.value)) > 0
       GROUP BY client_id) AS TMP ON PA.client_id = CAST(TMP.client_id AS FLOAT64)) ''';
       
    SET sqlStmt = REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
    SET sqlStmt = REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
    SET sqlStmt = REPLACE(sqlStmt, '#PPITMANUALRUNFG#', CAST(pPitManualRunFg AS STRING));

    EXECUTE IMMEDIATE sqlStmt;
    SET _rowCnt = _rowCnt + @@row_count;
    
  EXCEPTION WHEN ERROR THEN
    ROLLBACK TRANSACTION;
    SET msg = CONCAT('P_RUNCLEANMANUALRUN_Insert42 [FAILED] MESSAGE: ', @@error.message);
    RAISE USING MESSAGE = msg;
  END;

  -- 3. Update param 43 pit_manual_country_list insert new version
  BEGIN
    SET sqlStmt = '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param_1 (client_id, param_id, param_name, param_value,
     param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
    (SELECT DISTINCT PA.client_id,
      PA.param_id,
      PAR.param_name,
      NULL AS param_value,
      CAST(NULL AS STRING) AS param_value_char,
      CURRENT_DATE AS dwh_valid_from,
      PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
       PA.version_nr + 1 AS version_nr,
      1 AS current_fg
     FROM (SELECT *
       FROM #PSCHEMA#.t_pit_scope_country_param_1
       WHERE param_id = 43
        AND deleted_fg = 0
       QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA
      INNER JOIN (SELECT DISTINCT param_id,
        param_name,
        param_descr,
        param_column_datatype
       FROM #PSCHEMA#.t_pit_scope_country_param_ref_1
       WHERE param_id = 43) AS PAR ON PA.param_id = PAR.param_id
      INNER JOIN (SELECT value AS client_id,
        STRING_AGG(CAST(value AS STRING), ",") AS `_ctrlist`
       FROM (SELECT t5.seq,
           ORDINALITY + 1 AS index,
          VALUE AS value
         FROM (SELECT 1 AS seq) AS t5
          CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t6
       WHERE LENGTH(TRIM(t6.value)) > 0
       GROUP BY client_id) AS TMP ON PA.client_id = CAST(TMP.client_id AS FLOAT64)) ''';

    SET sqlStmt = REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
    SET sqlStmt = REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);

    EXECUTE IMMEDIATE sqlStmt;
    SET _rowCnt = _rowCnt + @@row_count;
    
  EXCEPTION WHEN ERROR THEN
    ROLLBACK TRANSACTION;
    SET msg = CONCAT('P_RUNCLEANMANUALRUN_Insert43 [FAILED] MESSAGE: ', @@error.message);
    RAISE USING MESSAGE = msg;
  END;

  -- 4. Update 13 cnt_adv_week_reagg insert new version
  BEGIN
    SET sqlStmt = '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param_1 (client_id, param_id, param_name, param_value,
     param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
    (SELECT PA.client_id,
      PA.param_id,
      PAR.param_name,
       CASE
       WHEN PA_PREV.param_id IS NOT NULL
       THEN PA_PREV.param_value
       ELSE PA.param_value
       END AS param_value,
       CASE
       WHEN PA_PREV.param_id IS NOT NULL
       THEN PA_PREV.param_value_char
       ELSE PA.param_value_char
       END AS param_value_char,
      CURRENT_DATE AS dwh_valid_from,
      PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
       PA.version_nr + 1 AS version_nr,
      1 AS current_fg
     FROM (SELECT *
       FROM #PSCHEMA#.t_pit_scope_country_param_1
       WHERE param_id = 13
        AND deleted_fg = 0
       QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA
     LEFT JOIN (
        SELECT * FROM (
          SELECT *
          FROM #PSCHEMA#.t_pit_scope_country_param_1
          WHERE param_id = 42
            AND deleted_fg = 0
          QUALIFY param_value <> LEAD(param_value) OVER(PARTITION BY client_id, param_id ORDER BY version_nr)
        )
        QUALIFY version_nr = MAX(version_nr) OVER (PARTITION BY client_id, param_id)
      ) AS PA_PREV ON PA.param_id = PA_PREV.param_id
      INNER JOIN (SELECT DISTINCT param_id,
        param_name,
        param_descr,
        param_column_datatype
       FROM #PSCHEMA#.t_pit_scope_country_param_ref_1
       WHERE param_id = 13) AS PAR ON PA.param_id = PAR.param_id
      INNER JOIN (SELECT value AS client_id,
        STRING_AGG(CAST(value AS STRING), ",") AS `_ctrlist`
       FROM (SELECT t8.seq,
           ORDINALITY + 1 AS index,
          VALUE AS value
         FROM (SELECT 1 AS seq) AS t8
          CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t9
       WHERE LENGTH(TRIM(t9.value)) > 0
       GROUP BY client_id) AS TMP ON PA.client_id = CAST(TMP.client_id AS FLOAT64)) ''';

    SET sqlStmt = REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
    SET sqlStmt = REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);

    EXECUTE IMMEDIATE sqlStmt;
    SET _rowCnt = _rowCnt + @@row_count;
    
  EXCEPTION WHEN ERROR THEN
    ROLLBACK TRANSACTION;
    SET msg = CONCAT('P_RUNCLEANMANUALRUN_Insert13 [FAILED] MESSAGE: ', @@error.message);
    RAISE USING MESSAGE = msg;
  END;

  COMMIT TRANSACTION;

  -- Log End
  BEGIN
    CALL ldl_p_lew_mart_pit_onprem.sp_endcomponentlogging(
         UPPER(pApplicationName)
        ,UPPER(pModuleName)
        ,strLogDescr
        ,strRunCluster
        ,CAST(_rowCnt AS STRING),output_msg
    );
  EXCEPTION WHEN ERROR THEN
    SET msg = CONCAT('P_RUNCLEANMANUALRUN_LogEnd [FAILED] MESSAGE: ', @@error.message);
    RAISE USING MESSAGE = msg;
  END;

  SET out_param = CAST(_rowCnt AS STRING);

END;