CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_fact_store_building_statistics_by_day_curr_1 (real_estate_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE REAL ESTATE OBJECT.'), country_org_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE RELATED COUNTRY_1 ORGANIZATION.'), country_org_cd
OPTIONS(description='THE CODE OF THE BUSINESS COUNTRY_1 FOR WHICH THIS COUNTRY_1 ORGANIZATION IS RESPONSIBLE. (THE BUSINESS COUNTRY_1 IS NOT IDENTICAL TO A POLITICAL COUNTRY.)'),
reporting_country_cd
OPTIONS(description='THE CODE WHICH IDENTIFIES THE REPORTING COUNTRY_1 IN WHICH THE INTERNAL ORGANIZATION IS LOCATED.'),
cal_dt
OPTIONS(description='THE DAY REPRESENTED AS A CALENDAR_1 DATE OF THE FORM YYYY-MM_1-DD. YYYY IS THE CALENDAR_1 YEAR, MM_1 (BETWEEN 1 AND 12) THE CALENDAR_1 MONTH AND DD THE DAY OF THE CALENDAR_1 MONTH (BETWEEN 1 AND 31). '),
curr_cd OPTIONS(description='THE CODE IDENTIFYING THE CURRENCY, ACCORDING TO ISO 4217.'), curr_group_fg
OPTIONS(description='FLAG FOR GROUP CURRENCY'), curr_local_fg OPTIONS(description='FLAG FOR LOCAL CURRENCY'),
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
SELECT MAIN.real_estate_sid,
 MAIN.country_org_sid,
 MAIN.country_org_cd,
 MAIN.reporting_country_cd,
 MAIN.cal_dt,
 FER.src_curr_cd AS curr_cd,
  CASE
  WHEN FER.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN FER.src_curr_cd = FER.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg,
 MAIN.opened_store_bld_cnt,
 MAIN.opened_store_bld_py_cnt,
 MAIN.opened_store_bld_ppy_cnt,
 MAIN.reloc_store_bld_cnt,
 MAIN.reloc_store_bld_py_cnt,
 MAIN.reloc_store_bld_ppy_cnt,
 MAIN.replaced_store_bld_cnt,
 MAIN.replaced_store_bld_py_cnt,
 MAIN.replaced_store_bld_ppy_cnt,
 MAIN.closed_store_bld_cnt,
 MAIN.closed_store_bld_py_cnt,
 MAIN.closed_store_bld_ppy_cnt,
 MAIN.bld_contract_cnt,
 MAIN.bld_contract_py_cnt,
 MAIN.bld_contract_ppy_cnt
FROM ldl_data_core_dim.v_fact_store_building_statistics_by_day_1 AS MAIN
 INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS CO ON MAIN.country_org_sid = CO.int_org_sid
 INNER JOIN ldl_data_core_dim.t_fact_exchange_rate_1 AS FER ON CO.curr_cd = FER.tgt_curr_cd
WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
 AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
 AND FER.active_fg
 AND CO.dwh_valid_fg;