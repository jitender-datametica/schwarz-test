/* --------------------------------------------------------------------------------
   DDL for table: t_cal_quarter_hour_1
   generated from Powerdesigner on Dienstag, 19. September 2023 10:17:32
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAL_QUARTER_HOUR_1 (
   qtr_hr                              NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier for a quarter-hour interval. Format: hhmm, indicating the begin time of the quarter-hour interval, with hh being the hour component and mm_1 the minute component. ',
   half_hr                             NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_1 the minute component. ',
   hr                                  NUMBER(38,0)     NOT NULL COMMENT 'The hour of day, i.e. a number in the range from 0 to 23.',
   qtr_hr_begin_tm                     TIME(9)          NOT NULL COMMENT 'The start time (inclusive) of the quarter-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:14:59.',
   qtr_hr_end_tm                       TIME(9)          NOT NULL COMMENT 'The end time (inclusive) of the quarter-hour interval. E.g. 00:14:59 for the interval from 00:00:00 to 00:14:59.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CAL_QUARTER_HOUR PRIMARY KEY (qtr_hr) NOT ENFORCED 
)  COMMENT = 'This table contains the 96 quarter-hour intervals of a day.';
