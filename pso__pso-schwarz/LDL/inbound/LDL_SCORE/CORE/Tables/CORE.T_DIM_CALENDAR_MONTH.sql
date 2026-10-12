--==============================================================
-- Table: t_dim_calendar_month
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_calendar_month
   generated from Powerdesigner on Montag, 14. Oktober 2024 18:33:04
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CALENDAR_MONTH (
   cy_month                            NUMBER          NOT NULL COMMENT 'Month identifier 1-12 in composition with the year',
   month_of_year                       NUMBER          NOT NULL COMMENT 'Month 1-12 (January = 1, ..., December = 12)',
   cy                                  NUMBER          NOT NULL COMMENT 'The year ',
   bus_year                            NUMBER          NOT NULL COMMENT 'The business year at Lidl from March to February and thus begins on 01.03',
   cy_month_seq                        NUMBER          COMMENT 'The current month has the sequence number 0. The next month takes the value 1. Beginning with a negative number from January 2012. ',
   cy_month_descr                      VARCHAR(100)    COMMENT 'The month and the year (written out)',
   cy_month_short_descr                VARCHAR(100)    COMMENT 'The month and the year (abbreviated)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_CALENDAR_MONTH PRIMARY KEY (cy_month) NOT ENFORCED 
)  COMMENT = 'Contains the year in combination with the corresponding month. ';
