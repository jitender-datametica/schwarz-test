/* --------------------------------------------------------------------------------
   DDL for table: t_test_type_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_TEST_TYPE_2 (
   test_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'A code identifying the subtype discriminators for tests. It distinguishes between data quality rules, data profiling, ETL audits and development tests.',
   test_type_descr                     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the subtype discriminator for tests.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TEST_TYPE PRIMARY KEY (test_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the subtype discriminators for tests. It distinguishes between data quality rules, data profiling, ETL audits and development tests.';
