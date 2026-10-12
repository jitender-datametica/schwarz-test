CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_store_building_statistics_by_day_curr_1 (real_estate_sid
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
SELECT main.real_estate_sid,
 main.country_org_sid,
 main.country_org_cd,
 main.reporting_country_cd,
 main.cal_dt,
 fer.src_curr_cd AS curr_cd,
  CASE
  WHEN fer.src_curr_cd = 'EUR'
  THEN 1
  ELSE 0
  END AS curr_group_fg,
  CASE
  WHEN fer.src_curr_cd = fer.tgt_curr_cd
  THEN 1
  ELSE 0
  END AS curr_local_fg,
 main.opened_store_bld_cnt,
 main.opened_store_bld_py_cnt,
 main.opened_store_bld_ppy_cnt,
 main.reloc_store_bld_cnt,
 main.reloc_store_bld_py_cnt,
 main.reloc_store_bld_ppy_cnt,
 main.replaced_store_bld_cnt,
 main.replaced_store_bld_py_cnt,
 main.replaced_store_bld_ppy_cnt,
 main.closed_store_bld_cnt,
 main.closed_store_bld_py_cnt,
 main.closed_store_bld_ppy_cnt,
 main.bld_contract_cnt,
 main.bld_contract_py_cnt,
 main.bld_contract_ppy_cnt
FROM ldl_data_production_core_dim.v_fact_store_building_statistics_by_day_1 AS main
 INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_1 AS co ON main.country_org_sid = co.int_org_sid
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_1 AS fer ON co.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
 AND fer.active_fg
 AND co.dwh_valid_fg;