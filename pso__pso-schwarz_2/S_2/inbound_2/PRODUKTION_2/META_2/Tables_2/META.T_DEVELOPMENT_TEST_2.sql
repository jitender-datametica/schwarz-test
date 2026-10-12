--==============================================================
-- Table: T_DEVELOPMENT_TEST_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DEVELOPMENT_TEST_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DEVELOPMENT_TEST_2 (
   TEST_SID                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a development test.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DEV_TEST_NAME                       VARCHAR(250)    NOT NULL COMMENT 'The name by which the development test_2 has been defined.',
   DEV_TEST_DESCR                      VARCHAR(250)    COMMENT 'A free text describing the character and purpose of the development test.',
   DEV_TEST_TYPE_CD                    VARCHAR(50)     NOT NULL COMMENT 'The code for the subtype discriminators for development tests. It distinguishes between unit_2 tests, integration tests and user acceptance tests.',
   TESTED_DATA_OBJ_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data object which is the target of this test.',
   TESTED_DATA_STRUCT_NAME             VARCHAR(100)    NOT NULL COMMENT 'The name of the data structure, which is the target of this test.',
   TESTED_DATA_ELEM_NAME               VARCHAR(100)    COMMENT 'The name of the data element, which is the target of this test.',
   TEST_ORIGIN_CD                      VARCHAR(50)     NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
   TEST_LIFECYCLE_STATUS_CD            VARCHAR(50)     NOT NULL COMMENT 'The code identifying the lifecycle status_2 of a test. E.g. draft, approved, expired, ...',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DEVELOPMENT_TEST PRIMARY KEY (TEST_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Major Entity - Any test_2 which are done as part of the development of new software. A development test_2 leads to a binary result, i.e. pass or fail.';

