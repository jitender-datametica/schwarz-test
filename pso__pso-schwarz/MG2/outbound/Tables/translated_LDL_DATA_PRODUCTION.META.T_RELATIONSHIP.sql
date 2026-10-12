CREATE OR REPLACE TABLE ldl_data_production_meta.t_relationship (
rel_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the relationship'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
rel_name STRING(100) OPTIONS(description='The name for the relationship, as it has been defined in the data model'),
cardinality_cd STRING(5) NOT NULL OPTIONS(description='A code identifying the cardinality, i.e. 1:1, 1:n or n:m'),
data_struct_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the first data structure.'),
data_struct_nullable_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the (first) data object is optional, If it is false, then a relationship must exist for each instance of the first data object.'),
rel_data_struct_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the second data structure.'),
rel_data_struct_nullable_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the related (second) data object is optional. If it is false, then a relationship must exist for each instance of the second data object.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (rel_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A relationship connects two data structures (of the same type). ');