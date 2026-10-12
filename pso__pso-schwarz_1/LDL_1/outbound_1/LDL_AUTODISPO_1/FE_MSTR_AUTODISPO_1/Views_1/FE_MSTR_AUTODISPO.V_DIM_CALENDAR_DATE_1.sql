/* Version:   1.2
    ** Author:    Dominik Pfarr
    ** Date:      2024-01-08
    ** Changes:   adjusting week sequence */
CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_dim_calendar_date_1 AS WITH TIMERANGE AS (SELECT DATE_SUB(DATE_ADD(DATE(CAST(EXTRACT(YEAR
          FROM CURRENT_DATE) - 6 AS STRING) || '-01-01'), INTERVAL ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) DAY),
    INTERVAL 1 DAY) AS cal_dt
  FROM UNNEST(GENERATE_ARRAY(0, 364.25*8)) AS SEQ) (SELECT cal_dt,
   CAST(FORMAT_DATE('%u', cal_dt) AS INTEGER) AS day_of_week,
   EXTRACT(ISOWEEK FROM cal_dt) AS week_id,
   EXTRACT(MONTH FROM cal_dt) AS month_id,
     CAST(EXTRACT(ISOYEAR FROM cal_dt) AS STRING) || '-' || LPAD(SUBSTR(CAST(EXTRACT(ISOWEEK FROM cal_dt) AS STRING), 1
      , 19), 2, '0') AS cy_week,
   EXTRACT(YEAR FROM cal_dt) AS cy,
   DATE_DIFF(cal_dt, CURRENT_DATE, DAY) AS day_sequence,
   DATE_DIFF(cal_dt, CURRENT_DATE, WEEK) AS week_sequence
  FROM TIMERANGE AS t2);