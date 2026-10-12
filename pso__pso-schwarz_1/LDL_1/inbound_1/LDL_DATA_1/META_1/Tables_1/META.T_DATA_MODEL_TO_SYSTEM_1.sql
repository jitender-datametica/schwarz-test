/* --------------------------------------------------------------------------------
   DDL for table: t_data_model_to_system_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_MODEL_TO_SYSTEM_1 (
   data_model_sid                      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the data model.',
   sys_name                            VARCHAR(100)    NOT NULL COMMENT 'The name of the IT system.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_MODEL_TO_SYSTEM PRIMARY KEY (data_model_sid, sys_name, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This table stores the relation between a system and the data model which it describes.';