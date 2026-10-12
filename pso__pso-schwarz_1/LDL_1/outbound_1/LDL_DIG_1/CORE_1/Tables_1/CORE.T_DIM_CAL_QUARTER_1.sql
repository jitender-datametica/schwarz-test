CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cal_quarter_1 (
cy_quarter BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The quarter as a number of the form YYYYQX, where YYYY is the calendar_1 year and QX is quarter of the calendar_1 year.'),
cy BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The calendar_1 year as a number in the form YYYY. Eg. 2019'),
bus_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019.'),
quarter_of_cal_year STRING(5) NOT NULL
OPTIONS(description='The quarter of the calendar_1 year as a number using the convention Q1 = 1 ... Q4 = 4.'),
quarter_of_bus_year STRING(5) NOT NULL
OPTIONS(description='The quarter of the business year (starting in March) as a number using the convention '),
cal_quarter_begin_dt DATE NOT NULL OPTIONS(description='The first day of the quarter in the form YYYY-MM_1-DD.'),
cal_quarter_end_dt DATE NOT NULL OPTIONS(description='The last day of the quarter in the form YYYY-MM_1-DD. '),
cal_quarter_prev_1m BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 quarter one quarter ago as a number in the form  YYYYQX. '),
cy_quarter_offset BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cy_quarter) NOT ENFORCED
) OPTIONS(description='This dimension contains the quarter period of the calendar_1 year.');