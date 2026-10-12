CREATE OR REPLACE PROCEDURE ldl_p_lew_mart_pit_onprem.sp_runpreparemanualrun(IN pSchema STRING, IN pPitManualRunFg FLOAT64, IN pPitmanualCountryList STRING, IN pCntAdvWeekReagg FLOAT64, IN pAPTPeriodOnlyFg FLOAT64, IN pRestrictActionTypeList STRING, IN pApplicationName STRING, IN pModuleName STRING, IN pRunClusteringDesc STRING, OUT out_param STRING)
BEGIN
DECLARE _rowCnt BIGNUMERIC;
DECLARE msg STRING;
DECLARE iMaxRunsAdvWeek BIGNUMERIC;
DECLARE strActionTypeList STRING;
DECLARE strRunCluster STRING;
DECLARE sqlStmtLogStart STRING;
DECLARE sqlStmtLogEnd STRING;
DECLARE sqlStmtCheck STRING;
DECLARE sqlStmtCnt STRING;
DECLARE sqlStmt STRING;
DECLARE sqlBeginTransaction STRING;
DECLARE sqlCommit STRING;
DECLARE res STRING;
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
-- Example		:	CALL LDL.P_LEW_MART_PIT_ONPREM.sp_RunPrepareManualRun (4,'P_LEW_MART_PIT_ONPREM', '2021-07-30','2021-09-01',202130,202135);
-- ------------------------------------------------------------------------
-- # History:
-- #  1.0  2021-07-01 Andreas Kurz    	Initial version
-- #  1.3  2021-11-08 Andreas Kurz		Added additional logging

SET _rowCnt  =  0;
SET msg  =  '';
SET iMaxRunsAdvWeek  =  150;
SET strActionTypeList  =  '2,3';
SET strRunCluster  =  '[0]';
SET sqlStmtLogStart  =  '';
SET sqlStmtLogEnd  =  '';
SET sqlStmtCheck  =  '';
SET sqlStmtCnt  =  '';
SET sqlStmt  =  '';
SET sqlBeginTransaction  =  'BEGIN TRANSACTION';
SET sqlCommit  =  'COMMIT TRANSACTION';

IF pPitManualRunFg IS NULL OR pPitManualRunFg IS NULL OR IS_NAN(pPitManualRunFg) = true
 OR pPitManualRunFg <> 1 THEN
    BEGIN
    SET msg  =  'Missing parameter pPitManualRunFg or not a number: Mandatory Parameter must be 1)';
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
END IF;

-- restrict the number of reagg weeks


IF pCntAdvWeekReagg IS NULL OR pCntAdvWeekReagg IS NULL OR IS_NAN(pCntAdvWeekReagg) = true
 OR pCntAdvWeekReagg < 1 OR pCntAdvWeekReagg > iMaxRunsAdvWeek THEN
    BEGIN
    SET pCntAdvWeekReagg  =  iMaxRunsAdvWeek;
    END;
END IF;


IF pRestrictActionTypeList = '' OR pRestrictActionTypeList IS NULL OR pRestrictActionTypeList IS NULL OR (LENGTH(pRestrictActionTypeList) = 0)
 THEN
    BEGIN
    SET msg  =  'Missing Parameter pRestrictActionTypeList To or not a number';
    RAISE USING MESSAGE = msg ;
    SET out_param  =  msg;
    SELECT out_param;
    RETURN;
    END;
END IF;

-- CHECK INPUT runcluster


IF pRunClusteringDesc = '' OR pRunClusteringDesc IS NULL OR (LENGTH(pRunClusteringDesc) = 0)
 OR pRunClusteringDesc IS NULL THEN
    BEGIN
    SET pRunClusteringDesc  =  strRunCluster;
    END;
ELSE
    BEGIN
    SET strRunCluster  =  UPPER(pRunClusteringDesc);
    END;
END IF;

