CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_fact_country_statistics_by_month_2 (reporting_country_cd
OPTIONS(description='The code which identifies the reporting country.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country_2 organization.'), country_org_cd
OPTIONS(description='the code of the business country_2 for which this country_2 organization is responsible. (the business country_2 is not identical to a political country.)'),
stat_type_cd
OPTIONS(description='The code identifying the kind of metric which is calculated for the reporting country.'), cal_month
OPTIONS(description='The identifier of a calendar_2 month in the form YYYYMM. E.g. 202101 für January 2021.'),
availability_fg OPTIONS(description='a flag showing if there are data available for given month'), stat_val
OPTIONS(description='The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
stat_bytd_val
OPTIONS(description='The business-year-to-date sum of the statistics amount for the given reporting country_2 and statistics type, which has been calculated up to the given month. (Depending on the statistics type this may be a net or a gross value.)'),
stat_py_val
OPTIONS(description='The statistics amount for the given reporting country_2 and statistics type, which has been calculated for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
stat_py_bytd_val
OPTIONS(description='The business-year-to-date sum of the statistics amount for the given reporting country_2 and statistics type, which has been calculated up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
plan_val
OPTIONS(description='The planned amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)'),
plan_bytd_val
OPTIONS(description='The business-year-to-date sum of the amount for the given reporting country_2 and statistics type, which has been planned up to the given month. (Depending on the statistics type this may be a net or a gross value.)'),
plan_py_val
OPTIONS(description='The statistics amount for the given reporting country_2 and statistics type, which was planned for the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
plan_py_bytd_val
OPTIONS(description='The business-year-to-date sum of the amount for the given reporting country_2 and statistics type, which has was planned up to the equivalent month one year ago. (Depending on the statistics type this may be a net or a gross value.)'),
curr_cd OPTIONS(description='The code identifying the currency, according to ISO 4217.'), curr_group_fg
OPTIONS(description='Flag for Group Currency'), curr_local_fg OPTIONS(description='Flag for Local Currency'), stat_meas
OPTIONS(description='The calculated statistics measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_2 of measure.)'),
stat_bytd_meas
OPTIONS(description='The business-year-to-date sum of the statistics measure for the given reporting country_2 and statistics type, which has been calculated up to the given month. (The measure is expressed in the indicated unit_2 of measure.)'),
stat_py_meas
OPTIONS(description='The statistics measure for the given reporting country_2 and statistics type, which has been calculated for the equivalent month one year ago. (The measure is expressed in the indicated unit_2 of measure.)'),
stat_py_bytd_meas
OPTIONS(description='The business-year-to-date sum of the statistics measure for the given reporting country_2 and statistics type, which has been calculated up to the equivalent month one year ago. (The measure is expressed in the indicated unit_2 of measure.)'),
plan_meas
OPTIONS(description='The planned measure for the given month, statistics type and reporting country. (The measure is expressed in the indicated unit_2 of measure.)'),
plan_bytd_meas
OPTIONS(description='The business-year-to-date sum of the measure for the given reporting country_2 and statistics type, which has been planned up to the given month. (The measure is expressed in the indicated unit_2 of measure.)'),
plan_py_meas
OPTIONS(description='The statistics measure for the given reporting country_2 and statistics type, which was planned for the equivalent month one year ago.  (The measure is expressed in the indicated unit_2 of measure.)'),
plan_py_bytd_meas
OPTIONS(description='The business-year-to-date sum of the measure for the given reporting country_2 and statistics type, which has was planned up to the equivalent month one year ago.  (The measure is expressed in the indicated unit_2 of measure.)'),
uom_cd OPTIONS(description='The code identifying the unit_2 of measure for the statistics measure.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT MAIN.reporting_country_cd,
 MAIN.country_org_sid,
 MAIN.country_org_cd,
 MAIN.stat_type_cd,
 MAIN.cal_month,
  CASE
  WHEN MAIN.stat_val = 0
  THEN 0
  ELSE 1
  END AS availability_fg,
  MAIN.stat_val / FER.exchange_rate AS stat_val,
  MAIN.stat_bytd_val / FER.exchange_rate AS stat_bytd_val,
  MAIN.stat_py_val / FER.exchange_rate AS stat_py_val,
  MAIN.stat_py_bytd_val / FER.exchange_rate AS stat_py_bytd_val,
  MAIN.plan_val / FER.exchange_rate AS plan_val,
  MAIN.plan_bytd_val / FER.exchange_rate AS plan_bytd_val,
  MAIN.plan_py_val / FER.exchange_rate AS plan_py_val,
  MAIN.plan_py_bytd_val / FER.exchange_rate AS plan_py_bytd_val,
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
 MAIN.stat_meas,
 MAIN.stat_bytd_meas,
 MAIN.stat_py_meas,
 MAIN.stat_py_bytd_meas,
 MAIN.plan_meas,
 MAIN.plan_bytd_meas,
 MAIN.plan_py_meas,
 MAIN.plan_py_bytd_meas,
 MAIN.uom_cd,
 MAIN.dwh_created_tmsp,
 MAIN.dwh_updated_tmsp,
 MAIN.dwh_load_id,
 MAIN.dwh_node_cd
FROM ldl_data_core_dim.v_fact_country_statistics_by_month_2 AS MAIN
 INNER JOIN ldl_data_core_dim.t_fact_exchange_rate_2 AS FER ON MAIN.curr_cd = FER.tgt_curr_cd
WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
 AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
 AND FER.active_fg
 AND CAST(MAIN.stat_type_cd AS INTEGER) IN (255, 256, 257, 258, 259, 260, 261);