CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_fact_store_open_days (cal_dt
OPTIONS(description='the business date for which the store status is tracked.'), store_sid
OPTIONS(description='the unique identifier (surrogate key) for a store.'), real_estate_sid
OPTIONS(description='the unique identifier (surrogate key) for the real estate object.'), country_org_cd
OPTIONS(description='the code of the business country for which this country organization is responsible. (the business country is not identical to a political country.)'),
curr_cd OPTIONS(description='the code identifying the currency according to iso-4217.'), curr_group_fg
OPTIONS(description='flag for group currency'), curr_local_fg OPTIONS(description='flag for local currency'),
store_open_fg OPTIONS(description='an indicator showing if the store was actually open on the given day.'),
store_open_days_bytd_cnt
OPTIONS(description='the number of days this store has already been open in the current business year. (the business-year-to-date count of the store_open_fg)'),
store_open_py_fg
OPTIONS(description='an indicator showing if the store was actually open on the same calendar date one year ago.'),
store_open_days_py_bytd_cnt
OPTIONS(description='the number of days this store has been open in the previous business year up to the equivalent calendar date one year ago.  (the business-year-to-date count of the store_open_py_fg)'),
store_open_py_swday_fg
OPTIONS(description='an indicator showing if the store was actually open on the same weekday one year ago.'),
store_open_days_py_swday_bytd_cnt
OPTIONS(description='the number of days this store has been open in the previous business year up to the equivalent weekday one year ago.  (the business-year-to-date count of the store_open_py_swday_fg)'),
relevant_for_comp_fg
OPTIONS(description='an indicator showing if the revenue which this store made on the given business date can be compared with its revenue on the equivalent day in the year before. the first week after the opening of a new store i.e. the days between the opening date and the following sunday needs to be excluded from comparison. (bereinigte steigerung)'),
relevant_for_comp_py_fg
OPTIONS(description='an indicator showing if the revenue which this store made on the same calendar date one year ago can be compared with its revenue in the year before (i.e. two years ago). the first week after the opening of a new store i.e. the days between the opening date and the following sunday needs to be excluded from comparison. (bereinigte steigerung)'),
relevant_for_comp_py_swday_fg
OPTIONS(description='an indicator showing if the revenue which this store made on the same weekday date one year ago can be compared with its revenue in the year before (i.e. two years ago). the first week after the opening of a new store i.e. the days between the opening date and the following sunday needs to be excluded from comparison. (bereinigte steigerung)'),
open_tm OPTIONS(description='the time (in the local time zone) when the store opened.'), close_tm
OPTIONS(description='the time (in the local time zone) when the store closed.'), open_hr_cnt
OPTIONS(description='the number of hours the store was open on the given date.'), open_hr_bytd_cnt
OPTIONS(description='the business-year-to-date sum of the number of hours the store has been open up to the given date.'),
open_hr_py_cnt
OPTIONS(description='the number of hours the store was open on the equivalent calendar date one year ago.'),
open_hr_py_bytd_cnt
OPTIONS(description='the business-year-to-date sum of the hours the store has been open up to the equivalent calendar date one year ago.'),
open_hr_py_swday_cnt
OPTIONS(description='the number of hours the store was open on the equivalent weekday one year ago.'),
open_hr_py_swday_bytd_cnt
OPTIONS(description='the business-year-to-date sum of the hours the store has been open up to the equivalent weekday one year ago.'),
emp_hr_cnt OPTIONS(description='the number of hours employees have worked in this store on the given day.'),
emp_hr_bytd_cnt
OPTIONS(description='the business-year-to-date sum of the number of hours employees have worked in this store up to the given date.'),
emp_hr_py_cnt
OPTIONS(description='the number of hours employees have worked in this store on the equivalent calendar date one year ago.'),
emp_hr_py_bytd_cnt
OPTIONS(description='the business-year-to-date sum of the number of hours employees have worked in this store up to the equivalent calendar date one year ago.'),
emp_hr_py_swday_cnt
OPTIONS(description='the number of hours employees have worked in this store on the equivalent weekday one year ago.'),
emp_hr_py_swday_bytd_cnt
OPTIONS(description='the business-year-to-date sum of the number of hours employees have worked in this store up to the equivalent weekday one year ago.'),
real_estate_status_cd
OPTIONS(description='the code identifying the lifecycle status for real estate objects. (this is the business lifecycle so it might differ from the status code shown in the source system.)'))
OPTIONS(DESCRIPTION = `THIS FACT TABLE SHOWS FOR EACH DAY, IF A STORE IS OPEN, AND WHETHER THIS DAY AN BE COUNTED FOR REVENUE COMPARISON (BEREINIGTE STEIGERUNG). (IN CASE OF NEW STORES, THE FIRST WEEK NEEDS TO BE EXCLUDED FROM THE COMPARISON.) IN ADDITION, THIS FACT TRACKS VARIOUS STATUS ATTRIBUTES, AS WELL AS THE NUMBER HOURS THE STORE WAS OPEN ON THAT DAY AND THE NUMBER OF HOURS, EMPLOYEES HAVE WORKED IN THIS STORE.`)
AS SELECT main.bus_dt AS cal_dt,
 main.store_sid,
 main.real_estate_sid,
 main.country_org_cd,
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
  CASE
  WHEN main.store_open_fg IS NOT NULL
  THEN CASE
   WHEN main.store_open_fg
   THEN 1
   ELSE 0
   END
  ELSE NULL
  END AS store_open_fg,
 main.store_open_days_bytd_cnt,
  CASE
  WHEN main.store_open_py_fg IS NOT NULL
  THEN CASE
   WHEN main.store_open_py_fg
   THEN 1
   ELSE 0
   END
  ELSE NULL
  END AS store_open_py_fg,
 main.store_open_days_py_bytd_cnt,
  CASE
  WHEN main.store_open_py_swday_fg IS NOT NULL
  THEN CASE
   WHEN main.store_open_py_swday_fg
   THEN 1
   ELSE 0
   END
  ELSE NULL
  END AS store_open_py_swday_fg,
 main.store_open_days_py_swday_bytd_cnt,
  CASE
  WHEN main.relevant_for_comp_fg IS NOT NULL
  THEN CASE
   WHEN main.relevant_for_comp_fg
   THEN 1
   ELSE 0
   END
  ELSE NULL
  END AS relevant_for_comp_fg,
  CASE
  WHEN main.relevant_for_comp_py_fg IS NOT NULL
  THEN CASE
   WHEN main.relevant_for_comp_py_fg
   THEN 1
   ELSE 0
   END
  ELSE NULL
  END AS relevant_for_comp_py_fg,
  CASE
  WHEN main.relevant_for_comp_py_swday_fg IS NOT NULL
  THEN CASE
   WHEN main.relevant_for_comp_py_swday_fg
   THEN 1
   ELSE 0
   END
  ELSE NULL
  END AS relevant_for_comp_py_swday_fg,
 main.open_tm,
 main.close_tm,
 main.open_hr_cnt,
 main.open_hr_bytd_cnt,
 main.open_hr_py_cnt,
 main.open_hr_py_bytd_cnt,
 main.open_hr_py_swday_cnt,
 main.open_hr_py_swday_bytd_cnt,
 main.emp_hr_cnt,
 main.emp_hr_bytd_cnt,
 main.emp_hr_py_cnt,
 main.emp_hr_py_bytd_cnt,
 main.emp_hr_py_swday_cnt,
 main.emp_hr_py_swday_bytd_cnt,
 main.real_estate_status_cd
FROM ldl_data_production_core_dim.t_fact_store_open_days AS main
 INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization AS co ON main.store_sid = co.int_org_sid
 INNER JOIN ldl_data_production_core_dim.t_fact_exchange_rate AS fer ON co.curr_cd = fer.tgt_curr_cd
WHERE fer.exchange_rate_type_cd = 'BEW_ISK'
 AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
 AND fer.active_fg
 AND co.dwh_valid_fg;