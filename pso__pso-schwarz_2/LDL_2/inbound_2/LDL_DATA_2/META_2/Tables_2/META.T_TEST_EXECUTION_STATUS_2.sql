/* --------------------------------------------------------------------------------
   DDL for table: t_test_execution_status_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_TEST_EXECUTION_STATUS_2 (
   test_exec_status_cd                 VARCHAR(20)     NOT NULL COMMENT 'A code identifying the overall result of a test_2, e.g. success or failed.',
   test_exec_status_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the overall result of a test_2, e.g. success or failed.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TEST_EXECUTION_STATUS PRIMARY KEY (test_exec_status_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the possible overall outcomes of a test. A test_2 may be successful or has failed. (Note that this is not the check result of an individual record!)';
