--==============================================================
-- Table: T_DATA_STRUCTURE_RELATION_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_STRUCTURE_RELATION_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DATA_STRUCTURE_RELATION_2 (
   DATA_STRUCT_SID                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
   BASE_DATA_STRUCT_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
   DATA_STRUCT_REL_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The code for the way how one data structure forms the base for another data structure.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_STRUCTURE_RELATION PRIMARY KEY (DATA_STRUCT_SID, BASE_DATA_STRUCT_SID, DWH_VALID_FROM_TMSP, DATA_STRUCT_REL_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'This table links data structures to their related base structures. This includes the following scenarios: (1) An external table is based on a file. (2) A view is based on one or several tables or other views. (3) A schema definition file defines the structure of a data file. (4) The hierarchy_2 of frontend objects. (The type of relationship is defined by the relationship type code.)';

