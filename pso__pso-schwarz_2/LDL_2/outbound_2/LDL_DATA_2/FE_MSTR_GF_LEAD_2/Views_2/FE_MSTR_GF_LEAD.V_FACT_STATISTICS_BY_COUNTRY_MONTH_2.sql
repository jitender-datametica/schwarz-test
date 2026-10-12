CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_fact_statistics_by_country_month_2 (country_org_sid
OPTIONS(description='the unique identifier (surrogate key) for the country_2, for which statistics have been calculated.'),
country_org_cd
OPTIONS(description='the code of the business country_2 for which this country_2 organization is responsible. (the business country_2 is not identical to a political country.)'),
stat_type_cd OPTIONS(description='the code identifying the kind of metric which is calculated for internal companies.'),
cal_month OPTIONS(description='The calendar_2 month of the is entered'), stat_val
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
OPTIONS(description='the code identifying the unit_2 of measure for the statistics measure.'), dwh_created_tmsp
OPTIONS(description='the point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='the point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='the code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `VARIOUS DERIVED METRICS CAN BE CALCULATED ON THE LEVEL OF A MONTH AND AN INTERNAL COMPANY. THESE VALUES ARE NOT NECESSARILY IN SYNC WITH THE UNDERLYING BASE EVENTS. THE TABLE CONTAINS SEPARATE COLUMNS FOR EACH DOMAIN OF STATISTICS VALUES. DEPENDING ON THE STATISTICS TYPE, ONE OF THEM IS FILLED.`)
AS SELECT MAIN.int_company_sid AS country_org_sid,
 MAIN.country_org_cd,
 MAIN.stat_type_cd,
 MAIN.cal_month,
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
FROM ldl_data_core_dim.v_fact_company_statistics_by_month_2 AS MAIN
 INNER JOIN ldl_data_core_dim.t_fact_exchange_rate_2 AS FER ON MAIN.curr_cd = FER.tgt_curr_cd
WHERE FER.exchange_rate_type_cd = 'BEW_ISK'
 AND (FER.src_curr_cd = 'EUR' OR FER.src_curr_cd = FER.tgt_curr_cd)
 AND FER.active_fg
 AND CAST(MAIN.stat_type_cd AS INTEGER) IN (255, 256, 257, 258, 259, 260, 261);