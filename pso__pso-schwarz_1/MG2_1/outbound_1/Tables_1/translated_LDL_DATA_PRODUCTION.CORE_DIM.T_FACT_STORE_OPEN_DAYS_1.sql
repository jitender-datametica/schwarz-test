CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_store_open_days_1 (
bus_dt DATE NOT NULL OPTIONS(description='The business date for which the store status_1 is tracked.'),
store_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a store.'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_1 for which the related country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
store_open_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the store was actually open on the given day.'),
store_open_days_bytd_cnt INTEGER NOT NULL
OPTIONS(description='The number of days this store has already been open in the current business year. (the business-year-to-date count of the store_open_fg)'),
store_open_py_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the store was actually open on the same calendar_1 date one year ago.'),
store_open_days_py_bytd_cnt INTEGER NOT NULL
OPTIONS(description='The number of days this store has been open in the previous business year up to the equivalent calendar_1 date one year ago.  (the business-year-to-date count of the store_open_py_fg)'),
store_open_py_swday_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the store was actually open on the same weekday one year ago.'),
store_open_days_py_swday_bytd_cnt INTEGER NOT NULL
OPTIONS(description='The number of days this store has been open in the previous business year up to the equivalent weekday one year ago.  (the business-year-to-date count of the store_open_py_swday_fg)'),
relevant_for_comp_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the revenue, which this store made on the given business date, can be compared with its revenue on the equivalent day in the year before. When comparing the revenue, the growth that is caused purely by the increase in  the number of stores, shall be excluded. (bereinigte Steigerung) So this indicator is set to FALSE for the first year after the opening of a new store, i.e. for the days between the opening date and the Sunday following the corresponding day in the next year.'),
relevant_for_comp_py_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the revenue, which this store made on the same calendar_1 date one year ago, can be compared with its revenue in the year before (i.e. two years ago). When comparing the revenue, the growth that is caused purely by the increase in  the number of stores, shall be excluded. (bereinigte Steigerung) So this indicator is set to FALSE for the first year after the opening of a new store, i.e. for the days between the opening date and the Sunday following the corresponding day in the next year.'),
relevant_for_comp_py_swday_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the revenue, which this store made on the same weekday date one year ago, can be compared with its revenue in the year before (i.e. two years ago). When comparing the revenue, the growth that is caused purely by the increase in  the number of stores, shall be excluded. (bereinigte Steigerung) So this indicator is set to FALSE for the first year after the opening of a new store, i.e. for the days between the opening date and the Sunday following the corresponding day in the next year.'),
open_tm TIME OPTIONS(description='The time (in the local time zone) when the store opened.'),
close_tm TIME OPTIONS(description='The time (in the local time zone) when the store closed.'),
open_hr_cnt NUMERIC(29,2) OPTIONS(description='The number of hours the store was open on the given date.'),
open_hr_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours the store has been open up to the given date.'),
open_hr_py_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours the store was open on the equivalent calendar_1 date one year ago.'),
open_hr_py_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the hours the store has been open up to the equivalent calendar_1 date one year ago.'),
open_hr_py_swday_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours the store was open on the equivalent weekday one year ago.'),
open_hr_py_swday_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the hours the store has been open up to the equivalent weekday one year ago.'),
emp_hr_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours, employees have worked in this store on the given day.'),
emp_hr_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours, employees have worked in this store up to the given date.'),
emp_hr_py_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours, employees have worked in this store on the equivalent calendar_1 date one year ago.'),
emp_hr_py_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours, employees have worked in this store up to the equivalent calendar_1 date one year ago.'),
emp_hr_py_swday_cnt NUMERIC(29,2)
OPTIONS(description='The number of hours, employees have worked in this store on the equivalent weekday one year ago.'),
emp_hr_py_swday_bytd_cnt NUMERIC(29,2)
OPTIONS(description='The business-year-to-date sum of the number of hours, employees have worked in this store up to the equivalent weekday one year ago.'),
real_estate_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_1 for real estate objects. (This is the business lifecycle, so it might differ from the status_1 code shown in the source system.)'),
real_estate_event_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason why the status_1 of a real estate object has changed. E.g. a store was closed because of lack of expansion options.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
break_start_tm TIME
OPTIONS(description='In case the store closes over lunch time, this is the start time of the break.'),
break_end_tm TIME OPTIONS(description='In case the store closes over lunch time, this is the end time of the break.'),
PRIMARY KEY (bus_dt, store_sid, real_estate_sid) NOT ENFORCED
);