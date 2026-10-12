CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_rel_business_year_to_date_1 (
cal_dt DATE NOT NULL OPTIONS(description='The date for which the business-year-to-date interval is defined.'),
incl_cal_dt DATE NOT NULL
OPTIONS(description='The date that needs to be included in the business-year-to-date interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (cal_dt, incl_cal_dt) NOT ENFORCED
)
OPTIONS(description='This table relates a calendar_1 date to all dates that form the business-year-to-date interval for this date. E.g. for April 15th 2019 this is all dates from March 1st 2019 to April 15th, inclusively.');