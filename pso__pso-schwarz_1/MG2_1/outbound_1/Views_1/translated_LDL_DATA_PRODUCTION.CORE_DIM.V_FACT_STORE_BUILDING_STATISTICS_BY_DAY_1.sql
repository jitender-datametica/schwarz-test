CREATE OR REPLACE VIEW ldl_data_production_core_dim.v_fact_store_building_statistics_by_day_1 AS WITH all_stats_asof_now
 AS (SELECT real_estate_sid,
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
  FROM ldl_data_production_core_dim.t_fact_real_estate_event_1 AS ree
  WHERE real_estate_event_type_cd IN ('OP', 'CL', 'CS')), prev_stats AS (SELECT ASAN.real_estate_sid,
   py.cal_dt,
   py.bus_year_diff,
   ASAN.country_org_cd,
   ASAN.reporting_country_cd,
   SUM(ASAN.opened_store_bld_cnt) AS opened_store_bld_cnt,
   SUM(ASAN.reloc_store_bld_cnt) AS reloc_store_bld_cnt,
   SUM(ASAN.replaced_store_bld_cnt) AS replaced_store_bld_cnt,
   SUM(ASAN.closed_store_bld_cnt) AS closed_store_bld_cnt,
   SUM(ASAN.bld_contract_cnt) AS bld_contract_cnt
  FROM all_stats_asof_now AS ASAN
   INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship_1 AS py ON ASAN.cal_dt = py.rel_cal_dt
    -- 02.01.2022 FOR EXAMPLE

  WHERE py.bus_year_diff IN (1, 2)
   AND py.cal_dt_adjust_type_cd = 'M'
   AND py.cal_dt < CURRENT_DATE
  GROUP BY ASAN.real_estate_sid,
   py.cal_dt,
   py.bus_year_diff,
   ASAN.country_org_cd,
   ASAN.reporting_country_cd) (-- 1202501  NEUERÖFFNUNG - FILIALE (ANZ.), ALL OPEN EVENTS, REGARDLESS OF THE REASON

  -- 1202502  UMZUG-FILIALE (ANZ.), BUIDLING OPENED ONLY BECASUE OF RELOCATION

  -- 1202512  ERSATZ - FILIALE (ANZ.), ANY OPENING OF A NEW BUILDING THAT REPLACES PREV BUILDING (RELOCATION, RECONSTRUCTION, MERGE).

  -- 1204501	SCHLIEßUNGEN FILIALE (ANZ.)
 -- 1201503  VERTRAGSABSCHLÜSSE (ANZ.)

  -- RECORDS FROM YEAR X (2022 FOR EXAMPLE) ARE ASSOCIATED WITH X+1 (2023 FOR EXAMPLE) FOR THE PY COLS OF 2023
 SELECT
   COALESCE(ASAN.real_estate_sid, PY.real_estate_sid, PPY.real_estate_sid) AS real_estate_sid,
   io_ctr.int_org_sid AS country_org_sid,
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
  FROM all_stats_asof_now AS ASAN
   FULL JOIN prev_stats AS PY ON ASAN.real_estate_sid = PY.real_estate_sid AND ASAN.cal_dt = PY.cal_dt AND PY.bus_year_diff
      = 1
   FULL JOIN prev_stats AS PPY ON PPY.real_estate_sid = IFNULL(ASAN.real_estate_sid, PY.real_estate_sid) AND PPY.cal_dt
      = IFNULL(ASAN.cal_dt, PY.cal_dt) AND PPY.bus_year_diff = 2
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_1 AS io_ctr ON ASAN.country_org_cd = io_ctr.country_org_cd
        AND io_ctr.int_org_type_cd = 'COMPANY' AND io_ctr.is_country_org_fg AND io_ctr.dwh_valid_fg);