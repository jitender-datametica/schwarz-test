CREATE TABLE core_rel.T_MONTH_OF_YEAR (
   month_of_year                       NUMBER(38, 0)   NOT NULL COMMENT 'The month of the calendar year as a number using the convention January = 1 ... December = 12.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   month_of_bus_year                   NUMBER(38, 0)   NOT NULL COMMENT 'The month of the business year (starting in March for Lidl) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. ',
   month_of_year_name                  VARCHAR(100)    NOT NULL COMMENT 'The full name for the month of the year. E.g. "January"',
   month_of_short_name                 VARCHAR(100)    NOT NULL COMMENT 'The short name / abbreviation for month of the year. E.g. "Jan"',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_MONTH_OF_YEAR PRIMARY KEY (month_of_year, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity contains the names of the twelve months of the year. (January, February, ..., December)';
