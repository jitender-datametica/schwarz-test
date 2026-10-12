CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_cal_qview_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT cal_dt AS dspy_dt,
 cal_dt,
 'C' AS cy_py_ind,
 cy_week
FROM ldl_p_lew_core_ac.v_cal_calendarday_1
WHERE cy_day_seq BETWEEN - 21 AND 0
UNION ALL
SELECT cal_dt AS dspy_dt,
 cal_dt_swday_prev_1y AS cal_dt,
 'P' AS cy_py_ind,
 cy_week
FROM ldl_p_lew_core_ac.v_cal_calendarday_1
WHERE cy_day_seq BETWEEN - 21 AND 0;

