/* --------------------------------------------------------------------------------
   DDL for table: t_data_model_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_MODEL_1 (
   data_model_sid                      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the data model.',
   data_model_type_cd                  VARCHAR(20)     NOT NULL COMMENT 'The code for the subtype discriminator for data models. It distinguishes between logical models and physical models.',
   data_model_name                     VARCHAR(100)    NOT NULL COMMENT 'The name that has been assigned to the model. (This is not necessarily the file name of the model file.)',
   data_model_descr                    VARCHAR(250)    COMMENT 'A textual description of the content and purpose of the data model.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_MODEL PRIMARY KEY (data_model_sid) NOT ENFORCED
 )  COMMENT= 'A data model is an abstract representation of data structures, showing their purpose and the way how they are related with each other. A data model is the blueprint for the implementation.';
