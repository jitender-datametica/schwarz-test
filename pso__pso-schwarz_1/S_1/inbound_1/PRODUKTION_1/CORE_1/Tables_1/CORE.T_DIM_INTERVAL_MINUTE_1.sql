--==============================================================
-- Table: T_DIM_INTERVAL_MINUTE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_INTERVAL_MINUTE_1
   generated from Powerdesigner on Montag, 26. Juni 2023 19:26:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INTERVAL_MINUTE_1 (
   INTERVAL_MIN_HR                     NUMBER(38,0)    NOT NULL COMMENT 'The 1 Minute interval of day, i.e.a number in the range from 0 to 1499 as a number representing 1 minute intervals with uniqueness based on end time & summertime flag. Intervalls are approximated to full minute like ''00:01:00'' as end time.',
   INTERVAL_MIN_BEGIN_TM               TIME(9)         NOT NULL COMMENT 'The start time (inclusive) of the 1-minute interval. E.g. 00:00:01 for the interval from 00:00:01 to 00:01:00.',
   INTERVAL_MIN_END_TM                 TIME(9)         NOT NULL COMMENT 'The end time (inclusive) of the 1-minute interval. E.g. 00:01:00 for the interval from 00:00:01 to 00:01:00',
   SUMMERTIME_FG                       BOOLEAN         NOT NULL COMMENT 'Flag for summertime overlap of 1 hour between summer- & wintertime',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_DIM_INTERVAL_MINUTE PRIMARY KEY (INTERVAL_MIN_HR) NOT ENFORCED
 )  COMMENT= 'Minor Dimension - This minor dimension contains the 1 minute intervalls day including sommertime flag for 1 hour overlap - Source - manually filled.';

