--==============================================================
-- Table: T_DIM_PRODUCTION_LINE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_PRODUCTION_LINE_2
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:11 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PRODUCTION_LINE_2 (
   RESOURCE_ITEM_SID                   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   DWH_VALID_FROM_DT                   DATE            NOT NULL COMMENT 'The date when this record became valid.',
   DWH_VALID_TO_DT                     DATE            NOT NULL COMMENT 'The date when this record was no longer valid.',
   PLANT_RESOURCE_ITEM_SID             NUMBER(38,0)    NOT NULL COMMENT 'Id of the production plant',
   PRODUCTION_LINE_ID                  NUMBER(38,0)    NOT NULL COMMENT 'Natural Key - For SID generation and lookup',
   PRODUCTION_LINE_NAME                VARCHAR(100)    NOT NULL COMMENT 'Natural Key - Name of the production line',
   PLANT_NAME                          VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - Name of the production plant- Usage for SID generation',
   REPORTING_EXPECTED_FG               BOOLEAN         COMMENT 'Descriptive Attribute - production lines are required for reporting',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_DIM_PRODUCTION_LINE PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_DT) NOT ENFORCED
 )  COMMENT= 'Major Dimension - with production lines of all production plants/factories. Source - MES via Proleit ODS (views on SQLServer delivered via Azure Data Factory).';

