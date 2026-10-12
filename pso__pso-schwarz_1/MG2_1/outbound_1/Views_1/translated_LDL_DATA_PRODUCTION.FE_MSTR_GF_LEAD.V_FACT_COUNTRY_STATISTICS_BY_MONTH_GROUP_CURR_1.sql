CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_country_statistics_by_month_group_curr_1 (reporting_country_cd
OPTIONS(description='The code which identifies the reporting country.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization.'), country_org_cd
OPTIONS(description='the code of the business country_1 for which this country_1 organization is responsible. (the business country_1 is not identical to a political country.)'),
stat_type_cd
OPTIONS(description='The code identifying the kind of metric which is calculated for the reporting country.'), cal_month
OPTIONS(description='The identifier of a calendar_1 month in the form YYYYMM. E.g. 202101 für January 2021.'),
availability_fg OPTIONS(description='a flag showing if there are data available for given month'), stat_val
OPTIONS(description='The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
stat_bytd_val
OPTIONS(description='The business-year-to-date sum of the statistics amount for the given reporting country_1 and statistics type, which has been calculated up to the given month. (Depending on the statistics type this may be a net or a gross value.)'),
stat_py_val
OPTIONS(description='The statistics amount for the given reporting country_1 and statistics type, which has been calculated for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
stat_py_bytd_val
OPTIONS(description='The business-year-to-date sum of the statistics amount for the given reporting country_1 and statistics type, which has been calculated up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
plan_val
OPTIONS(description='The planned amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
plan_bytd_val
OPTIONS(description='The business-year-to-date sum of the amount for the given reporting country_1 and statistics type, which has been planned up to the given month. (Depending on the statistics type this may be a net or a gross value.)'),
plan_py_val
OPTIONS(description='The statistics amount for the given reporting country_1 and statistics type, which was planned for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
plan_py_bytd_val
OPTIONS(description='The business-year-to-date sum of the amount for the given reporting country_1 and statistics type, which has was planned up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
stat_meas
OPTIONS(description='The calculated statistics measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_1 of measure.)'),
stat_bytd_meas
OPTIONS(description='The business-year-to-date sum of the statistics measure for the given reporting country_1 and statistics type, which has been calculated up to the given month. (The measure is expressed in the indicated unit_1 of measure.)'),
stat_py_meas
OPTIONS(description='The statistics measure for the given reporting country_1 and statistics type, which has been calculated for the equivalent month one year ago. (The measure is expressed in the indicated unit_1 of measure.)'),
stat_py_bytd_meas
OPTIONS(description='The business-year-to-date sum of the statistics measure for the given reporting country_1 and statistics type, which has been calculated up to the equivalent month one year ago. (The measure is expressed in the indicated unit_1 of measure.)'),
plan_meas
OPTIONS(description='The planned measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_1 of measure.)'),
plan_bytd_meas
OPTIONS(description='The business-year-to-date sum of the measure for the given reporting country_1 and statistics type, which has been planned up to the given month. (The measure is expressed in the indicated unit_1 of measure.)'),
plan_py_meas
OPTIONS(description='The statistics measure for the given reporting country_1 and statistics type, which was planned for the equivalent month one year ago.  (The measure is expressed in the indicated unit_1 of measure.)'),
plan_py_bytd_meas
OPTIONS(description='The business-year-to-date sum of the measure for the given reporting country_1 and statistics type, which has was planned up to the equivalent month one year ago.  (The measure is expressed in the indicated unit_1 of measure.)'),
uom_cd OPTIONS(description='The code identifying the unit_1 of measure for the statistics measure.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT main.reporting_country_cd,
 main.country_org_sid,
 main.country_org_cd,
 main.stat_type_cd,
 main.cal_month,
  CASE
  WHEN main.stat_val = 0
  THEN 0
  ELSE 1
  END AS availability_fg,
  main.stat_val / fer.exchange_rate AS stat_val,
  main.stat_bytd_val / fer.exchange_rate AS stat_bytd_val,
  main.stat_py_val / fer.exchange_rate AS stat_py_val,
  main.stat_py_bytd_val / fer.exchange_rate AS stat_py_bytd_val,
  main.plan_val / fer.exchange_rate AS plan_val,
  main.plan_bytd_val / fer.exchange_rate AS plan_bytd_val,
  main.plan_py_val / fer.exchange_rate AS plan_py_val,
  main.plan_py_bytd_val / fer.exchange_rate AS plan_py_bytd_val,
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
FROM ldl_data_production_core_dim.v_fact_country_statistics_by_month_1 AS main
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate_1 AS fer ON main.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND fer.src_curr_cd = 'EUR'
 AND fer.active_fg
 AND CAST(main.stat_type_cd AS INTEGER) IN (255, 256, 257, 258, 259, 260, 261);