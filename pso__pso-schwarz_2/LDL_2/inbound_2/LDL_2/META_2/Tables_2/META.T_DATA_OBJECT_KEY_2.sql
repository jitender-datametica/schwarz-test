/* --------------------------------------------------------------------------------
   DDL for table: t_data_object_key_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:27:20
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_OBJECT_KEY_2 (
   data_obj_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the Data Object.',
   data_obj_key_type_cd                VARCHAR(20)     NOT NULL COMMENT 'The code for the type of natural key which identifies the Data Object.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   data_obj_nat_key_nr                 VARCHAR(250)    NOT NULL COMMENT 'The natural key which identifies the Data Object.In case the natural key consist of several columns, all components get concatenated.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_OBJECT_KEY PRIMARY KEY (data_obj_key_type_cd, dwh_valid_from_tmsp, data_obj_nat_key_nr) NOT ENFORCED
 )  COMMENT= 'Key table for the Data Object key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re_2-numbering in the source. That is why the key table is historized.';
