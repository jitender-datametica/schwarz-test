-- BigQuery Script
DECLARE sv_start_dt DATE;
DECLARE sv_end_dt DATE;
DECLARE sv_day_back_cnt INT64 DEFAULT 10;
DECLARE sv_datediff INT64;
-- DECLARE load_id INT64 DEFAULT @LOAD_ID;  -- Replace @LOAD_ID via parameter or manual value

-- Set date range: start from Monday of 8 weeks ago
SET sv_start_dt = DATE_SUB(DATE_TRUNC(CURRENT_DATE(), WEEK(MONDAY)), INTERVAL 8 WEEK);
SET sv_end_dt = CURRENT_DATE();
SET sv_datediff = DATE_DIFF(SV_END_DT,SV_START_DT,DAY) + 1;

-- ========================================================================
-- PART 1: INSERT ARTIFICIAL DELTA FOR ADDITIONAL RETURNS
-- ========================================================================

INSERT INTO `${BQ_PROJECT_ID}.ETL_PROCESS.T_PRCS_LOG_2`
(
  AGGREGATE,
  DWH_NODE_CD,
  COUNTRY_CD,
  DWH_CAL_DT,
  LOC_SID,
  RECALC_FG,
  STATUS_2,
  DWH_LOAD_ID,
  CREATE_TMSP,
  UPDATE_TMSP,
  START_TMSP,
  END_TMSP
)
WITH curr_delta AS (
  SELECT DISTINCT country_cd, dwh_cal_dt, loc_sid
  FROM `${BQ_PROJECT_ID}.ETL_PROCESS.T_PRCS_LOG_2`
  WHERE dwh_load_id = ${LOAD_ID}
),

curr_delta1 AS (
SELECT DATE_SUB(MIN(dwh_cal_dt), INTERVAL SV_DAY_BACK_CNT DAY) as dwh_cal_dt
      FROM curr_delta),

other_ret_dates AS (
  SELECT DISTINCT
    prl2.STORE_SID,
    prl2.COUNTRY_ORG_CD,
    prl2.BUS_DT
  FROM curr_delta cd
  JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE_2` prl
    ON prl.STORE_SID = cd.loc_sid
    AND prl.COUNTRY_ORG_CD = cd.country_cd
    AND prl.BUS_DT = cd.dwh_cal_dt
    AND prl.RETAIL_EVENT_LINE_SCENARIO_ID BETWEEN 140 AND 149
  JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE_2` prl2
    ON prl2.COUNTRY_ORG_CD = prl.COUNTRY_ORG_CD
    AND prl2.RETAIL_EVENT_LINE_SCENARIO_ID BETWEEN 140 AND 149
    AND prl2.ORIG_SALES_EVENT_SID = prl.ORIG_SALES_EVENT_SID
    AND prl2.RETAIL_EVENT_SID != prl.RETAIL_EVENT_SID
    INNER JOIN curr_delta1 ON TRUE
WHERE prl2.BUS_DT >= curr_delta1.dwh_cal_dt
    -- AND prl2.BUS_DT >= (
    --   SELECT DATE_SUB(MIN(dwh_cal_dt), INTERVAL SV_DAY_BACK_CNT DAY)
    --   FROM curr_delta
    -- )
)

SELECT
  't_fact_fraud_detection_by_cash_register_event_2',
  'CORE_DIM',
  ord.COUNTRY_ORG_CD,
  ord.BUS_DT,
  ord.STORE_SID,
  0,
  0,
  ${LOAD_ID},
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
FROM other_ret_dates ord
LEFT JOIN curr_delta cd
  ON ord.STORE_SID = cd.loc_sid
  AND ord.COUNTRY_ORG_CD = cd.country_cd
  AND ord.BUS_DT = cd.dwh_cal_dt
WHERE cd.loc_sid IS NULL;

-- ========================================================================
-- PART 2: INSERT DELTA FOR PARAMETER CHANGES
-- ========================================================================

INSERT INTO `${BQ_PROJECT_ID}.ETL_PROCESS.T_PRCS_LOG_2`
(
  AGGREGATE,
  DWH_NODE_CD,
  COUNTRY_CD,
  DWH_CAL_DT,
  LOC_SID,
  RECALC_FG,
  STATUS_2,
  DWH_LOAD_ID,
  CREATE_TMSP,
  UPDATE_TMSP,
  START_TMSP,
  END_TMSP
)
WITH country_param_update AS (
  SELECT
    country_org_cd,
    MAX(PARAM_LAST_UPDATE_TMSP) AS country_param_max_tmsp
  FROM `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2`
  WHERE SCENARIO_TYPE_CD = 'AUTO'
  GROUP BY country_org_cd
),
country_data_load AS (
  SELECT
    io.country_org_cd,
    MIN(fe.dwh_updated_tmsp) AS country_load_min_tmsp
  FROM `${BQ_PROJECT_ID}.CORE_DIM.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_2` fe
  JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2` io
    ON io.int_org_sid = fe.store_sid
    AND io.dwh_valid_fg = TRUE
  WHERE bus_dt >= SV_START_DT
  GROUP BY io.country_org_cd
),
stores_for_reload AS (
  SELECT
    cdl.country_org_cd,
    io_st.int_org_sid AS store_sid
  FROM country_param_update cpu
  JOIN country_data_load cdl
    ON cdl.country_org_cd = cpu.country_org_cd
    AND cdl.country_load_min_tmsp < cpu.country_param_max_tmsp
  JOIN `${BQ_PROJECT_ID}.CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2` io_st
    ON io_st.country_org_cd = cdl.country_org_cd
    AND io_st.dwh_valid_fg = TRUE
    AND io_st.int_org_type_cd = 'STORE'
),
days_last8_weeks AS (
  SELECT DATE_ADD(SV_START_DT, INTERVAL x DAY) AS dt_val
  FROM UNNEST(GENERATE_ARRAY(0, SV_DATEDIFF - 1)) AS x
)
SELECT
  't_fact_fraud_detection_by_cash_register_event_2',
  'CORE_DIM',
  sfr.country_org_cd,
  d.dt_val,
  sfr.store_sid,
  0,
  0,
  ${LOAD_ID},
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
FROM stores_for_reload sfr
CROSS JOIN days_last8_weeks d;
