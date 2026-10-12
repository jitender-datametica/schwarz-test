--==============================================================
-- Table: T_KEY_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_KEY_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_KEY_1 (
   KEY_SID                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the key.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   KEY_NAME                            VARCHAR(100)    COMMENT 'The name which has been assigned to the key in the data model.',
   KEY_TYPE_CD                         VARCHAR(50)     NOT NULL COMMENT 'The code for the subtype discriminators for keys. It distinguishes between primary keys and alternate keys.',
   DATA_STRUCT_SID                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_KEY PRIMARY KEY (KEY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'The key of a data structure (e.g. an entity or a table) uniquely identifies a record. The key can be composed of one or several data elements (i.e. attributes or columns).';

