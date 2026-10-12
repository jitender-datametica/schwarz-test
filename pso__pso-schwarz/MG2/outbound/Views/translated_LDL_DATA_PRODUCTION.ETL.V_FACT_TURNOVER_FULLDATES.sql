CREATE OR REPLACE VIEW ldl_data_production_etl.v_fact_turnover_fulldates AS WITH int_org_years AS (SELECT t0.int_org_sid
   ,
   t0.bus_year,
   t0.int_org_type_cd,
   FIRST_VALUE(t0.z0) OVER (PARTITION BY CAST(t0.int_org_sid AS STRING) ORDER BY t0.bus_year IS NULL, t0.bus_year
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS country_org_cd,
   t0.curr_cd
  FROM (SELECT f.int_org_sid,
     d1.bus_year,
     f.int_org_type_cd,
     f.curr_cd,
     MIN_BY(f.country_org_cd, f.bus_dt) AS z0
    FROM ldl_data_production_etl.t_tcache_fact_retail_by_store_day AS f
     INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date AS d1 ON f.bus_dt = d1.cal_dt AND f.bus_dt <=
       CURRENT_DATE
    GROUP BY f.int_org_sid,
     f.int_org_type_cd,
     f.curr_cd,
     d1.bus_year) AS t0), int_org_years_extended AS (SELECT *
   FROM int_org_years
   UNION DISTINCT
   SELECT int_org_sid,
     bus_year + 1,
    int_org_type_cd,
    country_org_cd,
    curr_cd
   FROM int_org_years) (SELECT d2.cal_dt,
   d2.bus_year,
   t12.int_org_sid,
   t12.int_org_type_cd,
   t12.country_org_cd,
   t12.curr_cd
  FROM int_org_years_extended AS t12
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date AS d2 ON t12.bus_year = d2.bus_year
  WHERE d2.cal_dt <= CURRENT_DATE);