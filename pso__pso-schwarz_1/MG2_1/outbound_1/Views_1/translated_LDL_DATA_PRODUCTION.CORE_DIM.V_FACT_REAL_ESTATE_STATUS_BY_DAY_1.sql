CREATE OR REPLACE VIEW ldl_data_production_core_dim.v_fact_real_estate_status_by_day_1 AS WITH all_stats_asof_now AS (SELECT
   re.real_estate_sid,
   re.dwh_valid_from_tmsp,
   re.dwh_valid_to_tmsp,
   cd.cal_dt,
   re.int_org_sid AS store_sid,
   cntr.country_org_sid,
   re.reporting_country_cd,
   cntr.country_org_cd,
   re.real_estate_status_cd,
    CASE
    WHEN re.real_estate_status_cd = 'OP'
    THEN 1
    ELSE 0
    END AS open_store_cnt,
    CASE
    WHEN re.real_estate_status_cd = 'CL'
    THEN 1
    ELSE 0
    END AS closed_store_cnt,
    CASE
    WHEN re.real_estate_status_cd = 'UC'
    THEN 1
    WHEN re.real_estate_status_cd = 'CN'
    THEN 1
    ELSE 0
    END AS store_under_contract_cnt,
    CASE
    WHEN re.real_estate_status_cd = 'CN'
    THEN 1
    WHEN re.real_estate_status_cd = 'TE'
    THEN 1
    ELSE 0
    END AS cancel_term_store_cnt,
    CASE
    WHEN re.real_estate_status_cd = 'UC'
    THEN 1
    ELSE 0
    END AS store_to_be_built_cnt,
    CASE
    WHEN re.ownership_type_cd IN ('B', 'L') AND re.real_estate_status_cd = 'UC'
    THEN 1
    ELSE 0
    END AS own_store_to_be_built_cnt,
    CASE
    WHEN re.ownership_type_cd IN ('B', 'L') AND re.real_estate_status_cd = 'OP'
    THEN 1
    ELSE 0
    END AS own_open_store_cnt,
   re.ownership_type_cd,
   rel.open_dt,
   rel.close_dt,
   DATE_DIFF(cd.cal_dt, rel.open_dt, DAY) AS days_since_opening,
   DATE_DIFF(cd.cal_dt, rel.close_dt, DAY) AS days_since_closure,
   re.sales_area_meas,
   IFNULL(re.total_sublet_area_meas, 0) AS total_sublet_area_meas,
   IFNULL(re.rented_sublet_area_meas, 0) AS rented_sublet_area_meas
  FROM ldl_data_production_core_dim.t_dim_real_estate_1 AS re_1
   INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle_1 AS rel ON re.real_estate_sid = rel.real_estate_sid
    
   INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_1 AS cd ON cd.cal_dt BETWEEN CAST(re.dwh_valid_from_tmsp AS DATE)
    AND (CAST(re.dwh_valid_to_tmsp AS DATE))
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_1 AS cntr ON cntr.country_org_cd = SUBSTR(re.real_estate_nr
       , 1, 2) AND cntr.is_country_org_fg AND cd.cal_dt BETWEEN CAST(cntr.dwh_valid_from_tmsp AS DATE) AND (CAST(cntr.dwh_valid_to_tmsp AS DATE)
      )), prev_stats AS (SELECT ASAN.real_estate_sid,
   py.cal_dt,
   py.bus_year_diff,
   ASAN.country_org_cd,
   ASAN.reporting_country_cd,
   SUM(ASAN.open_store_cnt) AS open_store_cnt,
   SUM(ASAN.closed_store_cnt) AS closed_store_cnt,
   SUM(ASAN.store_under_contract_cnt) AS store_under_contract_cnt,
   SUM(ASAN.store_to_be_built_cnt) AS store_to_be_built_cnt
  FROM all_stats_asof_now AS ASAN
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS py ON ASAN.cal_dt = py.rel_cal_dt
  WHERE py.bus_year_diff IN (1, 2)
   AND py.cal_dt_adjust_type_cd = 'M'
   AND py.cal_dt < CURRENT_DATE
  GROUP BY ASAN.real_estate_sid,
   py.cal_dt,
   py.bus_year_diff,
   ASAN.country_org_cd,
   ASAN.reporting_country_cd) (SELECT COALESCE(ASAN.real_estate_sid, PY.real_estate_sid, PPY.real_estate_sid) AS
   real_estate_sid,
   ASAN.store_sid,
   ASAN.country_org_sid,
   COALESCE(ASAN.country_org_cd, PY.country_org_cd, PPY.country_org_cd) AS country_org_cd,
   COALESCE(ASAN.reporting_country_cd, PY.reporting_country_cd, PPY.reporting_country_cd) AS reporting_country_cd,
   COALESCE(ASAN.cal_dt, PY.cal_dt, PPY.cal_dt) AS cal_dt,
   ASAN.real_estate_status_cd,
   IFNULL(ASAN.open_store_cnt, 0) AS open_store_cnt,
   IFNULL(PY.open_store_cnt, 0) AS open_store_py_cnt,
   IFNULL(PPY.open_store_cnt, 0) AS open_store_ppy_cnt,
   IFNULL(ASAN.closed_store_cnt, 0) AS closed_store_cnt,
   IFNULL(PY.closed_store_cnt, 0) AS closed_store_py_cnt,
   IFNULL(PPY.closed_store_cnt, 0) AS closed_store_ppy_cnt,
   IFNULL(ASAN.store_under_contract_cnt, 0) AS store_under_contract_cnt,
   IFNULL(PY.store_under_contract_cnt, 0) AS store_under_contract_py_cnt,
   IFNULL(PPY.store_under_contract_cnt, 0) AS store_under_contract_ppy_cnt,
   IFNULL(ASAN.store_to_be_built_cnt, 0) AS store_to_be_built_cnt,
   IFNULL(PY.store_to_be_built_cnt, 0) AS store_to_be_built_py_cnt,
   IFNULL(PPY.store_to_be_built_cnt, 0) AS store_to_be_built_ppy_cnt,
   ASAN.cancel_term_store_cnt,
   ASAN.own_store_to_be_built_cnt,
   ASAN.own_open_store_cnt,
   ASAN.ownership_type_cd,
   ASAN.open_dt,
   ASAN.close_dt,
   ASAN.days_since_opening,
   ASAN.days_since_closure,
   ASAN.sales_area_meas,
   ASAN.total_sublet_area_meas,
   ASAN.rented_sublet_area_meas
  FROM all_stats_asof_now AS ASAN
   FULL JOIN prev_stats AS PY ON ASAN.real_estate_sid = PY.real_estate_sid AND ASAN.cal_dt = PY.cal_dt AND PY.bus_year_diff
      = 1
   FULL JOIN prev_stats AS PPY ON PPY.real_estate_sid = IFNULL(ASAN.real_estate_sid, PY.real_estate_sid) AND PPY.cal_dt
      = IFNULL(ASAN.cal_dt, PY.cal_dt) AND PPY.bus_year_diff = 2);