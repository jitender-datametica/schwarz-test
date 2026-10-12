CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cal_week_2 (
cy_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_2 year. Week 1 is the first week in the calendar_2 year containing at least 4 days.'),
week_of_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number of the week within the calendar_2 year, i.e. a number between 1 and 53. Week 1 is the first week in the calendar_2 year containing at least 4 days, therefore the first week containing a Thursday.'),
cy_week_begin_week_part BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The first partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020531.'),
cy_week_end_week_part BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The last partial week (inclusive) of the week as a number in the form YYYYWWn. Eg. 2020532. If the week does not span two months, this is the same as cy_week_begin_week_part.'),
cy_week_begin_dt DATE NOT NULL
OPTIONS(description='The first day of the week - i.e. the Monday - in the form YYYY-MM_2-DD. Eg. 2020-12-28.'),
cy_week_end_dt DATE NOT NULL
OPTIONS(description='The last day of the week - i.e. the Sunday - in the form YYYY-MM_2-DD. Eg. 2021-01-03. '),
cy_week_week_part_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of partial weeks in this week, i.e. 1 or 2.'),
cy_week_prev_1w BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The previous week as a number in the form YYYYWW. Eg. 202052. '),
cy_week_prev_1y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 1 year (= 384 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.'),
cy_week_prev_2y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 2 years (= 728 days = 104 weeks) ago as a number in the form YYYYWW. Eg. 201901. '),
cy_week_prev_3y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 3 years (= 1092 days = 156 weeks) ago as a number in the form YYYYWW. Eg. 201801.'),
cy_week_prev_4y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 4 years (= 1456 days = 208 weeks) ago as a number in the form YYYYWW. Eg. 201701.'),
cy_week_prev_5y BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The week 5 years (= 1820 days = 260 weeks) ago as a number in the form YYYYWW. Eg. 201601.'),
cy_week_offset BIGNUMERIC(38,0)
OPTIONS(description='The difference in weeks between this week and the current week. So if current week is 202053 then the offset is 0 for 202053, -1 for 202052 and +1 for 202101. '),
cy_week_short_name STRING(100)
OPTIONS(description='A short version of the name of the week in the format\"KW nn\" with nn being the week of the year.'),
cy_week_name STRING(100)
OPTIONS(description='The name of the week in the format\"YYYY KW nn\" with YYYY being the year and nn being the week of the year.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cy_week) NOT ENFORCED
)
OPTIONS(description='Calendar_2 weeks. A week may span two months or two years. A week is considered part of the year, into which most of its days fall.');