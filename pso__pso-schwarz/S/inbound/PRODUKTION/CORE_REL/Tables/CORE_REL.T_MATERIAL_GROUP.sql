--==============================================================
-- Table: T_MATERIAL_GROUP
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_MATERIAL_GROUP
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_MATERIAL_GROUP (
   RESOURCE_ITEM_SID                   NUMBER(38,0)    NOT NULL COMMENT 'Id of the material group',
   DWH_VALID_FROM_DT                   DATE            NOT NULL COMMENT 'The date when this record became valid.',
   DWH_VALID_TO_DT                     DATE            NOT NULL COMMENT 'The date when this record was no longer valid.',
   MATERIAL_GROUP_NR                   VARCHAR(100)    NOT NULL COMMENT 'Natural Key - Material group number as a technical identifier of the material groups from the source system/table',
   MATERIAL_GROUP_NAME                 VARCHAR(100)    COMMENT 'Name of the material group (if existing)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(250)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_MATERIAL_GROUP PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_DT) NOT ENFORCED
 )  COMMENT= 'Table with material groups (e.g. for plastic materials). Materials are consumed for a booking during e.g. a production line of a production factory/plant. Source - extracted from t_booking attribute (persistency of a degenerated dimension).';

