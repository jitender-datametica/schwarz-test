--==============================================================
-- Table: T_DIM_MIXER_LINE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MIXER_LINE_1
   generated from Powerdesigner on Montag, 25. November 2024 10:51:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MIXER_LINE_1 (
   RESOURCE_ITEM_SID                   NUMBER(38,0)    NOT NULL COMMENT 'Id of the material mixer line (e.g. mixer line of a production line in a plant)',
   DWH_VALID_FROM_DT                   DATE            NOT NULL COMMENT 'The date when this record became valid.',
   DWH_VALID_TO_DT                     DATE            NOT NULL COMMENT 'The date when this record was no longer valid.',
   PRODUCTION_LINE_RESOURCE_ITEM_SID   NUMBER(38,0)    NOT NULL COMMENT 'Id of the production line (e.g. production line in a plant)',
   MIXER_LINE_CD                       VARCHAR(100)    NOT NULL COMMENT 'Natural Key - code as a technical identifier of the material mixer line from the source system/production line parameter master data',
   MIXER_LINE_NAME                     VARCHAR(100)    NOT NULL COMMENT 'Name of the material mixer line',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
   CONSTRAINT PK_T_DIM_MIXER_LINE PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_DT) NOT ENFORCED
 )  COMMENT= 'Major Dimension - Material-Mixer line (Material-Mischerstrang) are technical constructions as a part of a production line (up to 4 pieces). They are permanently connected to the production line. A silo can be flexibly docked mixer line for delivering the granulat material. Source: Caculated Master Data (indirect) - Extraction from production line parameter master data from defined sensor data. (e.g. Paramter MVA_L2_0_MAG01_164 - MVA_L2_0_MAG01_170 with description Mischer 1 Quelle 1 - Mischer 1 Quelle 4)';

