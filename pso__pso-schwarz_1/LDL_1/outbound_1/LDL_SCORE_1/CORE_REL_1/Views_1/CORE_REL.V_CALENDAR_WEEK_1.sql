
CREATE OR REPLACE VIEW ldl_score_core_rel.v_calendar_week_1 AS WITH TIMERANGE AS (SELECT DATE_SUB(DATE_ADD(DATE(CAST(EXTRACT(YEAR FROM CURRENT_DATE) - 10 AS STRING)
       || '-01-01'), INTERVAL ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) DAY), INTERVAL 1 DAY) AS cal_dt
  FROM UNNEST(GENERATE_ARRAY(0, 364*12)) AS SEQ), WEEK_LIST AS (SELECT cal_dt,
     EXTRACT(ISOYEAR FROM cal_dt) * 100 + EXTRACT(ISOWEEK FROM cal_dt) AS cy_week,
   EXTRACT(ISOWEEK FROM cal_dt) AS week_iso,
   EXTRACT(ISOYEAR FROM cal_dt) AS year_iso
  FROM TIMERANGE
  WHERE CAST(FORMAT_DATE('%u', cal_dt) AS INTEGER) = 1) (SELECT cy_week,
    'KW ' || LPAD(SUBSTR(CAST(week_iso AS STRING), 1, 19), 2, '0') AS week_desc,
   LAG(cy_week) OVER (ORDER BY cy_week IS NULL, cy_week) AS cy_week_prev_1w,
    CASE
    WHEN week_iso = 53
    THEN year_iso * 100 + 1
    ELSE cy_week - 100
    END AS cy_week_prev_1y,
   DATE_DIFF(cal_dt, CURRENT_DATE, WEEK) AS cy_week_seq
  FROM WEEK_LIST);