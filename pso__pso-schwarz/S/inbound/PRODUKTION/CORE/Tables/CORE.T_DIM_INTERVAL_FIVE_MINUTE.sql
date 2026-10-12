--==============================================================
-- Table: T_DIM_INTERVAL_FIVE_MINUTE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_INTERVAL_FIVE_MINUTE
   generated from Powerdesigner on Montag, 26. Juni 2023 19:26:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INTERVAL_FIVE_MINUTE (
   INTERVAL_FIVE_MIN_HR                NUMBER(38,0)    NOT NULL COMMENT 'The 5 Minute interval of day, i.e.a number in the range from 0 to 301 as a number representing 5 minute intervals.',
   INTERVAL_FIVE_MIN_BEGIN_TM          TIME(9)         NOT NULL COMMENT 'The start time (inclusive) of the 5-minute interval. E.g. 00:05:01 for the interval from 00:05:01 to 00:10:00.',
   INTERVAL_FIVE_MIN_END_TM            TIME(9)         NOT NULL COMMENT 'The end time (inclusive) of the 5-minute interval. E.g. 00:10:00 for the interval from 00:05:01 to 00:10:00',
   SUMMERTIME_FG                       BOOLEAN         NOT NULL COMMENT 'Flag for summertime overlap of 1 hour between summer- & wintertime',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_DIM_INTERVAL_FIVE_MINUTE PRIMARY KEY (INTERVAL_FIVE_MIN_HR) NOT ENFORCED
 )  COMMENT= 'Minor Dimension - This minor dimension contains the 5 minutes intervalls day including sommertime flag for 1 hour overlap - Source - manually filled.';

