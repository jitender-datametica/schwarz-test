--==============================================================
-- Table: T_DATA_QUALITY_RULE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_QUALITY_RULE_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DATA_QUALITY_RULE_2 (
   TEST_SID                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a data quality rule.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DQ_RULE_NAME                        VARCHAR(250)    NOT NULL COMMENT 'The name by which the data quality rule has been defined.',
   DQ_RULE_DESCR                       VARCHAR(250)    COMMENT 'A free text describing the character and purpose of the data quality rule.',
   DQ_RULE_TYPE_CD                     VARCHAR(50)     NOT NULL COMMENT 'A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.',
   DQ_RULE_TEMPLATE_SID                NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the template which was used to generate a formal data quality rule.',
   DQ_RULE_TEMPLATE_NAME               VARCHAR(100)    COMMENT 'The name of the template script which was used to generate a formal data quality rule.',
   TESTED_DATA_OBJ_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data object which is the target of this test.',
   TESTED_DATA_STRUCT_NAME             VARCHAR(100)    NOT NULL COMMENT 'The name of the data structure, which is the target of this test.',
   TESTED_DATA_ELEM_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name of the data element, which is the target of this test.',
   TEST_ORIGIN_CD                      VARCHAR(50)     NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
   TEST_LIFECYCLE_STATUS_CD            VARCHAR(50)     NOT NULL COMMENT 'The code identifying the lifecycle status_2 of a test. E.g. draft, approved, expired, ...',
   SCHEDULING_FREQ_CD                  VARCHAR(50)     COMMENT 'A code defining, how often the data quality rule is executed. E.g daily, weekly, ...',
   DQ_DIMENSION_CD                     VARCHAR(50)     NOT NULL COMMENT 'A code identifying the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.',
   RULE_PRIO                           NUMBER(38, 0)   COMMENT 'Optionally, a weight can be assigned to a data quality rule. In an aggregation the results of the rule are weighted accordingly.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_QUALITY_RULE PRIMARY KEY (TEST_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Major Entity - A data quality rule checks, if records conform to a certain condition. E.g. prices must be positive, or referential integrity. A data quality rule returns the number of records that have passed the check, and the number of records which have failed the check.';

