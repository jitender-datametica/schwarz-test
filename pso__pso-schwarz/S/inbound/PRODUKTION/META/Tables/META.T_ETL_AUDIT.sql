--==============================================================
-- Table: T_ETL_AUDIT
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_ETL_AUDIT
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_ETL_AUDIT (
   TEST_SID                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for an ETL audit.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   ETL_AUDIT_NAME                      VARCHAR(250)    NOT NULL COMMENT 'The name by which the ETL audit has been defined.',
   ETL_AUDIT_DESCR                     VARCHAR(250)    COMMENT 'A free text describing the character and purpose of the ETL audit.',
   TESTED_DATA_OBJ_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data object which is the target of this test.',
   TESTED_DATA_STRUCT_NAME             VARCHAR(100)    NOT NULL COMMENT 'The name of the data structure, which is the target of this test.',
   TESTED_DATA_ELEM_NAME               VARCHAR(100)    COMMENT 'The name of the data element, which is the target of this test.',
   TEST_ORIGIN_CD                      VARCHAR(50)     NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
   TEST_LIFECYCLE_STATUS_CD            VARCHAR(50)     NOT NULL COMMENT 'The code identifying the lifecycle status of a test. E.g. draft, approved, expired, ...',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_ETL_AUDIT PRIMARY KEY (TEST_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Major Entity - An ETL audit monitors the execution of an ETL job. E.g. it checks the number of files which have been processed or the number of new surrogate keys that were generated. In general, an ETL audit compares an observed measure with an expected value.';

