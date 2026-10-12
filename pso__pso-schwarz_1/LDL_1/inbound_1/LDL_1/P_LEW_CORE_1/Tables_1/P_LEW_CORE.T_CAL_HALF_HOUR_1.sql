/* --------------------------------------------------------------------------------
   DDL for table: t_cal_half_hour_1
   generated from Powerdesigner on Dienstag, 19. September 2023 10:17:15
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAL_HALF_HOUR_1 (
   half_hr                             NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_1 the minute component. ',
   hr                                  NUMBER(38,0)     NOT NULL COMMENT 'The hour of day, i.e. a number in the range from 0 to 23.',
   half_hr_begin_tm                    TIME(9)          NOT NULL COMMENT 'The start time (inclusive) of the half-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:29:59.',
   half_hr_end_tm                      TIME(9)          NOT NULL COMMENT 'The end time (inclusive) of the half-hour interval. E.g. 00:29:59 for the interval from 00:00:00 to 00:29:59.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CAL_HALF_HOUR PRIMARY KEY (half_hr) NOT ENFORCED 
)  COMMENT = 'This table contains the 48 half-hour intervals of a day.';
