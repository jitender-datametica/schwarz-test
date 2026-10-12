/* --------------------------------------------------------------------------------
   DDL for table: t_cal_quarter_hour_2
   generated from Powerdesigner on Dienstag, 19. September 2023 10:17:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_quarter_hour_2 (
qtr_hr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm_2 the minute component. '),
half_hr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_2 the minute component. '),
hr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The hour of day, i.e. a number in the range from 0 to 23.'),
qtr_hr_begin_tm TIME NOT NULL
OPTIONS(description='The start time (inclusive) of the quarter-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:14:59.'),
qtr_hr_end_tm TIME NOT NULL
OPTIONS(description='The end time (inclusive) of the quarter-hour interval. E.g. 00:14:59 for the interval from 00:00:00 to 00:14:59.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (qtr_hr) NOT ENFORCED
) OPTIONS(description='This table contains the 96 quarter-hour intervals of a day.');