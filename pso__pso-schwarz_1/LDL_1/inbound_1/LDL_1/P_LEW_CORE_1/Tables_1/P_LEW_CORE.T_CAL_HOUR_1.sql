/* --------------------------------------------------------------------------------
   DDL for table: t_cal_hour_1
   generated from Powerdesigner on Dienstag, 19. September 2023 10:16:15
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAL_HOUR_1 (
   hr                                  NUMBER(38,0)     NOT NULL COMMENT 'The hour of day, i.e. a number in the range from 0 to 23.',
   hr_begin_tm                         TIME(9)          NOT NULL COMMENT 'The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59',
   hr_end_tm                           TIME(9)          NOT NULL COMMENT 'The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CAL_HOUR PRIMARY KEY (hr) NOT ENFORCED 
)  COMMENT = 'This table contains the 24 hours of a day.';
