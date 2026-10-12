CREATE TABLE CORE_OCTOPUS.T_DIM_CALENDAR_WEEK_1 (
   cy_week                             NUMBER          NOT NULL COMMENT 'A composition of (calendar_1 year + week) e.g. 201.132 = year 2011 week 32',
   cy_week_descr                       VARCHAR(100)    COMMENT 'KW 01 - KW 52',
   cy_week_prev_1w                     NUMBER          COMMENT 'A composition of (calendar_1 year + week) e.g. 201.131 = year 2011 week 31 one week previously ',
   cy_week_prev_1y                     NUMBER          COMMENT 'A composition of (calendar_1 year + week) e.g. 201.032 = year 2010 week 32 one year previously',
   cy_week_seq                         NUMBER          COMMENT 'A sequence of calendar_1 year week. 0 equals to the current week and year. ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_CALENDAR_WEEK PRIMARY KEY (cy_week) NOT ENFORCED 
)  COMMENT = 'Contains information about the year and the according week of year. A composition of (calendar_1 year + week) e.g. 201.132 = year 2011 week 32. ';
