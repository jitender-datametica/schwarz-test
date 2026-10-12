CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_store_building_statistics_by_day_1 (real_estate_sid
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
SELECT real_estate_sid,
 country_org_sid,
 country_org_cd,
 reporting_country_cd,
 cal_dt,
 opened_store_bld_cnt,
 opened_store_bld_py_cnt,
 opened_store_bld_ppy_cnt,
 reloc_store_bld_cnt,
 reloc_store_bld_py_cnt,
 reloc_store_bld_ppy_cnt,
 replaced_store_bld_cnt,
 replaced_store_bld_py_cnt,
 replaced_store_bld_ppy_cnt,
 closed_store_bld_cnt,
 closed_store_bld_py_cnt,
 closed_store_bld_ppy_cnt,
 bld_contract_cnt,
 bld_contract_py_cnt,
 bld_contract_ppy_cnt
FROM ldl_data_production_core_dim.v_fact_store_building_statistics_by_day_1 AS main;