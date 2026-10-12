/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUBSCRIBER_DELETION_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 6. Oktober 2022 17:05:58
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_SUBSCRIBER_DELETION_1 (
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the subscriber',
   DELETION_TMSP                       TIMESTAMP_TZ    COMMENT 'Timestamp when the deletion request intiated',
   DELETION_TYPE                       VARCHAR(100)    COMMENT 'Deletion sent using standard or manual process',
   DELETION_COUNTRY_CD                 VARCHAR(5)      COMMENT 'Countries affected by deletion - value ''All'' affects all countries',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_SUBSCRIBER_DELETION PRIMARY KEY (SUBSCR_SID) NOT ENFORCED
 )  COMMENT= 'ETL table to support the GDPR deletions';
