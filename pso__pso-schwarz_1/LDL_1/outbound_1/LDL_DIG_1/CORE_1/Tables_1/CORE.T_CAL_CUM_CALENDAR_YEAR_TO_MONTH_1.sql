CREATE TABLE IF NOT EXISTS ldl_dig_core.t_cal_cum_calendar_year_to_month_1 (
cy_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month for which the year-to-month interval is defined.'),
incl_cy_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_1 month that needs to be included in the year-to-month interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)')
)
OPTIONS(description='This table relates a month to all months that form the year-to-month interval of this month. E.g. for May 2019 this is January, February, March, April and May 2019.');