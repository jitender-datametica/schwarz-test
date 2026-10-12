CREATE TABLE CORE_OCTOPUS.T_DIM_CALENDAR_DAY_OF_WEEK (
   day_of_week                         NUMBER          NOT NULL COMMENT 'Day within the year 1-7',
   day_of_week_descr                   VARCHAR(100)    COMMENT 'Name of the day Montag-Sonntag',
   day_of_week_short_descr             VARCHAR(100)    COMMENT 'Name of the day Mo-So (short)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_CALENDAR_DAY_OF_WEEK PRIMARY KEY (day_of_week) NOT ENFORCED 
)  COMMENT = 'All seven days of the week are listed and numerated by their names.';
