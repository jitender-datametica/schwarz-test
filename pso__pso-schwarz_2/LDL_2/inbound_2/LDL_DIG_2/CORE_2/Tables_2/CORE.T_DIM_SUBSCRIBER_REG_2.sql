CREATE TABLE CORE.T_DIM_SUBSCRIBER_REG_2 (
   COUNTRY_CD                          VARCHAR(5)      NOT NULL COMMENT 'The unique code for a country_2 according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   SUBSCR_NR                           VARCHAR(50)     COMMENT 'A customer number from original system',
   PHONE_NR                            VARCHAR(100)    COMMENT 'The phone number of the customer',
   SUBSCR_SALUTATION                   VARCHAR(100)    COMMENT 'The salutation of the customer',
   SUBSCR_FIRST_NAME                   VARCHAR(100)    COMMENT 'The first name of the customer',
   SUBSCR_LAST_NAME                    VARCHAR(100)    COMMENT 'The last name of the customer',
   SUBSCR_BIRTH_DT                     DATE            COMMENT 'The birth date of the customer',
   SUBSCR_PERMISSION_LVL               NUMBER          COMMENT 'Permission Level - the version of terms and conditions signed by user',
   LAN_CD                              VARCHAR(5)      COMMENT 'The code for the language',
   LOCALE_NAME                         VARCHAR(100)    COMMENT 'The locale used by users (de_de, cz_z, de_en , etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_DIM_SUBSCRIBER_REG PRIMARY KEY (COUNTRY_CD, SUBSCR_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'A person who is signed up for Lidl Newsletter ( does not include people who subscribed for individual products ). One person can subscribe to newsletter in multiple countries.'
DATA_RETENTION_TIME_IN_DAYS = 7
;
