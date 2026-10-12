/* --------------------------------------------------------------------------------
   DDL for table: t_test_result_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_TEST_RESULT_1 (
   test_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a test.',
   test_exec_tmsp                      TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the test_1 was executed.',
   test_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'A code identifying the subtype discriminators for tests. It distinguishes between data quality rules, data profiling, ETL audits and development tests.',
   test_exec_status_cd                 VARCHAR(20)     COMMENT 'A code identifying the overall result of a test_1, e.g. success or failed.',
   total_rec_cnt                       NUMBER(38, 0)   COMMENT 'The total number of records which were the input for this data quality check.',
   skipped_rec_cnt                     NUMBER(38, 0)   COMMENT 'The number of records for which the data quality check was not executed.',
   passed_rec_cnt                      NUMBER(38, 0)   COMMENT 'The number of records which passed the data quality check.',
   failed_rec_cnt                      NUMBER(38, 0)   COMMENT 'The number of records which failed the data quality check.',
   profiling_result_meas               NUMBER(38, 5)   COMMENT 'The result value that was produced by the data profiling rule. E.g. a maximum value of 100 for a given column.',
   expected_meas                       NUMBER(38, 5)   COMMENT 'The expected measure. E.g. the number of files which should have been loaded.',
   observed_meas                       NUMBER(38, 5)   COMMENT 'The actual measure which was observed during the execution of the ETL job. E.g. the actual number of files which have been loaded.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TEST_RESULT PRIMARY KEY (test_sid, test_exec_tmsp) NOT ENFORCED
 )  COMMENT= 'The execution of a test_1 leads to a result.';