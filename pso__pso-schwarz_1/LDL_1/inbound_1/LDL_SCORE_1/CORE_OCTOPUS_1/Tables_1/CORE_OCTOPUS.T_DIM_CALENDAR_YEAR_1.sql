CREATE TABLE CORE_OCTOPUS.T_DIM_CALENDAR_YEAR_1 (
   cy                                  NUMBER          NOT NULL COMMENT 'The year ',
   cy_seq                              NUMBER          COMMENT 'The current year has the sequence number 0. The next year takes the value 1. Beginning with a negative number from 2012. ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_CALENDAR_YEAR PRIMARY KEY (cy) NOT ENFORCED 
)  COMMENT = 'Annual information is listed here. ';
