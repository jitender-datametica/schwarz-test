CREATE TABLE IF NOT EXISTS ldl_dig_core.t_cal_cum_week_to_date (
cal_dt DATE NOT NULL OPTIONS(description='The date for which the week-to-date interval is defined.'),
incl_cal_dt DATE NOT NULL OPTIONS(description='The date that needs to be included in the week-to-date interval'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)')
)
OPTIONS(description='This table relates a calendar date to all dates that form the week-to-date interval for this date. E.g. for Wednesday, July 24th 2019, this is Monday, July 22nd 2019, Tuesday, July 23rd 2019, and Wednesday, July 24th 2019.');