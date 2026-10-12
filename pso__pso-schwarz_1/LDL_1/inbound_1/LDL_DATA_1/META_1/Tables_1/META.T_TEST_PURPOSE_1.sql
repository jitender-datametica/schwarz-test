/* --------------------------------------------------------------------------------
   DDL for table: t_test_purpose_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_TEST_PURPOSE_1 (
   test_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a data quality rule.',
   test_purpose_name                   VARCHAR(100)    NOT NULL COMMENT 'The name for the reason, why a test_1 has been defined.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TEST_PURPOSE PRIMARY KEY (test_sid, test_purpose_name, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity relates a test_1 to the reason, why it has been defined. Several tests may be required for a particular purpose.';