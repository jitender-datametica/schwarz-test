/* --------------------------------------------------------------------------------
   DDL for table: t_data_profiling_rule_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_PROFILING_RULE_2 (
   test_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a data profiling rule.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   profiling_rule_name                 VARCHAR(250)    NOT NULL COMMENT 'The name by which the data profiling rule has been defined.',
   profiling_rule_descr                VARCHAR(250)    COMMENT 'A free text describing the character and purpose of the data profiling rule.',
   tested_data_obj_sid                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data object which is the target of this test.',
   tested_data_struct_name             VARCHAR(100)    NOT NULL COMMENT 'The name of the data structure, which is the target of this test.',
   tested_data_elem_name               VARCHAR(100)    NOT NULL COMMENT 'The name of the data element, which is the target of this test.',
   test_result_type_cd                 VARCHAR(20)     NOT NULL COMMENT 'A code identifying the type of result value that is produced by a data profiling rule.',
   test_origin_cd                      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
   test_lifecycle_status_cd            VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status_2 of a test. E.g. draft, approved, expired, ...',
   scheduling_freq_cd                  VARCHAR(20)     COMMENT 'A code defining, how often the data profiling rule is executed. E.g daily, weekly, ...',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_PROFILING_RULE PRIMARY KEY (test_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'Data profiling assesses data demographics, such as minimum and maximum values, the number of distinct values or the number of NULL values. (Note that a data profiling rule only returns only one result value, e.g. the minimum value of a column. For calculating the maximum value, a second rule is required.)';
