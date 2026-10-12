/* --------------------------------------------------------------------------------
   DDL for table: t_data_structure_size_type
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_STRUCTURE_SIZE_TYPE (
   data_struct_size_type_cd            VARCHAR(20)     NOT NULL COMMENT 'The code identifying how the storage space for a data object is measured. E.g. compressed vs. uncompressed size',
   data_struct_size_type_descr         VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way how the storage space for a data object is measured. E.g. compressed vs. uncompressed size',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_STRUCTURE_SIZE_TYPE PRIMARY KEY (data_struct_size_type_cd) NOT ENFORCED
 )  COMMENT= 'The required storage space for a data structure can be measured in several ways, e.g. compressed vs. uncompressed size. Snowflake allocates space for the net data volume, for time travel and for fail safe storage. This minor entity defines the type of storage space.';
