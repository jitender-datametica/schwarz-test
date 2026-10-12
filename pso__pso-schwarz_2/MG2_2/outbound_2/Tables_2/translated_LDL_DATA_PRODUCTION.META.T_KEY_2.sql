CREATE OR REPLACE TABLE ldl_data_production_meta.t_key_2 (
key_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the key.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
key_name STRING(100) OPTIONS(description='The name which has been assigned to the key in the data model.'),
key_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the subtype discriminators for keys. It distinguishes between primary keys and alternate keys.'),
data_struct_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the data structure.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (key_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The key of a data structure (e.g. an entity or a table) uniquely identifies a record. The key can be composed of one or several data elements (i.e. attributes or columns).');