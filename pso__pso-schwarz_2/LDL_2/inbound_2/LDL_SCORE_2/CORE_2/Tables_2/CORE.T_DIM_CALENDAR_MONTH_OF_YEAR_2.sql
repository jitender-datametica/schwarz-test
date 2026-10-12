--==============================================================
-- Table: t_dim_calendar_month_of_year_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_calendar_month_of_year_2
   generated from Powerdesigner on Montag, 14. Oktober 2024 18:29:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CALENDAR_MONTH_OF_YEAR_2 (
   month_of_year                       NUMBER          NOT NULL COMMENT 'Month 1-12 (January = 1, ..., December = 12)',
   month_of_year_descr                 VARCHAR(100)    COMMENT 'The month in the year (written out)',
   month_of_year_short_descr           VARCHAR(100)    COMMENT 'The month in the year (abbreviated)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_CALENDAR_MONTH_OF_YEAR PRIMARY KEY (month_of_year) NOT ENFORCED 
)  COMMENT = 'Represents the twelve months of the year. Contains the german description and an abbreviated field. ';