SET sqlStmt  =  '''
UPDATE #PSCHEMA#.t_pit_scope_country_param AS t_pit_scope_country_param0 SET
 dwh_valid_to = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY),
 dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME),
 current_fg = 0 FROM (SELECT *
  FROM #PSCHEMA#.t_pit_scope_country_param
  WHERE param_id IN (42, 43, 13, 52, 53, 6, 14, 16)
   AND deleted_fg = 0
   AND client_id IN (SELECT ROUND(CAST(value AS BIGNUMERIC), 0) AS client_id
     FROM (SELECT t.seq,
         ORDINALITY + 1 AS index,
        VALUE AS value
       FROM (SELECT 1 AS seq) AS t
        CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t1
     WHERE LENGTH(TRIM(t1.value)) > 0
     GROUP BY client_id)
  QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS SRC
WHERE t_pit_scope_country_param0.param_id = SRC.param_id AND t_pit_scope_country_param0.client_id = SRC.client_id AND
   t_pit_scope_country_param0.version_nr = SRC.version_nr AND t_pit_scope_country_param0.deleted_fg = 0 ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
-- SET sqlStmtLogStart  = 
BEGIN
		CALL ldl_p_lew_mart_pit_onprem.sp_startcomponentlogging(
      				 UPPER(pApplicationName)
    				,UPPER(pModuleName)
    				,"sp_runpreparemanualrun( pSchema, pPitManualRunFg, pPitmanualCountryList, pCntAdvWeekReagg, pAPTPeriodOnlyFg, pAPTPeriodOnlyFg)"
    				,strRunCluster
    				,ldl_p_lew_mart_pit_onprem.querytag(UPPER(pApplicationName),UPPER(pModuleName),NULL)
            ,res
    				);
    		


-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PAPPLICATIONNAME#', UPPER(pApplicationName));
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PMODULENAME#', UPPER(pModuleName));
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#RUNCLUSTER#', strRunCluster);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PSCHEMA#', pSchema);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PPITMANUALRUNFG#', pPitManualRunFg);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PCNTADVWEEKREAGG#', pCntAdvWeekReagg);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PAPTPERIODONLYFG#', pAPTPeriodOnlyFg);
-- SET sqlStmtLogStart  =  REGEXP_REPLACE(sqlStmtLogStart, '#PRESTRICTACTIONTYPELIST#', pAPTPeriodOnlyFg);
-- Log Start


EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmtLogStart || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
-- update params

BEGIN

EXECUTE IMMEDIATE (sqlBeginTransaction);

EXECUTE IMMEDIATE (sqlStmt);
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  @@row_count;
SET sqlStmt  =  '';
SET sqlStmt  =  '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param (client_id, param_id, param_name, param_value,
 param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
(SELECT PA.client_id,
  PA.param_id,
  PAR.param_name,
  ROUND(CAST(#PPITMANUALRUNFG# AS NUMERIC), 5) AS param_value,
  CAST(#PPITMANUALRUNFG# AS STRING) AS param_value_char,
  CURRENT_DATE AS dwh_valid_from,
  PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
   PA.version_nr + 1 AS version_nr,
  1 AS current_fg
 FROM (SELECT *
   FROM #PSCHEMA#.t_pit_scope_country_param
   WHERE param_id = 42
    AND deleted_fg = 0
   QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA
  INNER JOIN (SELECT DISTINCT *
   FROM #PSCHEMA#.t_pit_scope_country_param_ref
   WHERE param_id = 42) AS PAR ON PA.param_id = PAR.param_id
  INNER JOIN (SELECT value AS client_id
   FROM (SELECT t5.seq,
       ORDINALITY + 1 AS index,
      VALUE AS value
     FROM (SELECT 1 AS seq) AS t5
      CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t6
   WHERE LENGTH(TRIM(t6.value)) > 0
   GROUP BY client_id) AS TMP ON PA.client_id = CAST(TMP.client_id AS FLOAT64)) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALRUNFG#', CAST(pPitManualRunFg AS STRING));
-- Update param 42 pit_manual_run_fg insert new version

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
-- INTO res
 ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  _rowCnt + @@row_count;
SET sqlStmt  =  '';
SET sqlStmt  =  '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param (client_id, param_id, param_name, param_value,
 param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
(SELECT PA.client_id,
  PA.param_id,
  PAR.param_name,
  NULL AS param_value,
  TMP.`_ctrlist` AS param_value_char,
  CURRENT_DATE AS dwh_valid_from,
  PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
   PA.version_nr + 1 AS version_nr,
  1 AS current_fg
 FROM (SELECT *
   FROM #PSCHEMA#.t_pit_scope_country_param
   WHERE param_id = 43
    AND deleted_fg = 0
   QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA
  INNER JOIN (SELECT DISTINCT param_id,
    param_name,
    param_descr,
    param_column_datatype
   FROM #PSCHEMA#.t_pit_scope_country_param_ref
   WHERE param_id = 43) AS PAR ON PA.param_id = PAR.param_id
  INNER JOIN (SELECT *
   FROM (SELECT value AS client_id
     FROM (SELECT t5.seq,
         ORDINALITY + 1 AS index,
        VALUE AS value
       FROM (SELECT 1 AS seq) AS t5
        CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t6
     WHERE LENGTH(TRIM(t6.value)) > 0
     GROUP BY client_id) AS `_a`
    CROSS JOIN (SELECT STRING_AGG(CAST(value AS STRING), ",") AS `_ctrlist`
     FROM (SELECT t10.seq,
         ORDINALITY + 1 AS index,
        VALUE AS value
       FROM (SELECT 1 AS seq) AS t10
        CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t11
     WHERE LENGTH(TRIM(t11.value)) > 0) AS `_b`) AS TMP ON PA.client_id = CAST(TMP.client_id AS FLOAT64)) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
-- Update param 43 pit_manual_country_list insert new version

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
-- INTO res 
;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  _rowCnt + @@row_count;
SET sqlStmt  =  '';
SET sqlStmt  =  '''
INSERT INTO #PSCHEMA#.t_pit_scope_country_param (client_id, param_id, param_name, param_value,
 param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
