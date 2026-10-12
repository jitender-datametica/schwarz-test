CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_BUSINESS_HALF_YEAR_2 (
bus_half_year COMMENT 'The identifier for a business half year in the form YYYYn. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.'
,bus_year COMMENT 'The business year as a number in the form YYYY. Eg. 2019'
,bus_half_year_name COMMENT 'The text which is displayed for the business half year in reports, in group language, i.e. German. E.g. 2021-HJ1 for the first half of the business year 2021.'
,bus_half_year_name_de COMMENT 'The text which is displayed for the business half year in reports, in German. E.g. 2021-HJ1 for the first half of the business year 2021.'
,bus_half_year_name_en COMMENT 'The text which is displayed for the business half year in reports, in English. E.g. 2021-HY1 for the first half of the business year 2021.'
,half_of_bus_year COMMENT 'The number of the half year within the business year. E.g. 1 for the first half year of 2021.'
,bus_half_year_begin_month COMMENT 'The first (calendar_2) month (inclusive) of the business half year as a number in the form YYYYMM. Eg. 201901.'
,bus_half_year_end_month COMMENT 'The last (calendar_2) month (inclusive) of the business half year as a number in the form YYYYMM. Eg. 201912.'
,bus_half_year_begin_part_week COMMENT 'The first partial week (inclusive) of the business half year as a number in the form YYYYWWn. Eg. 2019012.'
,bus_half_year_end_part_week COMMENT 'The last partial week (inclusive) of the business half year as a number in the form YYYYWWn. Eg. 2020011.'
,bus_half_year_begin_dt COMMENT 'The first day (inclusive) of the business half year as a conventional calendar_2 date in the form \'YYYY-MM_2-DD\'. Eg. \'2019-01-01\'.'
,bus_half_year_end_dt COMMENT 'The first day (inclusive) of the business half year as a conventional calendar_2 date in the form \'YYYY-MM_2-DD\'. Eg. \'2019-12-31\'. '
,bus_half_year_week_cnt COMMENT 'The number of weeks that this business half year contains. If a week spans two business half years, it is counted for the half year, in which it has at least four days.'
,bus_half_year_part_week_cnt COMMENT 'The number of partial weeks that this business half year contains.'
,bus_half_year_day_cnt COMMENT 'The number of days that this business half year contains.'
,prev_1y_bus_half_year COMMENT 'The business half year one year ago as a number in the form YYYYn. Eg. 20201, if the current half year is 20211.'
,prev_2y_bus_half_year COMMENT 'The business half year two years ago as a number in the form YYYYn. Eg. 20191, if the current half year is 20211.'
,prev_3y_bus_half_year COMMENT 'The business half year three years ago as a number in the form YYYYn. Eg. 20181, if the current half year is 20211.'
,prev_4y_bus_half_year COMMENT 'The business half year four years ago as a number in the form YYYYn. Eg. 20171, if the current half year is 20211.'
,prev_5y_bus_half_year COMMENT 'The business half year five years ago as a number in the form YYYYn. Eg. 20161, if the current half year is 20211.'
,curr_bus_half_year_fg COMMENT 'This indicator is set for the current business half year.'
,bus_half_year_offset COMMENT 'The difference in business half years between this business half year and the current business half year. So if the current half year is 20211 then the offset is 0 for 20211, -1 for 20202 and +1 for 20212.'
,bus_year_offset COMMENT 'The difference in years between the business year to which this business half year belongs, and the current business year. So if the current business year is 2019, then the offset is 0 for 2019, -1 for 2018 and +1 for 2020.  '
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'A half of a business year. The first half year in the Lidl business year is from March to August, the second half year from September to February. E.g. 20211 for the first half of  the business year 2021.' AS SELECT
main.bus_half_year AS bus_half_year
,main.bus_year AS bus_year
,main.bus_half_year_name AS bus_half_year_name
,main.bus_half_year_name_de AS bus_half_year_name_de
,main.bus_half_year_name_en AS bus_half_year_name_en
,main.half_of_bus_year AS half_of_bus_year
,main.bus_half_year_begin_month AS bus_half_year_begin_month
,main.bus_half_year_end_month AS bus_half_year_end_month
,main.bus_half_year_begin_part_week AS bus_half_year_begin_part_week
,main.bus_half_year_end_part_week AS bus_half_year_end_part_week
,main.bus_half_year_begin_dt AS bus_half_year_begin_dt
,main.bus_half_year_end_dt AS bus_half_year_end_dt
,main.bus_half_year_week_cnt AS bus_half_year_week_cnt
,main.bus_half_year_part_week_cnt AS bus_half_year_part_week_cnt
,main.bus_half_year_day_cnt AS bus_half_year_day_cnt
,main.prev_1y_bus_half_year AS prev_1y_bus_half_year
,main.prev_2y_bus_half_year AS prev_2y_bus_half_year
,main.prev_3y_bus_half_year AS prev_3y_bus_half_year
,main.prev_4y_bus_half_year AS prev_4y_bus_half_year
,main.prev_5y_bus_half_year AS prev_5y_bus_half_year
,main.curr_bus_half_year_fg AS curr_bus_half_year_fg
,main.bus_half_year_offset AS bus_half_year_offset
,main.bus_year_offset AS bus_year_offset
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_BUSINESS_HALF_YEAR_2 main 
WHERE main.bus_year_offset BETWEEN -20 AND 2 ;