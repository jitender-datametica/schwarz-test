/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_DAY_OF_WEEK_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_DAY_OF_WEEK_2 (
   DAY_OF_WEEK_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
   DAY_OF_WEEK_SHORT_NAME              VARCHAR(100)    NOT NULL COMMENT 'The abbreviation for the weekday, e.g. Mon',
   DAY_OF_WEEK_SHORT_NAME_DE           VARCHAR(100)    COMMENT 'The abbreviation for the weekday, e.g. Mon, Die',
   DAY_OF_WEEK_SHORT_NAME_EN           VARCHAR(100)    COMMENT 'The abbreviation for the weekday, e.g. Mon, Tue',
   DAY_OF_WEEK_NAME                    VARCHAR(100)    NOT NULL COMMENT 'The full name for the weekday, e.g. Monday.',
   DAY_OF_WEEK_NAME_DE                 VARCHAR(100)    COMMENT 'The full name for the weekday, e.g. Montag',
   DAY_OF_WEEK_NAME_EN                 VARCHAR(100)    COMMENT 'The full name for the weekday, e.g. Monday.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_DAY_OF_WEEK PRIMARY KEY (DAY_OF_WEEK_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - This minor entity defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...';
