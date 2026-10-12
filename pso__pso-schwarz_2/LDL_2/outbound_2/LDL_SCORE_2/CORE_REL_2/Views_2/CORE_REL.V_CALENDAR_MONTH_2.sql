CREATE OR REPLACE VIEW ldl_score_core_rel.v_calendar_month_2 AS SELECT year.year * 100 + month.month AS cy_month,
 month.month AS month_of_year,
 year.year AS cy,
  CASE
  WHEN month.month BETWEEN 1 AND 2
  THEN year.year - 1
  ELSE year.year
  END AS bus_year,
   month.month_of_year_name || ' ' || CAST(year.year AS STRING) AS cy_month_descr,
   month.month_of_year_short || ' ' || CAST(year.year AS STRING) AS cy_month_short_descr,
 DATE_DIFF(DATE(CAST(year.year * 100 + month.month AS STRING)), CURRENT_DATE, MONTH) AS cy_month_seq
FROM (SELECT ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) AS month,
    CASE
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 1
    THEN 'Januar'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 2
    THEN 'Februar'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 3
    THEN 'März'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 4
    THEN 'April'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 5
    THEN 'Mai'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 6
    THEN 'Juni'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 7
    THEN 'Juli'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 8
    THEN 'August'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 9
    THEN 'September'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 10
    THEN 'Oktober'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 11
    THEN 'November'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 12
    THEN 'Dezember'
    ELSE NULL
    END AS month_of_year_name,
    CASE
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 1
    THEN 'Jan'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 2
    THEN 'Feb'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 3
    THEN 'Mär'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 4
    THEN 'Apr'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 5
    THEN 'Mai'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 6
    THEN 'Jun'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 7
    THEN 'Jul'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 8
    THEN 'Aug'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 9
    THEN 'Sep'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 10
    THEN 'Okt'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 11
    THEN 'Nov'
    WHEN (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) = 12
    THEN 'Dez'
    ELSE NULL
    END AS month_of_year_short
  FROM UNNEST(GENERATE_ARRAY(0, 11)) AS SEQ) AS month
 INNER JOIN (SELECT EXTRACT(YEAR FROM CURRENT_DATE) - 10 + (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) AS year
  FROM UNNEST(GENERATE_ARRAY(0, 11)) AS SEQ) AS year ON TRUE;