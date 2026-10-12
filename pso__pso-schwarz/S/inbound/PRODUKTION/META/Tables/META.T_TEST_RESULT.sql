--==============================================================
-- Table: T_TEST_RESULT
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_TEST_RESULT
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_TEST_RESULT (
   TEST_SID                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a test.',
   TEST_EXEC_TMSP                      TIMESTAMP_TZ    NOT NULL COMMENT 'The point in time when the test was executed.',
   TEST_TYPE_CD                        VARCHAR(50)     NOT NULL COMMENT 'A code identifying the subtype discriminators for tests. It distinguishes between data quality rules, data profiling, ETL audits and development tests.',
   TEST_EXEC_STATUS_CD                 VARCHAR(50)     COMMENT 'A code identifying the overall result of a test, e.g. success or failed.',
   TOTAL_REC_CNT                       NUMBER(38,0)    COMMENT 'The total number of records which were the input for this data quality check.',
   SKIPPED_REC_CNT                     NUMBER(38,0)    COMMENT 'The number of records for which the data quality check was not executed.',
   PASSED_REC_CNT                      NUMBER(38,0)    COMMENT 'The number of records which passed the data quality check.',
   FAILED_REC_CNT                      NUMBER(38,0)    COMMENT 'The number of records which failed the data quality check.',
   PROFILING_RESULT_MEAS               NUMBER(38, 5)   COMMENT 'The result value that was produced by the data profiling rule. E.g. a maximum value of 100 for a given column.',
   EXPECTED_MEAS                       NUMBER(38, 5)   COMMENT 'The expected measure. E.g. the number of files which should have been loaded.',
   OBSERVED_MEAS                       NUMBER(38, 5)   COMMENT 'The actual measure which was observed during the execution of the ETL job. E.g. the actual number of files which have been loaded.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TEST_RESULT PRIMARY KEY (TEST_SID, TEST_EXEC_TMSP) NOT ENFORCED
 )  COMMENT= 'Transactional Facts - The execution of a test leads to a result.';

