--==============================================================
-- Table: T_DATA_STRUCTURE_SIZE_TYPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_STRUCTURE_SIZE_TYPE_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_data_structure_size_type_1 (
data_struct_size_type_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying how the storage space for a data object is measured. E.g. compressed vs. uncompressed size'),
data_struct_size_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the way how the storage space for a data object is measured. E.g. compressed vs. uncompressed size'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (data_struct_size_type_cd) NOT ENFORCED
)
OPTIONS(description='The required storage space for a data structure can be measured in several ways, e.g. compressed vs. uncompressed size. Snowflake allocates space for the net data volume, for time travel and for fail safe storage. This minor entity defines the type of storage space.');