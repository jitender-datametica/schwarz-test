CREATE OR REPLACE VIEW ldl_data_core_dim.v_fact_store_building_statistics_by_day_1 (real_estate_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE REAL ESTATE OBJECT.'), country_org_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED COUNTRY_1 ORGANIZATION.'), country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY_1 FOR WHICH THIS COUNTRY_1 ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY_1 IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
reporting_country_cd
OPTIONS(description='THE CODE WHICH IDENTIFIES THE REPORTING COUNTRY_1 IN WHICH THE INTERNAL ORGANIZATION IS LOCATED.'),
cal_dt
OPTIONS(description='THE DAY REPRESENTED AS A CALENDAR_1 DATE OF THE FORM YYYY-MM_1-DD. YYYY IS THE CALENDAR_1 YEAR, MM_1 (BETWEEN 1 AND 12) THE CALENDAR_1 MONTH AND DD THE DAY OF THE CALENDAR_1 MONTH (BETWEEN 1 AND 31). '),
opened_store_bld_cnt OPTIONS(description='THE OPEN STORES COUNT ON THE GIVEN DAY (KPI 1202501)'),
opened_store_bld_py_cnt
OPTIONS(description='THE OPEN STORES COUNT ON THE SAME CALENDAR_1 DATE ONE YEAR AGO (KPI 1202501)'),
opened_store_bld_ppy_cnt
OPTIONS(description='THE OPEN STORES COUNT ON THE SAME CALENDAR_1 DATE TWO YEARS AGO (KPI 1202501)'), reloc_store_bld_cnt
OPTIONS(description='THE RELOCATED STORES COUNT ON THE GIVEN DAY (KPI 1202502)'), reloc_store_bld_py_cnt
OPTIONS(description='THE RELOCATED STORES COUNT ON THE SAME CALENDAR_1 DATE ONE YEAR AGO (KPI 1202502)'),
reloc_store_bld_ppy_cnt
OPTIONS(description='THE RELOCATED STORES COUNT ON THE SAME CALENDAR_1 DATE TWO YEARS AGO (KPI 1202502)'),
replaced_store_bld_cnt OPTIONS(description='THE REPLACED STORES COUNT ON THE GIVEN DAY (KPI 1202512)'),
replaced_store_bld_py_cnt
OPTIONS(description='THE REPLACED STORES COUNT ON THE SAME CALENDAR_1 DATE ONE YEAR AGO (KPI 1202512)'),
replaced_store_bld_ppy_cnt
OPTIONS(description='THE REPLACED STORES COUNT ON THE SAME CALENDAR_1 DATE TWO YEARS AGO (KPI 1202512)'),
closed_store_bld_cnt OPTIONS(description='THE CLOSED STORES COUNT ON THE GIVEN DAY (KPI 1204501)'),
closed_store_bld_py_cnt
OPTIONS(description='THE CLOSED STORES COUNT ON THE SAME CALENDAR_1 DATE ONE YEAR AGO (KPI 1204501)'),
closed_store_bld_ppy_cnt
OPTIONS(description='THE CLOSED STORES COUNT ON THE SAME CALENDAR_1 DATE TWO YEARS AGO (KPI 1204501)'), bld_contract_cnt
OPTIONS(description='THE COUNT OF BUILDING CONTRACTS SIGNED ON THE GIVEN DAY (KPI 1201503)'), bld_contract_py_cnt
OPTIONS(description='THE COUNT OF BUILDING CONTRACTS SIGNED ON THE SAME CALENDAR_1 DATE ONE YEAR AGO (KPI 1201503)'),
bld_contract_ppy_cnt
OPTIONS(description='THE COUNT OF BUILDING CONTRACTS SIGNED ON THE SAME CALENDAR_1 DATE TWO YEARS AGO (KPI 1201503)')) AS
WITH ALL_STATS_ASOF_NOW AS (SELECT real_estate_sid,
   bus_dt AS cal_dt,
   country_org_cd,
   reporting_country_cd,
    CASE
    WHEN real_estate_event_type_cd = 'OP'
    THEN 1
    ELSE 0
    END AS opened_store_bld_cnt,
    CASE
    WHEN real_estate_event_reason_cd = 'BS_OP_REL'
    THEN 1
    ELSE 0
    END AS reloc_store_bld_cnt,
    CASE
    WHEN real_estate_event_reason_cd = 'BS_OP_REL'
    THEN 1
    WHEN real_estate_event_reason_cd = 'BS_OP_RCN'
    THEN 1
    WHEN real_estate_event_reason_cd = 'BS_OP_MRG'
    THEN 1
    ELSE 0
    END AS replaced_store_bld_cnt,
    CASE
    WHEN real_estate_event_type_cd = 'CL'
    THEN 1
    ELSE 0
    END AS closed_store_bld_cnt,
    CASE
    WHEN real_estate_event_type_cd = 'CS'
    THEN 1
    ELSE 0
    END AS bld_contract_cnt
  FROM ldl_data_core_dim.t_fact_real_estate_event_1 AS REE
  WHERE real_estate_event_type_cd IN ('OP', 'CL', 'CS')), PREV_STATS AS (SELECT ASAN.real_estate_sid,
   PY.cal_dt,
   PY.bus_year_diff,
   ASAN.country_org_cd,
   ASAN.reporting_country_cd,
   SUM(ASAN.opened_store_bld_cnt) AS opened_store_bld_cnt,
   SUM(ASAN.reloc_store_bld_cnt) AS reloc_store_bld_cnt,
   SUM(ASAN.replaced_store_bld_cnt) AS replaced_store_bld_cnt,
   SUM(ASAN.closed_store_bld_cnt) AS closed_store_bld_cnt,
   SUM(ASAN.bld_contract_cnt) AS bld_contract_cnt
  FROM ALL_STATS_ASOF_NOW AS ASAN
   INNER JOIN ldl_data_core_rel.t_cal_date_adjusted_relationship_1 AS PY ON ASAN.cal_dt = PY.rel_cal_dt
  WHERE PY.bus_year_diff IN (1, 2)
   AND PY.cal_dt_adjust_type_cd = 'M'
   AND PY.cal_dt < CURRENT_DATE
  GROUP BY ASAN.real_estate_sid,
   PY.cal_dt,
   PY.bus_year_diff,
   ASAN.country_org_cd,
   ASAN.reporting_country_cd) (SELECT COALESCE(ASAN.real_estate_sid, PY.real_estate_sid, PPY.real_estate_sid) AS
   real_estate_sid,
   IO_CTR.int_org_sid AS country_org_sid,
   COALESCE(ASAN.country_org_cd, PY.country_org_cd, PPY.country_org_cd) AS country_org_cd,
   COALESCE(ASAN.reporting_country_cd, PY.reporting_country_cd, PPY.reporting_country_cd) AS reporting_country_cd,
   COALESCE(ASAN.cal_dt, PY.cal_dt, PPY.cal_dt) AS cal_dt,
   IFNULL(ASAN.opened_store_bld_cnt, 0) AS opened_store_bld_cnt,
   IFNULL(PY.opened_store_bld_cnt, 0) AS opened_store_bld_py_cnt,
   IFNULL(PPY.opened_store_bld_cnt, 0) AS opened_store_bld_ppy_cnt,
   IFNULL(ASAN.reloc_store_bld_cnt, 0) AS reloc_store_bld_cnt,
   IFNULL(PY.reloc_store_bld_cnt, 0) AS reloc_store_bld_py_cnt,
   IFNULL(PPY.reloc_store_bld_cnt, 0) AS reloc_store_bld_ppy_cnt,
   IFNULL(ASAN.replaced_store_bld_cnt, 0) AS replaced_store_bld_cnt,
   IFNULL(PY.replaced_store_bld_cnt, 0) AS replaced_store_bld_py_cnt,
   IFNULL(PPY.replaced_store_bld_cnt, 0) AS replaced_store_bld_ppy_cnt,
   IFNULL(ASAN.closed_store_bld_cnt, 0) AS closed_store_bld_cnt,
   IFNULL(PY.closed_store_bld_cnt, 0) AS closed_store_bld_py_cnt,
   IFNULL(PPY.closed_store_bld_cnt, 0) AS closed_store_bld_ppy_cnt,
   IFNULL(ASAN.bld_contract_cnt, 0) AS bld_contract_cnt,
   IFNULL(PY.bld_contract_cnt, 0) AS bld_contract_py_cnt,
   IFNULL(PPY.bld_contract_cnt, 0) AS bld_contract_ppy_cnt
  FROM ALL_STATS_ASOF_NOW AS ASAN
   FULL JOIN PREV_STATS AS PY ON ASAN.real_estate_sid = PY.real_estate_sid AND ASAN.cal_dt = PY.cal_dt AND PY.bus_year_diff
      = 1
   FULL JOIN PREV_STATS AS PPY ON PPY.real_estate_sid = IFNULL(ASAN.real_estate_sid, PY.real_estate_sid) AND PPY.cal_dt
      = IFNULL(ASAN.cal_dt, PY.cal_dt) AND PPY.bus_year_diff = 2
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS IO_CTR ON ASAN.country_org_cd = IO_CTR.country_org_cd AND
       IO_CTR.int_org_type_cd = 'COMPANY' AND IO_CTR.is_country_org_fg AND IO_CTR.dwh_valid_fg);