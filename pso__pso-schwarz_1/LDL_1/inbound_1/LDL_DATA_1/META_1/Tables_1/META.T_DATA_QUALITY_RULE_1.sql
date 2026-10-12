/* --------------------------------------------------------------------------------
   DDL for table: t_data_quality_rule_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_QUALITY_RULE_1 (
   test_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a data quality rule.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dq_rule_name                        VARCHAR(250)    NOT NULL COMMENT 'The name by which the data quality rule has been defined.',
   dq_rule_descr                       VARCHAR(250)    COMMENT 'A free text describing the character and purpose of the data quality rule.',
   dq_rule_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.',
   dq_rule_template_sid                NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the template which was used to generate a formal data quality rule.',
   dq_rule_template_name               VARCHAR(100)    COMMENT 'The name of the template script which was used to generate a formal data quality rule.',
   tested_data_obj_sid                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data object which is the target of this test.',
   tested_data_struct_name             VARCHAR(100)    NOT NULL COMMENT 'The name of the data structure, which is the target of this test.',
   tested_data_elem_name               VARCHAR(100)    NOT NULL COMMENT 'The name of the data element, which is the target of this test.',
   test_origin_cd                      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
   test_lifecycle_status_cd            VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status_1 of a test. E.g. draft, approved, expired, ...',
   scheduling_freq_cd                  VARCHAR(20)     COMMENT 'A code defining, how often the data quality rule is executed. E.g daily, weekly, ...',
   dq_dimension_cd                     VARCHAR(20)     NOT NULL COMMENT 'A code identifying the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.',
   rule_prio                           NUMBER(38, 0)   COMMENT 'Optionally, a weight can be assigned to a data quality rule. In an aggregation the results of the rule are weighted accordingly.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_QUALITY_RULE PRIMARY KEY (test_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A data quality rule checks, if records conform to a certain condition. E.g. prices must be positive, or referential integrity. A data quality rule returns the number of records that have passed the check, and the number of records which have failed the check.';
