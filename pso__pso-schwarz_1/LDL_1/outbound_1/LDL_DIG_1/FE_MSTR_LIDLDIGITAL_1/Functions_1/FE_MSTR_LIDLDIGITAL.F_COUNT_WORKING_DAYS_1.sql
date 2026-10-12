CREATE OR REPLACE FUNCTION fe_mstr_lidldigital.f_count_working_days(DATE1 DATE, DATE2 DATE)
RETURNS INT64
AS (
  (
    SELECT COUNT(1) AS working_days
  FROM core.t_dim_cal_day_1 AS dim_cd
  WHERE dim_cd.cal_dt BETWEEN DATE1 AND DATE2
    AND dim_cd.day_of_week_short_name IN ('Mo', 'Di', 'Mi', 'Do', 'Fr')
  )
);
