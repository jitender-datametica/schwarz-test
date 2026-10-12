CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_rel_country_calendar AS WITH cnty_date_interval
 AS (SELECT country_org_sid,
   MAX(country_org_cd) AS country_org_cd,
   GREATEST(MIN(open_dt), DATE('2013-01-01')) AS start_dt,
   DATE(CAST(EXTRACT(YEAR FROM CURRENT_DATE) + 2 AS STRING) || '-03-01') AS end_dt
  FROM ldl_data_production_core_dim.t_dim_internal_organization AS org
  GROUP BY country_org_sid) (SELECT cal.cal_dt,
   t1.country_org_sid,
   t1.country_org_cd,
   hol.holiday_name,
   CAST(CASE
     WHEN hol.holiday_name IS NOT NULL
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) AS holiday_fg,
   hol.cal_dt AS holiday_dt,
   cal.cal_dt_offset
  FROM ldl_data_production_core_dim.t_dim_calendar_date AS cal
   INNER JOIN cnty_date_interval AS t1 ON cal.cal_dt BETWEEN t1.start_dt AND t1.end_dt
   LEFT JOIN ldl_data_production_core_dim.t_fact_national_holiday AS hol ON cal.cal_dt = hol.cal_dt AND t1.country_org_cd
      = hol.iso_country_cd);