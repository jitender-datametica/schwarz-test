--==============================================================
-- Table: T_PRODUCTION_LINE_PARAMETER_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_PRODUCTION_LINE_PARAMETER_2
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCTION_LINE_PARAMETER_2 (
   RESOURCE_ITEM_SID                   NUMBER(38,0)    NOT NULL COMMENT 'Id of the parameter (e.g. for utilization)',
   DWH_VALID_FROM_DT                   DATE            NOT NULL COMMENT 'The date when this record became valid.',
   DWH_VALID_TO_DT                     DATE            NOT NULL COMMENT 'The date when this record was no longer valid.',
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   UNIT_ID                             NUMBER(38,0)    NOT NULL COMMENT 'Id of the unit_2 (e.g. material unit_2, production line parameter)',
   PRODUCTION_LINE_PARAMETER_CD        VARCHAR(50)     NOT NULL COMMENT 'Natural Key - Parameter number (numeric or alphanumeric). Parameter is generic & can hold values with different units',
   PRODUCTION_LINE_PARAMETER_NAME      VARCHAR(250)    NOT NULL COMMENT 'Natural Key - Name of the parameter',
   GRANULARITY_TYPE                    NUMBER(38,0)    NOT NULL COMMENT 'Descriptive Attribute - defines the interval in which the parameter values are delivered by sensors. e.g. 1 ,10 or 60 seconds',
   MIN_VAL                             NUMBER(38,5)    COMMENT 'Minimum value on the scale for a chosen parameter',
   MAX_VAL                             NUMBER(38,5)    COMMENT 'Maximum value on the scale for a chosen parameter',
   LOWER_WARNING_LIMIT                 NUMBER(38,5)    COMMENT 'Lower warning limit is dependent on production line parameter. Upper & lower warning limits describe a range in which the material production is considered to be optimal. In case of falling out of the range a readjustion will take place aiming to come back into the range.',
   UPPER_WARNING_LIMIT                 NUMBER(38,5)    COMMENT 'Upper warning limit is dependent on production line parameter. Upper & lower warning limits describe a range in which the material production is considered to be optimal. In case of falling out of the range a readjustion will take place aiming to come back into the range.',
   TARGET_VAL                          NUMBER(38,5)    COMMENT 'Target value on the scale for a chosen parameter',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_PRODUCTION_LINE_PARAMETER PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_DT) NOT ENFORCED
 )  COMMENT= 'Table for parameters of a production line in a plant/fabric (e.g. plastic materials), which are sensor values produced & sent to capture the production process & health status. They configurate the mechanics/functionality or utilization of a line & have thresholds. Soruce - 1. LMS via Proleit ODS (views on SQLServer delivered via Azure Data Factory), IMD (MySQL), Qualifax (MSSQLServer) / 2. Manually added as calculated from imported excel file.';

