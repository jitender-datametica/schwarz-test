--==============================================================
-- Table: T_DEVELOPMENT_TEST_TYPE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DEVELOPMENT_TEST_TYPE_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DEVELOPMENT_TEST_TYPE_2 (
   DEV_TEST_TYPE_CD                    VARCHAR(50)     NOT NULL COMMENT 'The code for the subtype discriminators for development tests. It distinguishes between unit_2 tests, integration tests and user acceptance tests.',
   DEV_TEST_TYPE_DESCR                 VARCHAR(250)    NOT NULL COMMENT 'A textual description for the subtype discriminators for development tests.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DEVELOPMENT_TEST_TYPE PRIMARY KEY (DEV_TEST_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'Minor Entity - This minor entity defines the subtype discriminators for development tests. It distinguishes between unit_2 tests, integration tests and user acceptance tests.';

