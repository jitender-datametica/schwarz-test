--==============================================================
-- Table: t_calendar_date
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_calendar_date
   generated from Powerdesigner on Montag, 14. Oktober 2024 15:02:11
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CALENDAR_DATE (
   cal_dt                              DATE            NOT NULL COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   day_of_week                         NUMBER          COMMENT 'Day within the year 1-7',
   weekend_fg                          BOOLEAN         COMMENT 'The flag indicates whether is is a Saturday or Sunday. ',
   day_of_cy                           NUMBER          COMMENT 'Day within the year 1-365',
   cy_month                            NUMBER          COMMENT 'Month identifier 1-12 in composition with the year',
   month_of_year                       NUMBER          NOT NULL COMMENT 'Month 1-12 (January = 1, ..., December = 12)',
   cy_week                             NUMBER          COMMENT 'A composition of (calendar year + week) e.g. 201.132 = year 2011 week 32',
   cy                                  NUMBER          NOT NULL COMMENT 'Calendar year',
   bus_year                            NUMBER          NOT NULL COMMENT 'The business year at Lidl from March to February and thus begins on 01.03',
   cal_dt_prev_7d                      DATE            COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse - 7 days',
   cal_dt_swday_prev_1y                DATE            COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse - 1 year',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_CALENDAR_DATE PRIMARY KEY (cal_dt) NOT ENFORCED 
)  COMMENT = 'Is the calendar table which separates the according months, days, years and weeks. ';
