CREATE TABLE IF NOT EXISTS ldl_dig_core.t_cal_day_py_business_year_adjusted (
cal_dt DATE NOT NULL
OPTIONS(description='The day being mapped back to previous (business) years, represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
bus_year_diff BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The difference in years between the current business year and the business year we are mapping back to. I.e. 1 for the previous year, 2 for 2 years ago etc.'),
incl_cal_dt DATE NOT NULL
OPTIONS(description='The date that needs to be included for the previous year\'s equivalent of the current day being mapped.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)')
)
OPTIONS(description='This table maps a calendar date to its equivalent day(s) of previous business years maintaining the calendar date (e.g. 27.5.2019 -> 27.5.2018) except for the adjusted days at the end of the business year (YYYY-02-28 and YYYY-02-29).');