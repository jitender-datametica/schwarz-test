/* --------------------------------------------------------------------------------
   DDL for table: t_test_lifecycle_status_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_TEST_LIFECYCLE_STATUS_2 (
   test_lifecycle_status_cd            VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status_2 of a test. E.g. draft, approved, expired, ...',
   test_lifecycle_status_descr         VARCHAR(250)    NOT NULL COMMENT 'A textual description for the lifecycle status_2 of a test.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TEST_LIFECYCLE_STATUS PRIMARY KEY (test_lifecycle_status_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the lifecycle status_2 of a test. E.g. it shows, if a data quality rule is in draft, if it has been approved, or if it has been expired.';
