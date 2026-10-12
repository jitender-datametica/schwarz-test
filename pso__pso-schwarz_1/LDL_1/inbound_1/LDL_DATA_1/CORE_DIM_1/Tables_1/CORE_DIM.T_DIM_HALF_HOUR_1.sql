CREATE TABLE core_dim.T_DIM_HALF_HOUR_1 (
   half_hr                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier for a half-hour interval. Format: hhmm, indicating the begin time of the half-hour interval, with hh being the hour component and mm_1 the minute component. ',
   half_hr_begin_tm                    TIME(9)         COMMENT 'The start time (inclusive) of the half-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:29:59.',
   half_hr_end_tm                      TIME(9)         COMMENT 'The end time (inclusive) of the half-hour interval. E.g. 00:29:59 for the interval from 00:00:00 to 00:29:59.',
   hr                                  NUMBER(38, 0)   NOT NULL COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_HALF_HOUR PRIMARY KEY (half_hr) NOT ENFORCED
 )  COMMENT= 'This minor dimension contains the 48 half-hour intervals of a day.';
