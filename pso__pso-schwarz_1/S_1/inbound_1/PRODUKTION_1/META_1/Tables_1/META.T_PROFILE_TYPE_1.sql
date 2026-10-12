--==============================================================
-- Table: T_PROFILE_TYPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_PROFILE_TYPE_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_PROFILE_TYPE_1 (
   TEST_RESULT_TYPE_CD                 VARCHAR(50)     NOT NULL COMMENT 'A code identifying the type of result value that is produced by a data profiling rule.',
   TEST_RESULT_TYPE_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name for the type of result value that is produced by a data profiling rule. E.g. minimum.',
   TEST_RESULT_TYPE_DESCR              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of result value that is produced by a data profiling rule.',
   TEMPLATE_SQL_TXT                    VARCHAR(1000)   COMMENT 'In case the profiling is done via SQL, this is the template for the statement.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PROFILE_TYPE PRIMARY KEY (TEST_RESULT_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'Minor Entity - A data profiling rule returns one result value, e.g. the minimum value of a numeric column or the number of NULL values. This minor entity defines the kind of result.';

