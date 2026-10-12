/* --------------------------------------------------------------------------------
   DDL for table: t_cal_hour_1
   generated from Powerdesigner on Dienstag, 19. September 2023 10:16:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cal_hour_1 (
hr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The hour of day, i.e. a number in the range from 0 to 23.'),
hr_begin_tm TIME NOT NULL
OPTIONS(description='The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59'),
hr_end_tm TIME NOT NULL
OPTIONS(description='The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (hr) NOT ENFORCED
) OPTIONS(description='This table contains the 24 hours of a day.');