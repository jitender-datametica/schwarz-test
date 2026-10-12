--==============================================================
-- Table: T_DATA_OBJECT_KEY
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_OBJECT_KEY
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DATA_OBJECT_KEY (
   DATA_OBJ_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the Data Object.',
   DATA_OBJ_KEY_TYPE_CD                VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the Data Object.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DATA_STRUCT_SID                     NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) of the data structure.',
   DATA_ELEM_SID                       NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) of the data element.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DATA_OBJ_NAT_KEY_NR                 VARCHAR(250)    NOT NULL COMMENT 'The natural key which identifies the Data Object.In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_OBJECT_KEY PRIMARY KEY (DATA_OBJ_SID, DATA_OBJ_KEY_TYPE_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Key table for the Data Object key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re-numbering in the source. That is why the key table is historized.';

