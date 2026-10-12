--==============================================================
-- Table: T_PRODUCTION_LINE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_PRODUCTION_LINE
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCTION_LINE (
   RESOURCE_ITEM_SID                   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line',
   DWH_VALID_FROM_DT                   DATE            NOT NULL COMMENT 'The date when this record became valid.',
   DWH_VALID_TO_DT                     DATE            NOT NULL COMMENT 'The date when this record was no longer valid.',
   PLANT_RESOURCE_ITEM_SID             NUMBER(38,0)    NOT NULL COMMENT 'Id of the production plant',
   PRODUCTION_LINE_ID                  NUMBER(38,0)    NOT NULL COMMENT 'Natural Key - For SID generation and lookup',
   PRODUCTION_LINE_NAME                VARCHAR(100)    NOT NULL COMMENT 'Natural Key - Name of the production line',
   PLANT_NAME                          VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - Name of the production plant - a part of natural key to generate SID',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_PRODUCTION_LINE PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_DT) NOT ENFORCED
 )  COMMENT= 'Table with e.g. production lines of all e.g. production plants/factories';

