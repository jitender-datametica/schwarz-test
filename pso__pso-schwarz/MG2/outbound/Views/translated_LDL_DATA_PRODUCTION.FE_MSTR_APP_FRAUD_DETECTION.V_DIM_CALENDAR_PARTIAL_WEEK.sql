CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_calendar_partial_week (part_week
OPTIONS(description='The partial week as a number of the form YYYYWWn. YYYY is the calendar year and WW is the number of the week within the year and n is sequence number (1 or 2) of the partial week within the week.'),
cal_year
OPTIONS(description='The calendar year to which this partial week belongs as a number in the form YYYY. Eg. 2019'),
cal_half_year
OPTIONS(description='The identifier for a calendar half year in the form YYYYn. The first half year is from January to June, the second half year from July to December. E.g. 20211 for the first half year of 2021.'),
cal_year_qtr
OPTIONS(description='The quarter of a calendar year in the form YYYYn. E.g. 20211 for Q1/2021 starting on January 1st 2021 and ending on March 31st 2021.'),
bus_year OPTIONS(description='The business year containing the partial week as a number in the form YYYY.  '),
bus_half_year
OPTIONS(description='The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.'),
bus_year_qtr
OPTIONS(description='The quarter of a business year in the form YYYYn, e.g. Q1/2021 starting on March 1st 2021 and ending on May 31st 2021. '),
cal_month
OPTIONS(description='The calendar month containing the partial week as a number of the form YYYYMM, where YYYY is the calendar year and MM is month of the calendar year.'),
cal_week
OPTIONS(description='The week containing the partial week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the year. I.e. the week that was split to form this partial week. '),
part_week_short_name
OPTIONS(description='A short version of the name, by which the partial week is referenced by business, in group language, i.e. in German, in the form\""TW WW/ n\"", where WW is the number of the week in the year, and n is the number of the partial week (1 or 2) within the week.'),
part_week_short_name_de
OPTIONS(description='A short version of the name, by which the partial week is referenced by business, in German in the form\""TW WW/ n\"", where WW is the number of the week in the year, and n is the number of the partial week (1 or 2) within the week.'),
part_week_short_name_en
OPTIONS(description='A short version of the name, by which the partial week is referenced by business, in English in the form\""PW WW/ n\"", where WW is the number of the week in the year, and n is the number of the partial week (1 or 2) within the week.'),
part_week_name
OPTIONS(description='The name, by which the partial week is referenced by business, in group language, i.e. in German, in the form\""TW WW/ P  YYYY\"", where WW is the number of the week in the year, n is the number of the partial week (1 or 2) within the week, and YYYY is the calendar year.'),
part_week_name_de
OPTIONS(description='The name, by which the partial week is referenced by business, in German in the form\""TW WW/ P  YYYY\"", where WW is the number of the week in the year, n is the number of the partial week (1 or 2) within the week, and YYYY is the calendar year.'),
part_week_name_en
OPTIONS(description='The name, by which the partial week is referenced by business, in English in the form\""PW WW/ P  YYYY\"", where WW is the number of the week in the year, n is the number of the partial week (1 or 2) within the week, and YYYY is the calendar year.'),
part_week_descr
OPTIONS(description='A description in group language (German) of the range of weekdays, as defined by the partial week, in the format\""DD - DD\"". E.g.\""Mo - Do\"" for Monday to Thursday.'),
part_week_descr_de
OPTIONS(description='A description in German of the range of weekdays, as defined by the partial week, in the format\""DD - DD\"". E.g.\""Mo - Do\"" for Monday to Thursday.'),
part_week_descr_en
OPTIONS(description='A description in English of the range of weekdays, as defined by the partial week, in the format\""DDD - DDD\"". E.g.\""Mon - Thu\"" for Monday to Thursday.'),
week_of_cal_year
OPTIONS(description='The number of the week within the calendar year, to which this partial week belongs. A number between 1 and 53. (Week 1 is the first week of the calendar year that contains at least 4 days.)'),
week_of_bus_year
OPTIONS(description='The number of the week within the business year, i.e. a number between 1 and 53. Week 1 is the first week in the business year containing at least 4 days, therefore the first week containing a Thursday.'),
part_week_seq
OPTIONS(description='The sequence number of the partial week within the week containing that partial week. (1 or 2)'),
part_week_begin_dt OPTIONS(description='The first day (inclusive) of the partial week in the form YYYY-MM-DD.'),
part_week_end_dt OPTIONS(description='The last day (inclusive) of the partial week in the form YYYY-MM-DD.'),
part_week_begin_day_of_week
OPTIONS(description='The day of the week (number) of the first day (inclusive) of the partial week.'),
part_week_end_day_of_week
OPTIONS(description='The day of the week (number) of the last day (inclusive) of the partial week.'),
part_week_full_week_fg
OPTIONS(description='A flag indicating whether a partial week is a full week. I.e. does the partial week contain 7 days?'),
part_week_day_cnt OPTIONS(description='The number of days that this partial week contains.'), prev_1y_part_week
OPTIONS(description='The corresponding partial week 1 year  (= 52 weeks) ago as a number in the form YYYYWWn.'),
prev_2y_part_week
OPTIONS(description='The corresponding partial week 2 years (= 104 weeks) ago as a number in the form YYYYWWn.'),
prev_3y_part_week
OPTIONS(description='The corresponding partial week 3 years (= 156 weeks) ago as a number in the form YYYYWWn.'),
prev_4y_part_week
OPTIONS(description='The corresponding partial week 4 years (= 208 weeks) ago as a number in the form YYYYWWn.'),
prev_5y_part_week
OPTIONS(description='The corresponding partial week 5 years (= 260 weeks) ago as a number in the form YYYYWWn.'),
prev_1y_swday_period_begin_dt
OPTIONS(description='The first day of the corresponding period one year ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_1y_swday_period_end_dt
OPTIONS(description='The last day of the corresponding period one year ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_2y_swday_period_begin_dt
OPTIONS(description='The first day of the corresponding period two years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_2y_swday_period_end_dt
OPTIONS(description='The last day of the corresponding period two years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_3y_swday_period_begin_dt
OPTIONS(description='The first day of the corresponding period three years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_3y_swday_period_end_dt
OPTIONS(description='The last day of the corresponding period three years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_4y_swday_period_begin_dt
OPTIONS(description='The first day of the corresponding period four years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_4y_swday_period_end_dt
OPTIONS(description='The last day of the corresponding period four years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_5y_swday_period_begin_dt
OPTIONS(description='The first day of the corresponding period five years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
prev_5y_swday_period_end_dt
OPTIONS(description='The last day of the corresponding period five years ago. The period matches the same range of weekdays - e.g. Monday to Thursday. (Note that this period is not necessarily a partial week for the year to which it belongs.)'),
curr_part_week_fg OPTIONS(description='This indicator is set for the current partial week.'), part_week_offset
OPTIONS(description='The difference in partial weeks between this partial week and the current partial week (or week).'),
cal_week_offset
OPTIONS(description='The difference in weeks between the week to which this partial week belongs, and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101.'),
cal_month_offset
OPTIONS(description='The difference in months between the calendar month to which this partial week belongs, and the current calendar month. So if current calendar month is 201901 then the offset is 0 for 201901, -1 for 201812 and +1 for 201902.'),
cal_year_qtr_offset
OPTIONS(description='The difference in calendar year quarters between the calendar year quarter to which this partial week  belongs, and the current calendar year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.'),
cal_half_year_offset
OPTIONS(description='The difference in calendar half years between the calendar half year to which this partial week belongs, and the current calendar half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'),
cal_year_offset
OPTIONS(description='The difference in years between the calendar year to which this partial week belongs, and the current calendar year. So if the current calendar year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020. '),
bus_year_qtr_offset
OPTIONS(description='The difference in business year quarters between the business year quarter to which this partial week belongs, and the current business year quarter. So if the current quarter is Q1/2021 then the offset is 0 for Q1/2021, -1 for Q4 2024 and +1 for Q2 2021.'),
bus_half_year_offset
OPTIONS(description='The difference in business half years between the business half year to which this partial week belongs, and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'),
bus_year_offset
OPTIONS(description='The difference in years between the business year to which this partial week belongs, and the current business year. So if the current business year is 2019 then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A CALENDAR WEEK THAT SPANS TWO MONTHS, IS SPLIT INTO TWO PARTIAL WEEKS.`) AS SELECT part_week,
 cal_year,
 cal_half_year,
 cal_year_qtr,
 bus_year,
 bus_half_year,
 bus_year_qtr,
 cal_month,
 cal_week,
 part_week_short_name,
 part_week_short_name_de,
 part_week_short_name_en,
 part_week_name,
 part_week_name_de,
 part_week_name_en,
 part_week_descr,
 part_week_descr_de,
 part_week_descr_en,
 week_of_cal_year,
 week_of_bus_year,
 part_week_seq,
 part_week_begin_dt,
 part_week_end_dt,
 part_week_begin_day_of_week,
 part_week_end_day_of_week,
 part_week_full_week_fg,
 part_week_day_cnt,
 prev_1y_part_week,
 prev_2y_part_week,
 prev_3y_part_week,
 prev_4y_part_week,
 prev_5y_part_week,
 prev_1y_swday_period_begin_dt,
 prev_1y_swday_period_end_dt,
 prev_2y_swday_period_begin_dt,
 prev_2y_swday_period_end_dt,
 prev_3y_swday_period_begin_dt,
 prev_3y_swday_period_end_dt,
 prev_4y_swday_period_begin_dt,
 prev_4y_swday_period_end_dt,
 prev_5y_swday_period_begin_dt,
 prev_5y_swday_period_end_dt,
 curr_part_week_fg,
 part_week_offset,
 cal_week_offset,
 cal_month_offset,
 cal_year_qtr_offset,
 cal_half_year_offset,
 cal_year_offset,
 bus_year_qtr_offset,
 bus_half_year_offset,
 bus_year_offset,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_calendar_partial_week AS main
WHERE bus_year_offset BETWEEN - 20 AND 2;