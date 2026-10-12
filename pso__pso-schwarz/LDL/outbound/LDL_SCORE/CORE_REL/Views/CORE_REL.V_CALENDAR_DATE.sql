CREATE OR REPLACE VIEW ldl_score_core_rel.v_calendar_date AS WITH TIMERANGE AS (SELECT DATE_SUB(DATE_ADD(DATE(CAST(EXTRACT(YEAR FROM CURRENT_DATE) - 10 AS STRING)
       || '-01-01'), INTERVAL ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) DAY), INTERVAL 1 DAY) AS cal_dt
  FROM UNNEST(GENERATE_ARRAY(0, 364*12)) AS SEQ) (SELECT cal_dt,
   CAST(FORMAT_DATE('%u', cal_dt) AS INTEGER) AS day_of_week,
   EXTRACT(MONTH FROM cal_dt) AS month_of_year,
    CAST(FORMAT_DATE('%u', cal_dt) AS INTEGER) IN (6, 7) AS weekend_fg,
   EXTRACT(DAYOFYEAR FROM cal_dt) AS day_of_cy,
     EXTRACT(YEAR FROM cal_dt) * 100 + EXTRACT(MONTH FROM cal_dt) AS cy_month,
     EXTRACT(ISOYEAR FROM cal_dt) * 100 + EXTRACT(ISOWEEK FROM cal_dt) AS cy_week,
   EXTRACT(YEAR FROM cal_dt) AS cy,
    EXTRACT(YEAR FROM cal_dt) - CASE
     WHEN EXTRACT(MONTH FROM cal_dt) IN (1, 2)
     THEN 1
     ELSE 0
     END AS bus_year,
   DATE_SUB(cal_dt, INTERVAL 7 DAY) AS cal_dt_prev_7d,
   DATE_SUB(cal_dt, INTERVAL 364 DAY) AS cal_dt_swday_prev_1y,
   DATE_DIFF(cal_dt, CURRENT_DATE, DAY) AS cy_day_seq
  FROM TIMERANGE AS t2);
