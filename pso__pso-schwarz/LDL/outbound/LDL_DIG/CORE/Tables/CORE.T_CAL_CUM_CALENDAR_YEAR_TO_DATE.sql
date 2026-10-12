CREATE TABLE IF NOT EXISTS ldl_dig_core.t_cal_cum_calendar_year_to_date (
cal_dt DATE NOT NULL OPTIONS(description='The date for which the year-to-date interval is defined.'),
incl_cal_dt DATE NOT NULL OPTIONS(description='The date that needs to be included in the year-to-date interval'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)')
)
OPTIONS(description='This table relates a calendar date to all dates that form the year-to-date interval for this date. E.g. for February 15th 2019 this is all dates from January 1st 2019 to February 15th, inclusively.');