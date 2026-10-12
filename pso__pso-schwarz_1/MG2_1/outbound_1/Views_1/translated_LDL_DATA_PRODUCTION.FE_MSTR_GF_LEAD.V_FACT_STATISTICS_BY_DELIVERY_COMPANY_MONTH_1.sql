CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_statistics_by_delivery_company_month_1 (deliv_company_sid
OPTIONS(description='the unique identifier (surrogate key) for the delivery company, for which statistics have been calculated.'),
country_org_cd
OPTIONS(description='the code of the business country_1 for which this country_1 organization is responsible. (the business country_1 is not identical to a political country.)'),
stat_type_cd OPTIONS(description='the code identifying the kind of metric which is calculated for internal companies.'),
cal_month OPTIONS(description='The calendar_1 month of the is entered'), stat_val
OPTIONS(description='the calculated statistics amount for the given month, statistics type and internal company. (depending on the statistics type this may be a net or a gross value.)'),
stat_bytd_val OPTIONS(description='the business-year-to-date sum of the calculated statistics amount  '), stat_py_val
OPTIONS(description='the previous year of the calculated statistics amount  '), stat_py_bytd_val
OPTIONS(description='the previous business-year-to-date sum of the calculated statistics amount  '), plan_val
OPTIONS(description='the planned statistics amount for the given month, statistics type and internal company. (depending on the statistics type this may be a net or a gross value.)'),
plan_bytd_val OPTIONS(description='the business-year-to-date sum of the planned statistics amount  '), plan_py_val
OPTIONS(description='the previous year of the planned statistics amount  '), plan_py_bytd_val
OPTIONS(description='the previous business-year-to-date sum of the calculated statistics amount  '), curr_cd
OPTIONS(description='The code identifying the currency according to ISO-4217.'), curr_group_fg
OPTIONS(description='Flag for Group Currency'), curr_local_fg OPTIONS(description='Flag for Local Currency'), stat_meas
OPTIONS(description='the calculated statistics measure for the given month, statistics type and internal company.'),
stat_bytd_meas
OPTIONS(description='the calculated statistics measure for the given month, statistics type and internal company.'),
stat_py_meas OPTIONS(description='the business-year-to-date sum of the calculated statistics amount  '),
stat_py_bytd_meas OPTIONS(description='the previous business-year-to-date sum of the calculated statistics amount  '),
plan_meas
OPTIONS(description='the planned statistics amount for the given month, statistics type and internal company. (depending on the statistics type this may be a net or a gross value.)'),
plan_bytd_meas OPTIONS(description='the business-year-to-date sum of the planned statistics amount  '), plan_py_meas
OPTIONS(description='the previous year of the planned statistics amount  '), plan_py_bytd_meas
OPTIONS(description='the previous business-year-to-date sum of the calculated statistics amount  '), uom_cd
OPTIONS(description='the code identifying the unit_1 of measure for the statistics measure.'), dwh_created_tmsp
OPTIONS(description='the point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='the point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='the code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `VARIOUS DERIVED METRICS CAN BE CALCULATED ON THE LEVEL OF A MONTH AND AN INTERNAL COMPANY. THESE VALUES ARE NOT NECESSARILY IN SYNC WITH THE UNDERLYING BASE EVENTS. THE TABLE CONTAINS SEPARATE COLUMNS FOR EACH DOMAIN OF STATISTICS VALUES. DEPENDING ON THE STATISTICS TYPE, ONE OF THEM IS FILLED.`)
AS SELECT main.int_company_sid AS deliv_company_sid,
 main.country_org_cd,
 main.stat_type_cd,
 main.cal_month,
  main.stat_val / fer.exchange_rate AS stat_val,
  main.stat_bytd_val / fer.exchange_rate AS stat_bytd_val,
  main.stat_py_val / fer.exchange_rate AS stat_py_val,
  main.stat_py_bytd_val / fer.exchange_rate AS stat_py_bytd_val,
  main.plan_val / fer.exchange_rate AS plan_val,
  main.plan_bytd_val / fer.exchange_rate AS plan_bytd_val,
  main.plan_py_val / fer.exchange_rate AS plan_py_val,
  main.plan_py_bytd_val / fer.exchange_rate AS plan_py_bytd_val,
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
 main.stat_meas,
 main.stat_bytd_meas,
 main.stat_py_meas,
 main.stat_py_bytd_meas,
 main.plan_meas,
 main.plan_bytd_meas,
 main.plan_py_meas,
 main.plan_py_bytd_meas,
 main.uom_cd,
 main.dwh_created_tmsp,
 main.dwh_updated_tmsp,
 main.dwh_load_id,
 main.dwh_node_cd
FROM ldl_data_production_core_dim.v_fact_company_statistics_by_month_1 AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_1 AS fer ON COALESCE(main.curr_cd, 'EUR') = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
 AND fer.active_fg
 AND CAST(main.stat_type_cd AS FLOAT64) = 248;