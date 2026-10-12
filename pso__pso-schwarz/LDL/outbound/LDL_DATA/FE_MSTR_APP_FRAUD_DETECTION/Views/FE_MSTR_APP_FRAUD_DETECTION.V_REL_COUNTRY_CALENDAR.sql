CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_rel_country_calendar (cal_dt
OPTIONS(description='A calendar day ,'), country_org_sid
OPTIONS(description='Organizational Country techinical Identifier'), country_org_cd
OPTIONS(description='Country ISO identifier'), holiday_name OPTIONS(description='Name of National Holiday'), holiday_fg
OPTIONS(description='Flag showing if on given day there is any National Holiday'), holiday_dt
OPTIONS(description='Holiday date only filled on holidays'), cal_dt_offset OPTIONS(description='Offset of calendar day'))
AS WITH CNTY_DATE_INTERVAL AS (SELECT country_org_sid,
   MAX(country_org_cd) AS country_org_cd,
   GREATEST(MIN(open_dt), DATE('2013-01-01')) AS start_dt,
   DATE(CAST(EXTRACT(YEAR FROM CURRENT_DATE) + 2 AS STRING) || '-03-01') AS end_dt
  FROM ldl_data_core_dim.t_dim_internal_organization AS ORG
  GROUP BY country_org_sid) (SELECT CAL.cal_dt,
   t1.country_org_sid,
   t1.country_org_cd,
   HOL.holiday_name,
   CAST(CASE
     WHEN HOL.holiday_name IS NOT NULL
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) AS holiday_fg,
   HOL.cal_dt AS holiday_dt,
   CAL.cal_dt_offset
  FROM ldl_data_core_dim.t_dim_calendar_date AS CAL
   INNER JOIN CNTY_DATE_INTERVAL AS t1 ON CAL.cal_dt BETWEEN t1.start_dt AND t1.end_dt
   LEFT JOIN ldl_data_core_dim.t_fact_national_holiday AS HOL ON CAL.cal_dt = HOL.cal_dt AND t1.country_org_cd = HOL.iso_country_cd
     );