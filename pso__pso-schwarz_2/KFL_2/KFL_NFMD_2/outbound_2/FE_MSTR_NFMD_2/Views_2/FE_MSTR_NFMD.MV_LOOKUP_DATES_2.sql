CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_lookup_dates_2 AS WITH BASE_DATE AS (SELECT year_iso,
   week_iso,
   MIN(d) AS first_day,
   DATE_ADD(MIN(d), INTERVAL 3 DAY) AS thursday_of_week
  FROM (SELECT EXTRACT(ISOYEAR FROM DATE_ADD(DATE('2018-01-03'), INTERVAL (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) -
        1 DAY)) AS year_iso,
     EXTRACT(ISOWEEK FROM DATE_ADD(DATE('2018-01-03'), INTERVAL (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) - 1 DAY)
      ) AS week_iso,
     DATE_ADD(DATE('2018-01-03'), INTERVAL (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) - 1 DAY) AS d
    FROM UNNEST(GENERATE_ARRAY(0, 9999)) AS SEQ) AS t1_2
  GROUP BY year_iso,
   week_iso
  ORDER BY 1 NULLS LAST,
   2 NULLS LAST) (SELECT year_iso,
   week_iso,
   first_day,
   thursday_of_week,
    DATE_DIFF(CURRENT_DATE, first_day, WEEK) * - 1 AS akt_wo,
    CAST(year_iso AS STRING) || TRIM(CAST(week_iso AS STRING FORMAT '00')) AS kjwo
  FROM BASE_DATE
  WHERE year_iso >= 2021);