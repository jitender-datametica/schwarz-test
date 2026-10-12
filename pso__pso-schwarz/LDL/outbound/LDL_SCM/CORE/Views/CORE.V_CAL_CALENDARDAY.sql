CREATE OR REPLACE VIEW ldl_scm_core.v_cal_calendarday AS WITH PUBLIC_CALENDAR_FLTRD AS (SELECT *
  FROM public.calendar
  WHERE calendar_date > DATE '2004-03-07'
   AND year_of_calendar <= EXTRACT(YEAR FROM CURRENT_DATE) + 10) (SELECT cal_dt,
   `_day_of_week` AS day_of_week,
   `_day_of_month` AS day_of_month,
   day_of_cy,
   cy,
   `_cy_week` AS cy_week,
   cy_week_99,
   cy_week_part,
   cy_month,
   cy_month_prev_1m,
   busyear,
   busyear_qtr,
   cal_dt_prev_1d,
   cal_dt_prev_7d,
   cal_dt_prev_1y,
   cal_dt_prev_2y,
   cal_dt_prev_3y,
   cal_dt_prev_4y,
   cal_dt_prev_5y,
   cal_dt_prev_yd,
   cal_dt_prev_md,
   cal_dt_prev_py,
   cal_dt_swday_prev_1y,
   cal_dt_swday_prev_2y,
   cal_dt_swday_prev_3y,
   cal_dt_swday_prev_4y,
   cal_dt_swday_prev_5y,
   cal_dt_swday_prev_1y_1w,
   cal_dt_last_day_prev_1w,
   cal_dt_last_day_prev_1m,
   cal_dt_last_day_prev_1y,
   cal_dt_first_day_next_1w,
   last_day_week_fg,
    CASE
    WHEN (ROW_NUMBER() OVER (PARTITION BY busyear, CAST(`_cy_week` AS STRING), cy_week_part ORDER BY `_day_of_week`
         IS NULL DESC, `_day_of_week` DESC)) = 1
    THEN 1
    ELSE 0
    END AS last_day_week_partial_fg,
   last_day_month_fg,
   last_day_year_fg,
   cy_day_seq,
   cy_week_seq,
   cy_month_seq,
   cy_year_seq,
   busyear_seq
  FROM (SELECT a.calendar_date AS cal_dt,
       EXTRACT(YEAR FROM a.calendar_date) * 100 + EXTRACT(MONTH FROM a.calendar_date) AS cy_month,
     ciso.x_day_of_week AS `_day_of_week`,
     EXTRACT(DAY FROM a.calendar_date) AS `_day_of_month`,
     a.day_of_year AS day_of_cy,
     EXTRACT(YEAR FROM a.calendar_date) AS cy,
       ciso.iso_year * 100 + ciso.iso_week AS `_cy_week`,
      CASE
      WHEN DATE(CAST(EXTRACT(YEAR FROM a.calendar_date) AS STRING) || '-03-01') BETWEEN DATE_ADD(DATE_SUB(a.calendar_date
          ,INTERVAL ciso.x_day_of_week DAY), INTERVAL 1 DAY) AND (DATE_SUB(DATE_ADD(a.calendar_date, INTERVAL 7 DAY)
          ,INTERVAL ciso.x_day_of_week DAY)) AND EXTRACT(MONTH FROM a.calendar_date) < 3
      THEN CAST(EXTRACT(YEAR FROM a.calendar_date) * 100 + 99 AS BIGNUMERIC)
      ELSE ciso.iso_year * 100 + ciso.iso_week
      END AS cy_week_99,
      CASE
      WHEN (RANK() OVER (PARTITION BY CAST(ciso.iso_year * 100 + ciso.iso_week AS STRING) ORDER BY (EXTRACT(YEAR FROM a
                .calendar_date) * 100 + EXTRACT(MONTH FROM a.calendar_date)) IS NULL, EXTRACT(YEAR FROM a.calendar_date
               ) * 100 + EXTRACT(MONTH FROM a.calendar_date))) > 1 OR (MIN(ciso.x_day_of_week) OVER (PARTITION BY CAST(ciso.iso_year * 100 + ciso.iso_week AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1
      THEN 2
      ELSE CAST(RANK() OVER (PARTITION BY CAST(ciso.iso_year * 100 + ciso.iso_week AS STRING) ORDER BY (EXTRACT(YEAR
              FROM a.calendar_date) * 100 + EXTRACT(MONTH FROM a.calendar_date)) IS NULL, EXTRACT(YEAR FROM a.calendar_date
             ) * 100 + EXTRACT(MONTH FROM a.calendar_date)) AS INTEGER)
      END AS cy_week_part,
       EXTRACT(YEAR FROM IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 1
           MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 1 MONTH))) * 100 + EXTRACT(MONTH FROM IF(a.calendar_date =
         LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 1 MONTH)), DATE_ADD(a.calendar_date,
         INTERVAL - 1 MONTH))) AS cy_month_prev_1m,
      CASE
      WHEN EXTRACT(MONTH FROM a.calendar_date) > 2
      THEN EXTRACT(YEAR FROM a.calendar_date)
      ELSE EXTRACT(YEAR FROM a.calendar_date) - 1
      END AS busyear,
         CASE
         WHEN EXTRACT(MONTH FROM a.calendar_date) > 2
         THEN EXTRACT(YEAR FROM a.calendar_date)
         ELSE EXTRACT(YEAR FROM a.calendar_date) - 1
         END * 10 + MOD(CAST(FLOOR(MOD(EXTRACT(YEAR FROM a.calendar_date) * 100 + EXTRACT(MONTH FROM a.calendar_date), 100) / 3.0) AS INTEGER)
         + 3, 4) + 1 AS busyear_qtr,
     DATE_SUB(a.calendar_date, INTERVAL 1 DAY) AS cal_dt_prev_1d,
     DATE_SUB(a.calendar_date, INTERVAL 7 DAY) AS cal_dt_prev_7d,
      CASE
      WHEN EXTRACT(MONTH FROM IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date,
            INTERVAL - 12 MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 12 MONTH))) = 2 AND EXTRACT(DAY FROM IF(a.calendar_date
            = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 MONTH)), DATE_ADD(a.calendar_date
           ,INTERVAL - 12 MONTH))) = 29
      THEN DATE_SUB(IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12
          MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 12 MONTH)), INTERVAL 1 DAY)
      ELSE IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 MONTH)),
       DATE_ADD(a.calendar_date, INTERVAL - 12 MONTH))
      END AS cal_dt_prev_1y,
      CASE
      WHEN EXTRACT(MONTH FROM IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date,
            INTERVAL - 24 MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 24 MONTH))) = 2 AND EXTRACT(DAY FROM IF(a.calendar_date
            = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 24 MONTH)), DATE_ADD(a.calendar_date
           ,INTERVAL - 24 MONTH))) = 29
      THEN DATE_SUB(IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 24
          MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 24 MONTH)), INTERVAL 1 DAY)
      ELSE IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 24 MONTH)),
       DATE_ADD(a.calendar_date, INTERVAL - 24 MONTH))
      END AS cal_dt_prev_2y,
      CASE
      WHEN EXTRACT(MONTH FROM IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date,
            INTERVAL - 12 * 3 MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 12 * 3 MONTH))) = 2 AND EXTRACT(DAY FROM IF(a
           .calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 * 3 MONTH)),
          DATE_ADD(a.calendar_date, INTERVAL - 12 * 3 MONTH))) = 29
      THEN DATE_SUB(IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 * 3
           MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 12 * 3 MONTH)), INTERVAL 1 DAY)
      ELSE IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 * 3 MONTH))
       , DATE_ADD(a.calendar_date, INTERVAL - 12 * 3 MONTH))
      END AS cal_dt_prev_3y,
     IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 * 4 MONTH)),
      DATE_ADD(a.calendar_date, INTERVAL - 12 * 4 MONTH)) AS cal_dt_prev_4y,
      CASE
      WHEN EXTRACT(MONTH FROM IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date,
            INTERVAL - 12 * 5 MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 12 * 5 MONTH))) = 2 AND EXTRACT(DAY FROM IF(a
           .calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 * 5 MONTH)),
          DATE_ADD(a.calendar_date, INTERVAL - 12 * 5 MONTH))) = 29
      THEN DATE_SUB(IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 * 5
           MONTH)), DATE_ADD(a.calendar_date, INTERVAL - 12 * 5 MONTH)), INTERVAL 1 DAY)
      ELSE IF(a.calendar_date = LAST_DAY(a.calendar_date), LAST_DAY(DATE_ADD(a.calendar_date, INTERVAL - 12 * 5 MONTH))
       , DATE_ADD(a.calendar_date, INTERVAL - 12 * 5 MONTH))
      END AS cal_dt_prev_5y,
     pyd.calendar_date AS cal_dt_prev_yd,
     pmd.calendar_date AS cal_dt_prev_md,
     ppy.calendar_date AS cal_dt_prev_py,
     DATE_SUB(ciso.calendar_date, INTERVAL 364 DAY) AS cal_dt_swday_prev_1y,
     DATE_SUB(ciso.calendar_date, INTERVAL 364 * 2 DAY) AS cal_dt_swday_prev_2y,
     DATE_SUB(ciso.calendar_date, INTERVAL 364 * 3 DAY) AS cal_dt_swday_prev_3y,
     DATE_SUB(ciso.calendar_date, INTERVAL 364 * 4 DAY) AS cal_dt_swday_prev_4y,
     DATE_SUB(ciso.calendar_date, INTERVAL 364 * 5 DAY) AS cal_dt_swday_prev_5y,
     DATE_SUB(DATE_SUB(ciso.calendar_date, INTERVAL 364 DAY), INTERVAL 7 DAY) AS cal_dt_swday_prev_1y_1w,
     DATE_SUB(a.calendar_date, INTERVAL ciso.x_day_of_week DAY) AS cal_dt_last_day_prev_1w,
     DATE_SUB(a.calendar_date, INTERVAL EXTRACT(DAY FROM a.calendar_date) DAY) AS cal_dt_last_day_prev_1m,
     DATE_SUB(a.calendar_date, INTERVAL CAST(ROUND(a.day_of_year) AS INTEGER) DAY) AS cal_dt_last_day_prev_1y,
     DATE_SUB(DATE_ADD(a.calendar_date, INTERVAL 7 DAY), INTERVAL MOD(DATE_DIFF(DATE_ADD(a.calendar_date, INTERVAL 7 DAY
         ), DATE '0001-01-01', DAY), 7) DAY) AS cal_dt_first_day_next_1w,
      CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR FROM a.calendar_date), CAST(ciso.iso_year * 100 + ciso.iso_week AS STRING)
           ORDER BY ciso.x_day_of_week IS NULL DESC, ciso.x_day_of_week DESC)) = 1
      THEN 1
      ELSE 0
      END AS last_day_week_fg,
      CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR FROM a.calendar_date), EXTRACT(YEAR FROM a.calendar_date) * 100
              + EXTRACT(MONTH FROM a.calendar_date) ORDER BY EXTRACT(DAY FROM a.calendar_date) IS NULL DESC, EXTRACT(DAY
            FROM a.calendar_date) DESC)) = 1
      THEN 1
      ELSE 0
      END AS last_day_month_fg,
      CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY EXTRACT(YEAR FROM a.calendar_date) ORDER BY a.day_of_year IS NULL DESC, a.day_of_year
           DESC)) = 1
      THEN 1
      ELSE 0
      END AS last_day_year_fg,
     DATE_DIFF(a.calendar_date, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY), DAY) AS cy_day_seq,
          EXTRACT(YEAR FROM a.calendar_date) * 100 + EXTRACT(MONTH FROM a.calendar_date) - EXTRACT(YEAR FROM a.calendar_date
          ) * 100 - EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) + (EXTRACT(YEAR FROM a.calendar_date) -
         EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))) * 12 AS cy_month_seq,
      EXTRACT(YEAR FROM a.calendar_date) - EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) AS cy_year_seq,
      DATE_DIFF(DATE_ADD(DATE_SUB(a.calendar_date, INTERVAL (MOD(DATE_DIFF(a.calendar_date, DATE '0001-01-01', DAY), 7)
           + 1) DAY), INTERVAL 1 DAY), DATE_ADD(DATE_SUB(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY), INTERVAL (MOD(DATE_DIFF(DATE_SUB(CURRENT_DATE
              ,INTERVAL 1 DAY), DATE '0001-01-01', DAY), 7) + 1) DAY), INTERVAL 1 DAY), DAY) / 7 AS cy_week_seq,
       CASE
       WHEN EXTRACT(MONTH FROM a.calendar_date) > 2
       THEN EXTRACT(YEAR FROM a.calendar_date)
       ELSE EXTRACT(YEAR FROM a.calendar_date) - 1
       END - CASE
       WHEN DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) < CAST(CAST(EXTRACT(YEAR FROM CURRENT_DATE) AS STRING) || '-03-01' AS
         DATE)
       THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
       ELSE EXTRACT(YEAR FROM CURRENT_DATE)
       END AS busyear_seq,
     0 AS dwh_load_id,
     CURRENT_TIMESTAMP() AS dwh_created,
     CURRENT_TIMESTAMP() AS dwh_updated
    FROM PUBLIC_CALENDAR_FLTRD AS a
     INNER JOIN (SELECT calendar_date,
        MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY), 7) + 1 AS x_day_of_week,
       DATE_ADD(DATE_SUB(calendar_date, INTERVAL MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY), 7) + 1 DAY),
        INTERVAL 4 DAY) AS iso_temp,
       EXTRACT(YEAR FROM DATE_ADD(DATE_SUB(calendar_date, INTERVAL MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY)
            , 7) + 1 DAY), INTERVAL 4 DAY)) AS iso_year,
        TRUNC(CAST(DATE_DIFF(DATE_ADD(DATE_SUB(calendar_date, INTERVAL (MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY), 7) + 1) DAY), INTERVAL 4 DAY), DATE(CAST(EXTRACT(YEAR FROM DATE_ADD(DATE_SUB(calendar_date, INTERVAL MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY), 7) + 1 DAY),
                 INTERVAL 4 DAY)) AS STRING) || '-01-01'), DAY) / 7 AS BIGNUMERIC)) + 1 AS iso_week
      FROM PUBLIC_CALENDAR_FLTRD) AS ciso ON a.calendar_date = ciso.calendar_date
     LEFT JOIN PUBLIC_CALENDAR_FLTRD AS pmd ON CASE
        WHEN pmd.month_of_year = 12
        THEN pmd.year_of_calendar * 100 + pmd.month_of_year + 89
        ELSE pmd.year_of_calendar * 100 + pmd.month_of_year + 1
        END = a.year_of_calendar * 100 + a.month_of_year AND a.day_of_month = pmd.day_of_month
     LEFT JOIN PUBLIC_CALENDAR_FLTRD AS pyd ON a.year_of_calendar = pyd.year_of_calendar + 1 AND a.month_of_year = pyd.month_of_year
         AND a.day_of_month = pyd.day_of_month
     LEFT JOIN (SELECT calendar_date,
        MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY), 7) + 1 AS x_day_of_week,
       DATE_ADD(DATE_SUB(calendar_date, INTERVAL MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY), 7) + 1 DAY),
        INTERVAL 4 DAY) AS iso_temp,
       EXTRACT(YEAR FROM DATE_ADD(DATE_SUB(calendar_date, INTERVAL MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY)
            , 7) + 1 DAY), INTERVAL 4 DAY)) AS iso_year,
        TRUNC(CAST(DATE_DIFF(DATE_ADD(DATE_SUB(calendar_date, INTERVAL (MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY), 7) + 1) DAY), INTERVAL 4 DAY), DATE(CAST(EXTRACT(YEAR FROM DATE_ADD(DATE_SUB(calendar_date, INTERVAL MOD(DATE_DIFF(calendar_date, DATE '0001-01-01', DAY), 7) + 1 DAY),
                 INTERVAL 4 DAY)) AS STRING) || '-01-01'), DAY) / 7 AS BIGNUMERIC)) + 1 AS iso_week
      FROM PUBLIC_CALENDAR_FLTRD) AS ppy ON ciso.iso_year - 2 = ppy.iso_year AND ciso.iso_week = ppy.iso_week AND ciso.x_day_of_week
        = ppy.x_day_of_week) AS a);