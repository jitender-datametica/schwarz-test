/* --------------------------------------------------------------------------------
   DDL for table: t_development_test_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DEVELOPMENT_TEST_1 (
   test_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a development test.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dev_test_name                       VARCHAR(250)    NOT NULL COMMENT 'The name by which the development test_1 has been defined.',
   dev_test_descr                      VARCHAR(250)    COMMENT 'A free text describing the character and purpose of the development test.',
   dev_test_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the subtype discriminators for development tests. It distinguishes between unit_1 tests, integration tests and user acceptance tests.',
   tested_data_obj_sid                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data object which is the target of this test.',
   tested_data_struct_name             VARCHAR(100)    NOT NULL COMMENT 'The name of the data structure, which is the target of this test.',
   tested_data_elem_name               VARCHAR(100)    COMMENT 'The name of the data element, which is the target of this test.',
   test_origin_cd                      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
   test_lifecycle_status_cd            VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status_1 of a test. E.g. draft, approved, expired, ...',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DEVELOPMENT_TEST PRIMARY KEY (test_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'Any test_1 which are done as part of the development of new software. A development test_1 leads to a binary result, i.e. pass or fail.';