(SELECT DISTINCT PA.client_id,
  PA.param_id,
  PAR.param_name,
  ''' 
  || CAST(iMaxRunsAdvWeek AS STRING) || ''' AS param_value,
  "'''
  || CAST(iMaxRunsAdvWeek AS STRING) || '''" AS param_value_char,
  CURRENT_DATE AS dwh_valid_from,
  PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
   PA.version_nr + 1 AS version_nr,
  1 AS current_fg
 FROM (SELECT *
   FROM #PSCHEMA#.t_pit_scope_country_param
   WHERE param_id = 13
    AND deleted_fg = 0
   QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA
  INNER JOIN (SELECT DISTINCT param_id,
    param_name,
    param_descr,
    param_column_datatype
   FROM #PSCHEMA#.t_pit_scope_country_param_ref
   WHERE param_id = 13) AS PAR ON PA.param_id = PAR.param_id
  INNER JOIN (SELECT value AS client_id
   FROM (SELECT t5.seq,
       ORDINALITY + 1 AS index,
      VALUE AS value
     FROM (SELECT 1 AS seq) AS t5
      CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t6
   WHERE LENGTH(TRIM(t6.value)) > 0
   GROUP BY client_id) AS TMP ON PA.client_id = CAST(TMP.client_id AS FLOAT64)) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PCNTADVWEEKREAGG#', CAST(pCntAdvWeekReagg AS STRING));
-- Update 13 cnt_adv_week_reagg insert new version

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
-- INTO res 
;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  _rowCnt + @@row_count;
SET sqlStmt  =  '';
SET sqlStmt  =  '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param (client_id, param_id, param_name, param_value,
 param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
(SELECT PA.client_id,
  PA.param_id,
  PAR.param_name,
  ROUND(CAST(#PAPTPERIODONLYFG# AS NUMERIC), 5) AS param_value,
  CAST(#PAPTPERIODONLYFG# AS STRING) AS param_value_char,
  CURRENT_DATE AS dwh_valid_from,
  PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
   PA.version_nr + 1 AS version_nr,
  1 AS current_fg
 FROM (SELECT *
   FROM #PSCHEMA#.t_pit_scope_country_param
   WHERE param_id = 53
    AND deleted_fg = 0
   QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA
  INNER JOIN (SELECT DISTINCT param_id,
    param_name,
    param_descr,
    param_column_datatype
   FROM #PSCHEMA#.t_pit_scope_country_param_ref
   WHERE param_id = 53) AS PAR ON PA.param_id = PAR.param_id
  INNER JOIN (SELECT value AS client_id
   FROM (SELECT t5.seq,
       ORDINALITY + 1 AS index,
      VALUE AS value
     FROM (SELECT 1 AS seq) AS t5
      CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t6
   WHERE LENGTH(TRIM(t6.value)) > 0
   GROUP BY client_id) AS TMP ON PA.client_id = CAST(TMP.client_id AS FLOAT64)) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PAPTPERIODONLYFG#', CAST(pAPTPeriodOnlyFg AS STRING));
-- Update 53 apt_period_only_fg insert new version

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
-- INTO res 
;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  _rowCnt + @@row_count;
SET sqlStmt  =  '';
SET sqlStmt  =  '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param (client_id, param_id, param_name, param_value,
 param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
(SELECT PA.client_id,
  PA.param_id,
  PAR.param_name,
  NULL AS param_value,
  "#PRESTRICTACTIONTYPELIST#" AS param_value_char,
  CURRENT_DATE AS dwh_valid_from,
  PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
   PA.version_nr + 1 AS version_nr,
  1 AS current_fg
 FROM (SELECT *
   FROM #PSCHEMA#.t_pit_scope_country_param
   WHERE param_id = 52
    AND deleted_fg = 0
   QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA
  INNER JOIN (SELECT DISTINCT param_id,
    param_name,
    param_descr,
    param_column_datatype
   FROM #PSCHEMA#.t_pit_scope_country_param_ref
   WHERE param_id = 52) AS PAR ON PA.param_id = PAR.param_id
  INNER JOIN (SELECT value AS client_id
   FROM (SELECT t5.seq,
       ORDINALITY + 1 AS index,
      VALUE AS value
     FROM (SELECT 1 AS seq) AS t5
      CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t6
   WHERE LENGTH(TRIM(t6.value)) > 0
   GROUP BY client_id) AS TMP ON PA.client_id = CAST(TMP.client_id AS FLOAT64)) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PRESTRICTACTIONTYPELIST#', pRestrictActionTypeList);
-- Update param 52 restricted_action_type_list insert new version

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
-- INTO res 
;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  _rowCnt + @@row_count;
SET sqlStmt  =  '';
SET sqlStmt  =  '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param (client_id, param_id, param_name, param_value,
 param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
(SELECT PA.client_id,
  PA.param_id,
  PAR.param_name,
  ROUND(SAFE_CAST(FORMAT_DATE("%Y%m%d", PAN.param_value) AS NUMERIC), 0) AS param_value,
  FORMAT_DATE("%F", PAN.param_value) AS param_value_char,
  CURRENT_DATE AS dwh_valid_from,
  PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
   PA.version_nr + 1 AS version_nr,
  1 AS current_fg
 FROM (SELECT PA.client_id,
    14 AS param_id,
    DATE_SUB(DATE_SUB(PA.end_dt_pit_data, INTERVAL 6 DAY), INTERVAL IF(CWS.following_cal_week_fg = 1, PA.cnt_adv_week_reagg
         - 1, PA.cnt_adv_week_reagg) * 7 DAY) AS param_value
   FROM (SELECT client_id,
      MAX(`A11864`) AS end_dt_pit_data,
      MAX(`A11865`) AS cnt_adv_week_reagg
     FROM (SELECT client_id,
        IF(param_id = 8, DATE(SAFE.PARSE_DATETIME("%F", param_value_char)), NULL) AS `A11864`,
        IF(param_id = 13, CAST(ROUND(param_value) AS INTEGER), NULL) AS `A11865`
       FROM #PSCHEMA#.t_pit_scope_country_param
       WHERE deleted_fg = 0
        AND param_id IN (8, 13)
        AND client_id IN (SELECT ROUND(CAST(value AS BIGNUMERIC), 0) AS client_id
          FROM (SELECT t.seq,
              ORDINALITY + 1 AS index,
             VALUE AS value
            FROM (SELECT 1 AS seq) AS t
             CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t1
          WHERE LENGTH(TRIM(t1.value)) > 0
          GROUP BY client_id)
       QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS t9
     GROUP BY client_id) AS PA
    INNER JOIN #PSCHEMA#.t_country_advert_week_start AS CWS ON CURRENT_DATE BETWEEN CWS.dwh_valid_from
      AND CWS.dwh_valid_to AND PA.client_id = CWS.client_id) AS PAN
  INNER JOIN (SELECT client_id,
    param_id,
    param_name,
    version_nr
   FROM #PSCHEMA#.t_pit_scope_country_param
   WHERE param_id = 14
    AND deleted_fg = 0
   QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA ON PAN.client_id = PA.client_id
     AND PAN.param_id = PA.param_id
  INNER JOIN (SELECT DISTINCT param_id,
    param_name,
    param_descr,
    param_column_datatype
   FROM #PSCHEMA#.t_pit_scope_country_param_ref
   WHERE param_id = 14) AS PAR ON PA.param_id = PAR.param_id) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
-- Update param 14 start_dt_reagg insert new version
-- Recalcualte  Update start_dt_reagg (14) <-- (@[end_dt_pit_data](8) - 6) - (@[cnt_adv_week_reagg](13)*7)

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
-- INTO res
 ;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  _rowCnt + @@row_count;
SET sqlStmt  =  '';
SET sqlStmt  =  '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param (client_id, param_id, param_name, param_value,
 param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
(SELECT PA.client_id,
  PA.param_id,
  PAR.param_name,
  ROUND(SAFE_CAST(FORMAT_DATE("%Y%m%d", PAN.param_value) AS NUMERIC), 0) AS param_value,
  FORMAT_DATE("%F", PAN.param_value) AS param_value_char,
  CURRENT_DATE AS dwh_valid_from,
  PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
   PA.version_nr + 1 AS version_nr,
  1 AS current_fg
 FROM (SELECT client_id,
    6 AS param_id,
     CASE
     WHEN DATE(MAX(`A11865`)) < DATE(MAX(`A11864`))
     THEN DATE(MAX(`A11865`))
     ELSE DATE(MAX(`A11864`))
     END AS param_value
   FROM (SELECT client_id,
      IF(param_id = 6, DATE(SAFE.PARSE_DATETIME("%F", param_value_char)), NULL) AS `A11864`,
      IF(param_id = 14, DATE(SAFE.PARSE_DATETIME("%F", param_value_char)), NULL) AS `A11865`
     FROM #PSCHEMA#.t_pit_scope_country_param
     WHERE deleted_fg = 0
      AND param_id IN (6, 14)
      AND client_id IN (SELECT ROUND(CAST(value AS BIGNUMERIC), 0) AS client_id
        FROM (SELECT t.seq,
            ORDINALITY + 1 AS index,
           VALUE AS value
          FROM (SELECT 1 AS seq) AS t
           CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t1
        WHERE LENGTH(TRIM(t1.value)) > 0
        GROUP BY client_id)
     QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS t9
   GROUP BY client_id) AS PAN
  INNER JOIN (SELECT client_id,
    param_id,
    param_name,
    version_nr
   FROM #PSCHEMA#.t_pit_scope_country_param
   WHERE param_id = 6
    AND deleted_fg = 0
   QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS PA ON PAN.client_id = PA.client_id
     AND PAN.param_id = PA.param_id
  INNER JOIN (SELECT DISTINCT param_id,
    param_name,
    param_descr,
    param_column_datatype
   FROM #PSCHEMA#.t_pit_scope_country_param_ref
   WHERE param_id = 6) AS PAR ON PA.param_id = PAR.param_id) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
-- Update param 6 start_dt_pit_data insert new version
-- Overwrite in case start_dt_reagg < start_dt_pit_data else start_dt_reagg

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
-- INTO res 
;
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  _rowCnt + @@row_count;
SET sqlStmt  =  '';
SET sqlStmt  =  '''INSERT INTO #PSCHEMA#.t_pit_scope_country_param (client_id, param_id, param_name, param_value,
 param_value_char, dwh_valid_from, dwh_valid_to, version_nr, current_fg)
