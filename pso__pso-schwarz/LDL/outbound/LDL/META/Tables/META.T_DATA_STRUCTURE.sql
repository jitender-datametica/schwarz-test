/* --------------------------------------------------------------------------------
   DDL for table: t_data_structure
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_data_structure (
data_struct_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the data structure.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sys_name STRING(100) OPTIONS(description='The name of the IT system.'),
technology_name STRING(100) OPTIONS(description='The name by which the technology is known, e.g. Teradata, AVRO, etc.'),
db_name STRING(100) OPTIONS(description='The name by which the database is identified on the system.'),
schema_name STRING(100)
OPTIONS(description='The name of the schema, as it is defined in the database management system.'),
path_name STRING(100) OPTIONS(description='The full path to the file.'),
data_struct_name STRING(100) NOT NULL
OPTIONS(description='The name of the data object, i.e. depending on the type of object, the entity name, attribute name, file name, etc.'),
data_struct_descr STRING(250) OPTIONS(description='The comment text for the data structure.'),
data_struct_type_cd STRING(50) NOT NULL
OPTIONS(description='The code which identifies the subtype discriminator for data structures. It distinguishes between entities, tables, views, files and streams.'),
file_type_cd STRING(20) OPTIONS(description='The code for the subtype discriminator for files.'),
frontend_obj_type_cd STRING(20) OPTIONS(description='The code identifying the kind of frontend object.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (data_struct_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A data structure is a physical data representation that acts as a container holding other data elements, such as an entity or table or a file. It is typically used to store object terms.');