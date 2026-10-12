--==============================================================
-- Table: T_FACT_THRESHOLD_PARAMETER_PER_MATERIAL_REL
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_THRESHOLD_PARAMETER_PER_MATERIAL_REL
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_THRESHOLD_PARAMETER_PER_MATERIAL_REL (
   PRODUCTION_LINE_PARAMETER_RESOURCE_ITEM_SID NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line parameter',
   MATERIAL_RESOURCE_ITEM_SID          NUMBER(38,0)    NOT NULL COMMENT 'Id of the material (e.g. plasting in production plants)',
   MIN_VAL                             NUMBER(38,5)    COMMENT 'Minimum value on the scale for a chosen parameter',
   MAX_VAL                             NUMBER(38,5)    COMMENT 'Maximum value on the scale for a chosen parameter',
   LOWER_WARNING_LIMIT_VAL             NUMBER(38,5)    COMMENT 'Lower warning limit is dependent on production line parameter. Upper & lower warning limits describe a range in which the material production is considered to be optimal. In case of falling out of the range a readjustion will take place aiming to come back into the range.',
   UPPER_WARNING_LIMIT_VAL             NUMBER(38,5)    COMMENT 'Upper warning limit is dependent on production line parameter. Upper & lower warning limits describe a range in which the material production is considered to be optimal. In case of falling out of the range a readjustion will take place aiming to come back into the range.',
   TARGET_VAL                          NUMBER(38,5)    COMMENT 'Target value on the scale for a chosen parameter',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_FACT_THRESHOLD_PARAMETER_PER_MATERIAL_REL PRIMARY KEY (PRODUCTION_LINE_PARAMETER_RESOURCE_ITEM_SID, MATERIAL_RESOURCE_ITEM_SID) NOT ENFORCED
 )  COMMENT= 'Bridge Factless Facts - Periodic Snapshot - capturing the the thresholds dependent on production parameter line & material. Source: Caculated from Master Data (indirect) - Extraction from production line parameter master data from defined sensor data. Current status on 02.2022 the thresholds of all extruder & feeder speed (avg or percent) measures are dependent on material.';

