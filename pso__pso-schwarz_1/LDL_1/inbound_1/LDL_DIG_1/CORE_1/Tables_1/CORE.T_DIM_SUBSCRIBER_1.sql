CREATE TABLE CORE.T_DIM_SUBSCRIBER_1 (
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   SUBSCR_NR                           VARCHAR(50)     COMMENT 'A customer number from original system',
   EMAIL                               VARCHAR(100)    COMMENT 'The email address_1 of the customer',
   SSO_ID                              VARCHAR(20)     COMMENT 'Single Sign on Id',
   TRACKING_TOKEN                      VARCHAR(2000)   COMMENT 'A string that is inserted in email allowing the tracking of subscriber activities',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_DIM_SUBSCRIBER PRIMARY KEY (SUBSCR_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
)
COMMENT = 'A person who is signed up for Lidl Newsletter ( does not include people who subscribed for individual products )'
DATA_RETENTION_TIME_IN_DAYS = 7
;
