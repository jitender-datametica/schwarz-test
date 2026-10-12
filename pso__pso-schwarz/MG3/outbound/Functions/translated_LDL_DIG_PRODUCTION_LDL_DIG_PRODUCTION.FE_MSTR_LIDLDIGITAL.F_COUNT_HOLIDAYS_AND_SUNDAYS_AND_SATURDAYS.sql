CREATE OR REPLACE FUNCTION `ldl_dig_production_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays`(
  COUNTRY_CD STRING,
  DATE1 DATE,
  DATE2 DATE
)
RETURNS INT64
AS (
    (
        SELECT COUNT(1)
        FROM `ldl_dig_production_core.t_dim_cal_holiday_regional` AS DIM_CHR
        WHERE dim_chr.country_cd = country_cd
          AND dim_chr.cal_dt BETWEEN date1 AND date2
          AND dim_chr.day_of_week_short_name NOT IN ('So', 'Sa')
    )
    +
    (
        SELECT COUNT(1)
        FROM `ldl_dig_production_core.t_dim_cal_day` AS DIM_CD
        WHERE dim_cd.cal_dt BETWEEN date1 AND date2
          AND dim_cd.day_of_week_short_name IN ('So', 'Sa')
    )
);
