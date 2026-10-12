--==============================================================
-- Table: t_dim_calendar_day_of_week_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_calendar_day_of_week_1
   generated from Powerdesigner on Montag, 14. Oktober 2024 18:40:00
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CALENDAR_DAY_OF_WEEK_1 (
   day_of_week                         NUMBER          NOT NULL COMMENT 'Day within the year 1-7',
   day_of_week_descr                   VARCHAR(100)    COMMENT 'Name of the day Montag-Sonntag',
   day_of_week_short_descr             VARCHAR(100)    COMMENT 'Name of the day Mo-So (short)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_CALENDAR_DAY_OF_WEEK PRIMARY KEY (day_of_week) NOT ENFORCED 
)  COMMENT = 'All seven days of the week are listed and numerated by their names.';
