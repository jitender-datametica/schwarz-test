--==============================================================
-- Table: T_KEY_COMPONENT_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_KEY_COMPONENT_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_KEY_COMPONENT_1 (
   KEY_SID                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the key.',
   DATA_ELEM_SID                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data element.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_KEY_COMPONENT PRIMARY KEY (KEY_SID, DATA_ELEM_SID) NOT ENFORCED
 )  COMMENT= 'A key consists of one or several data elements.';

