/* --------------------------------------------------------------------------------
   DDL for table: t_profile_type
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_PROFILE_TYPE (
   test_result_type_cd                 VARCHAR(20)     NOT NULL COMMENT 'A code identifying the type of result value that is produced by a data profiling rule.',
   test_result_type_name               VARCHAR(100)    NOT NULL COMMENT 'The name for the type of result value that is produced by a data profiling rule. E.g. minimum.',
   test_result_type_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of result value that is produced by a data profiling rule.',
   template_sql_txt                    VARCHAR(1000)   COMMENT 'In case the profiling is done via SQL, this is the template for the statement.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PROFILE_TYPE PRIMARY KEY (test_result_type_cd) NOT ENFORCED
 )  COMMENT= 'A data profiling rule returns one result value, e.g. the minimum value of a numeric column or the number of NULL values. This minor entity defines the kind of result.';
