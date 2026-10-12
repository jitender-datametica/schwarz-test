CREATE TABLE CORE_REL.T_STORE_OPENING_HOURS (
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store.',
   day_of_week                         NUMBER(38, 0)   NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   open_tm                             TIME(9)         NOT NULL COMMENT 'The time (in the local time zone) when the store opens.',
   close_tm                            TIME(9)         NOT NULL COMMENT 'The time (in the local time zone) when the store closes.',
   break_start_tm                      TIME(9)         COMMENT 'In case the store closes over lunch time, this is the start time of the break.',
   break_end_tm                        TIME(9)         COMMENT 'In case the store closes over lunch time, this is the end time of the break.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_STORE_OPENING_HOURS PRIMARY KEY (day_of_week, store_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the opening times of a store for each weekday.';