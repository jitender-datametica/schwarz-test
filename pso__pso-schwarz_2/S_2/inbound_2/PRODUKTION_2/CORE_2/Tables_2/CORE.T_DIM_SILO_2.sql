--==============================================================
-- Table: T_DIM_SILO_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SILO_2
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SILO_2 (
   RESOURCE_ITEM_SID                   NUMBER(38,0)    NOT NULL COMMENT 'Id of the silo (e.g. plasting in production plants)',
   DWH_VALID_FROM_DT                   DATE            NOT NULL COMMENT 'The date when this record became valid.',
   DWH_VALID_TO_DT                     DATE            NOT NULL COMMENT 'The date when this record was no longer valid.',
   SILO_CD                             VARCHAR(100)    NOT NULL COMMENT 'Natural Key - silo number as a technical identifier of the material from the source system/production line parameter master data',
   SILO_NAME                           VARCHAR(100)    NOT NULL COMMENT 'Name of the silo',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_DIM_SILO PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_DT) NOT ENFORCED
 )  COMMENT= 'Major Dimension - with silo which are docked to the production line & are delivering the granulat material for production - Source: Caculated Master Data (indirect) - Extraction from production line parameter master data from defined sensor data. (e.g. Fuellstand Silo 01 - Fuellstand Silo 14)';

