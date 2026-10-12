--==============================================================
-- Table: t_dim_calendar_year_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_calendar_year_2
   generated from Powerdesigner on Montag, 14. Oktober 2024 18:38:37
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CALENDAR_YEAR_2 (
   cy                                  NUMBER          NOT NULL COMMENT 'The year ',
   cy_seq                              NUMBER          COMMENT 'The current year has the sequence number 0. The next year takes the value 1. Beginning with a negative number from 2012. ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_CALENDAR_YEAR PRIMARY KEY (cy) NOT ENFORCED 
)  COMMENT = 'Annual information is listed here. ';