(SELECT DISTINCT pa.client_id,
  16 AS param_id,
  par.param_name,
  CAST(cws.adv_week_id AS NUMERIC) AS param_value,
  CAST(cws.adv_week_id AS STRING) AS param_value_char,
  CURRENT_DATE AS dwh_valid_from,
  PARSE_DATE("%F", "9999-12-31") AS dwh_valid_to,
   pa.version_nr + 1 AS version_nr,
  1 AS current_fg
 FROM (SELECT *
   FROM #PSCHEMA#.t_pit_scope_country_param
   WHERE param_id IN (14)
    AND deleted_fg = 0
    AND client_id IN (SELECT ROUND(CAST(value AS BIGNUMERIC), 0) AS client_id
      FROM (SELECT t.seq,
          ORDINALITY + 1 AS index,
         VALUE AS value
        FROM (SELECT 1 AS seq) AS t
         CROSS JOIN UNNEST(SPLIT("#PPITMANUALCOUNTRYLIST#", ",")) AS VALUE WITH OFFSET AS ORDINALITY) AS t1
      WHERE LENGTH(TRIM(t1.value)) > 0
      GROUP BY client_id)
   QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY client_id, param_id))) AS pa
  INNER JOIN (SELECT CWS.client_id,
    CAL.cal_dt,
     CASE
     WHEN CAL.day_of_week >= CWS.adv_week_start_day AND CWS.following_cal_week_fg = 0
     THEN CAL.cy_week
     WHEN CAL.day_of_week >= CWS.adv_week_start_day AND CWS.following_cal_week_fg = 1
     THEN NWK.cy_week
     WHEN CAL.day_of_week < CWS.adv_week_start_day AND CWS.following_cal_week_fg = 0
     THEN CWK.cy_week_prev_1w
     WHEN CAL.day_of_week < CWS.adv_week_start_day AND CWS.following_cal_week_fg = 1
     THEN CAL.cy_week
     ELSE NULL
     END AS adv_week_id
   FROM ldl_p_lew_core_ac.v_cal_calendarday AS CAL
    INNER JOIN #PSCHEMA#.t_country_advert_week_start AS CWS ON CAL.cal_dt BETWEEN CWS.dwh_valid_from AND
     CWS.dwh_valid_to
    INNER JOIN ldl_p_lew_core_ac.v_cal_week AS CWK ON CAL.cy_week = CWK.cy_week
    INNER JOIN ldl_p_lew_core_ac.v_cal_week AS NWK ON CAL.cy_week = NWK.cy_week_prev_1w
   WHERE CAL.cal_dt <= CURRENT_DATE
   GROUP BY CWS.client_id,
    CAL.cal_dt,
    adv_week_id) AS cws ON pa.client_id = cws.client_id AND PARSE_DATE("%F", pa.param_value_char) = cws.cal_dt
  CROSS JOIN (SELECT DISTINCT *
   FROM #PSCHEMA#.t_pit_scope_country_param_ref
   WHERE param_id IN (16)) AS par) ''';
-- Variable Substitution

SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PSCHEMA#', pSchema);
SET sqlStmt  =  REGEXP_REPLACE(sqlStmt, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
-- Recalcualte  start_adv_week_reagg (16)

BEGIN

EXECUTE IMMEDIATE (sqlStmt)
-- INTO res 
;

EXECUTE IMMEDIATE (sqlCommit);
EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmt || sqlStmtCnt || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
SET _rowCnt  =  _rowCnt + @@row_count;
SET sqlStmtLogEnd  =  '';
-- SET sqlStmtLogEnd  =   
BEGIN

CALL ldl_p_lew_mart_pit_onprem.sp_endcomponentlogging(
      				 UPPER(pApplicationName)
    				,UPPER(pModuleName)
    				,"sp_runpreparemanualrun( pSchema, pPitManualRunFg, pPitmanualCountryList, pCntAdvWeekReagg, pAPTPeriodOnlyFg, pRestrictActionTypeList)"
    				,strRunCluster
    				,CAST(_rowCnt AS INT64)
            ,res
    				);



-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PAPPLICATIONNAME#', UPPER(pApplicationName));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PMODULENAME#', UPPER(pModuleName));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#RUNCLUSTER#', strRunCluster);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PSCHEMA#', UPPER(pSchema));
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PPITMANUALRUNFG#', pPitManualRunFg);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PPITMANUALCOUNTRYLIST#', pPitmanualCountryList);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PCNTADVWEEKREAGG#', pCntAdvWeekReagg);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PAPTPERIODONLYFG#', pAPTPeriodOnlyFg);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#PRESTRICTACTIONTYPELIST#', pRestrictActionTypeList);
-- SET sqlStmtLogEnd  =  REGEXP_REPLACE(sqlStmtLogEnd, '#ROWCOUNT#', CAST(_rowCnt AS STRING));
-- Log End


EXCEPTION
WHEN ERROR THEN
SET msg  =  'P_RUNPREPAREMANUALRUN: [' || sqlStmtLogEnd || ']' || @@last_job_id || 'SQLSTATE:' || 'FAILED' || ' MESSAGE: ' || @@ERROR.MESSAGE;
RAISE USING MESSAGE = msg ;
SET out_param  =  msg;
SELECT out_param;
RETURN;
END;
-- Loop all results

SET _rowCnt  =  COALESCE(CAST(ARRAY_LENGTH(res) AS BIGNUMERIC), 0);
SET out_param  =  '' || CAST(_rowCnt AS STRING);
SELECT out_param;
RETURN;
END;

