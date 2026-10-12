/* --------------------------------------------------------------------------------
   DDL for table: T_HOUR_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_HOUR_2 (
   HR_ID                               NUMBER(38, 0)   NOT NULL COMMENT 'The hour of day, i.e.a number in the range from 0 to 23.',
   HR_BEGIN_TM                         TIME(9)         NOT NULL COMMENT 'The start time (inclusive) of the one-hour interval. E.g. 00:00:00 for the interval from 00:00:00 to 00:59:59.',
   HR_END_TM                           TIME(9)         NOT NULL COMMENT 'The end time (inclusive) of the one-hour interval. E.g. 00:59:59 for the interval from 00:00:00 to 00:59:59.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_HOUR PRIMARY KEY (HR_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - This minor dimension contains the 24 hours of a day.';
