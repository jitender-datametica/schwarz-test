CREATE OR REPLACE TABLE ldl_data_production_meta.t_mapping_rule_2 (
map_grp_name STRING(100) NOT NULL OPTIONS(description='The name which describes the purpose of the mapping group.'),
map_name STRING(100) NOT NULL
OPTIONS(description='The name for the mapping, i.e. for the set of rules and algorithms which specify, how one or several source data structures are transformed into a target data structure. (Typically, there is one mapping for each target table.)'),
block_nr INTEGER NOT NULL OPTIONS(description='The identifier of the mapping block within a mapping'),
tgt_data_obj_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the target data object.'),
src_data_obj_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the source data object.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
transform_cd STRING(20)
OPTIONS(description='A code identifying the set of rules and algorithms which define, how a data object is converted into another data object.'),
transform_param_txt STRING(1000)
OPTIONS(description='A transformation may use a parameter, e.g. a factor for a calculation or a CROSS JOIN condition.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (map_grp_name, map_name, block_nr, src_data_obj_sid, tgt_data_obj_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A mapping rule defines how a specific target data object is derived. A mapping rule belongs to a block in a mapping. Mapping Rules can be defined on the level of data structures (a.k.a. block level transformations) or for data elements. A target data object may depend on one or on several input data objects.');