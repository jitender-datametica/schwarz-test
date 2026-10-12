/* --------------------------------------------------------------------------------
   DDL for table: t_test_origin_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_TEST_ORIGIN_1 (
   test_origin_cd                      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
   test_origin_descr                   VARCHAR(250)    NOT NULL COMMENT 'A textual description for the operational source which defines the test.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TEST_ORIGIN PRIMARY KEY (test_origin_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the operational sources which defines the tests. E.g. a data quality rule can be defined in the Ab Initio DQ framework or in Informatica.';
