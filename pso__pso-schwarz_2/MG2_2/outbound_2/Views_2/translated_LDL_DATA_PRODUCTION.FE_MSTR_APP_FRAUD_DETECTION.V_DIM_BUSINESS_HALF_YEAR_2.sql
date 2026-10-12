CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_business_half_year_2 (bus_half_year
OPTIONS(description='The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.'),
bus_year OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'), bus_half_year_name
OPTIONS(description='The text which is displayed for the business half year in reports, in group language, i.e. German. E.g. 2021-HJ1 for the first half of the business year 2021.'),
bus_half_year_name_de
OPTIONS(description='The text which is displayed for the business half year in reports, in German. E.g. 2021-HJ1 for the first half of the business year 2021.'),
bus_half_year_name_en
OPTIONS(description='The text which is displayed for the business half year in reports, in English. E.g. 2021-HY1 for the first half of the business year 2021.'),
half_of_bus_year
OPTIONS(description='The number of the half year within the business year. E.g. 1 for the first half year of 2021.'),
bus_half_year_begin_month
OPTIONS(description='The first (calendar_2) month (inclusive) of the business half year as a number in the form YYYYMM. Eg. 201901.'),
bus_half_year_end_month
OPTIONS(description='The last (calendar_2) month (inclusive) of the business half year as a number in the form YYYYMM. Eg. 201912.'),
bus_half_year_begin_part_week
OPTIONS(description='The first partial week (inclusive) of the business half year as a number in the form YYYYWWn. Eg. 2019012.'),
bus_half_year_end_part_week
OPTIONS(description='The last partial week (inclusive) of the business half year as a number in the form YYYYWWn. Eg. 2020011.'),
bus_half_year_begin_dt
OPTIONS(description='The first day (inclusive) of the business half year as a conventional calendar_2 date in the form "YYYY-MM_2-DD". Eg. "2019-01-01".'),
bus_half_year_end_dt
OPTIONS(description='The first day (inclusive) of the business half year as a conventional calendar_2 date in the form "YYYY-MM_2-DD". Eg. "2019-12-31". '),
bus_half_year_week_cnt
OPTIONS(description='The number of weeks that this business half year contains. If a week spans two business half years, it is counted for the half year, in which it has at least four days.'),
bus_half_year_part_week_cnt OPTIONS(description='The number of partial weeks that this business half year contains.'),
bus_half_year_day_cnt OPTIONS(description='The number of days that this business half year contains.'),
prev_1y_bus_half_year
OPTIONS(description='The business half year one year ago as a number in the form YYYYn. Eg. 20201, if the current half year is 20211.'),
prev_2y_bus_half_year
OPTIONS(description='The business half year two years ago as a number in the form YYYYn. Eg. 20191, if the current half year is 20211.'),
prev_3y_bus_half_year
OPTIONS(description='The business half year three years ago as a number in the form YYYYn. Eg. 20181, if the current half year is 20211.'),
prev_4y_bus_half_year
OPTIONS(description='The business half year four years ago as a number in the form YYYYn. Eg. 20171, if the current half year is 20211.'),
prev_5y_bus_half_year
OPTIONS(description='The business half year five years ago as a number in the form YYYYn. Eg. 20161, if the current half year is 20211.'),
curr_bus_half_year_fg OPTIONS(description='This indicator is set for the current business half year.'),
bus_half_year_offset
OPTIONS(description='The difference in business half years between this business half year and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'),
bus_year_offset
OPTIONS(description='The difference in years between the business year to which this business half year belongs, and the current business year. So if the current business year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.  '),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A HALF OF A BUSINESS YEAR. THE FIRST HALF YEAR IN THE LIDL BUSINESS YEAR IS FROM MARCH TO AUGUST, THE SECOND HALF YEAR FROM SEPTEMBER TO FEBRUARY. E.G. 20211 FOR THE FIRST HALF OF  THE BUSINESS YEAR 2021.`)
AS SELECT bus_half_year,
 bus_year,
 bus_half_year_name,
 bus_half_year_name_de,
 bus_half_year_name_en,
 half_of_bus_year,
 bus_half_year_begin_month,
 bus_half_year_end_month,
 bus_half_year_begin_part_week,
 bus_half_year_end_part_week,
 bus_half_year_begin_dt,
 bus_half_year_end_dt,
 bus_half_year_week_cnt,
 bus_half_year_part_week_cnt,
 bus_half_year_day_cnt,
 prev_1y_bus_half_year,
 prev_2y_bus_half_year,
 prev_3y_bus_half_year,
 prev_4y_bus_half_year,
 prev_5y_bus_half_year,
 curr_bus_half_year_fg,
 bus_half_year_offset,
 bus_year_offset,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_business_half_year_2 AS main
WHERE bus_year_offset BETWEEN - 20 AND 2;