CREATE OR REPLACE VIEW ldl_data_etl.v_fact_turnover_fulldates_2 AS WITH INT_ORG_YEARS AS (SELECT t0.int_org_sid,
   t0.bus_year,
   t0.int_org_type_cd,
   FIRST_VALUE(t0.z0) OVER (PARTITION BY CAST(t0.int_org_sid AS STRING) ORDER BY t0.bus_year IS NULL, t0.bus_year
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS country_org_cd,
   t0.curr_cd
  FROM (SELECT F.int_org_sid,
     D1.bus_year,
     F.int_org_type_cd,
     F.curr_cd,
     MIN_BY(F.country_org_cd, F.bus_dt) AS z0
    FROM ldl_data_etl.t_tcache_fact_retail_by_store_day_2 AS F
     INNER JOIN ldl_data_core_dim.t_dim_calendar_date_2 AS D1 ON F.bus_dt = D1.cal_dt AND F.bus_dt <= CURRENT_DATE
    GROUP BY F.int_org_sid,
     F.int_org_type_cd,
     F.curr_cd,
     D1.bus_year) AS t0), INT_ORG_YEARS_EXTENDED AS (SELECT *
   FROM INT_ORG_YEARS
   UNION DISTINCT
   SELECT int_org_sid,
     bus_year + 1,
    int_org_type_cd,
    country_org_cd,
    curr_cd
   FROM INT_ORG_YEARS) (SELECT D2.cal_dt,
   D2.bus_year,
   IOYE.int_org_sid,
   IOYE.int_org_type_cd,
   IOYE.country_org_cd,
   IOYE.curr_cd
  FROM INT_ORG_YEARS_EXTENDED AS IOYE
   INNER JOIN ldl_data_core_dim.t_dim_calendar_date_2 AS D2 ON IOYE.bus_year = D2.bus_year
  WHERE D2.cal_dt <= CURRENT_DATE);